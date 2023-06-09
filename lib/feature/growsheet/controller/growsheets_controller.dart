import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/growsheet/model/create_growsheet.dart';
import 'package:scimetic/feature/growsheet/model/growsheet_model.dart';
import 'package:scimetic/feature/growsheet/model/option_model.dart';

class GrowSheetController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController strainNameController = TextEditingController();
  final TextEditingController seedBankController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final TextEditingController dayTemperatureController = TextEditingController();
  final TextEditingController dayRhController = TextEditingController();
  final TextEditingController dayCo2Controller = TextEditingController();
  final TextEditingController dayLightOnHourController = TextEditingController();
  final TextEditingController dayLightOnMinuteController = TextEditingController();
  final TextEditingController dayLightOffHourController = TextEditingController();
  final TextEditingController dayLightOffMinuteController = TextEditingController();
  final TextEditingController dayDeadbandTemperatureController = TextEditingController();
  final TextEditingController dayDeadbandHumidityController = TextEditingController();
  final TextEditingController dayDeadbandCo2Controller = TextEditingController();

  final TextEditingController nightTemperatureController = TextEditingController();
  final TextEditingController nightRhController = TextEditingController();
  final TextEditingController nightCo2Controller = TextEditingController();
  final TextEditingController nightLightOnHourController = TextEditingController();
  final TextEditingController nightLightOnMinuteController = TextEditingController();
  final TextEditingController nightLightOffHourController = TextEditingController();
  final TextEditingController nightLightOffMinuteController = TextEditingController();
  final TextEditingController nightDeadbandTemperatureController = TextEditingController();
  final TextEditingController nightDeadbandHumidityController = TextEditingController();
  final TextEditingController nightDeadbandCo2Controller = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  RxBool isValid = true.obs;

  RxBool isCheckAll = false.obs;

  RxBool isSelect = false.obs;

  RxString errorMessage = "".obs;

  RxBool isEdit = false.obs;

  IgationControl irrigationValue = IgationControl();

  RxBool isIrrigation = false.obs;

  RxInt growControllerId = 0.obs;

  RxInt irrigationId = 0.obs;

  List<IgationControl> irrigationList = [];

  IgationControl fertigationValue1 = IgationControl();

  RxBool isFertigation1 = false.obs;

  RxInt fertigationId1 = 0.obs;

  List<IgationControl> fertigationList1 = [];

  IgationControl fertigationValue2 = IgationControl();

  RxBool isFertigation2 = false.obs;

  RxInt fertigationId2 = 0.obs;

  List<IgationControl> fertigationList2 = [];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  GrowSheetData growSheetData = GrowSheetData();

  OptionModel optionModel = OptionModel();

  RxList growSheetDataList = [].obs;

  List<Growsheet> mainList = [];

  List<int> growsheetIds = [];

  RxBool isGetData = false.obs;

  List<RxBool> appliedList = [];

  List<RxBool> selectList = [];

  RxBool isApply = false.obs;

  RxInt growSheetId = 0.obs;

  RxInt id = 0.obs;

  Future getGrowSheetData() async {

    isGetData.value = false;

    growSheetDataList.clear();

    mainList.clear();

    appliedList.clear();

    selectList.clear();

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetGrowController}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if ( apiResponse!.statusCode == 200 ) {

          growSheetData = GrowSheetData.fromJson(data);

          if ( growSheetData.growsheets!.isNotEmpty ) {
            mainList.addAll(growSheetData.growsheets!);
            growSheetDataList.addAll(growSheetData.growsheets!);
            appliedList = List.generate(growSheetDataList.length, (index) => false.obs);
            selectList = List.generate(growSheetDataList.length, (index) => false.obs);
          }

          if ( growSheetDataList.isNotEmpty && appliedList.isNotEmpty ) {
            for ( int i = 0; i < growSheetDataList.length; i++ ) {
              Growsheet data = growSheetDataList[i];
              for ( int j = 0; j < appliedList.length; j++ ) {
                if ( data.applied == true && i == j ) {
                  appliedList[j].value = true;
                }
              }
            }
          }

          AppConst().debug('grow sheet data => ${growSheetData.growsheets}');

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return true;

        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

  Future getFormOption() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetFormOptions}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          optionModel = OptionModel.fromJson(data);

           if ( optionModel.irrigationControls!.isNotEmpty ) {

             isIrrigation.value = false;

             for (var element in optionModel.irrigationControls!) {
               irrigationList.clear();
               irrigationList.add(element);
               isIrrigation.value = true;
             }

             AppConst().debug("irrigation list length => ${irrigationList.length}");
           }

           if ( optionModel.fertigationControls!.isNotEmpty ) {

             for (var element in optionModel.fertigationControls!) {
               fertigationList2.clear();
               fertigationList1.clear();
               fertigationList1.add(element);
               fertigationList2.add(element);
             }

             AppConst().debug("fertigation list length => ${fertigationList1.length}");
             AppConst().debug("fertigation list length => ${fertigationList2.length}");

           }

          return true;
        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

  Future createGrowSheet({required CreateGrowSheet createGrowSheet}) async {

    growControllerId.value = storeData.getInt(StoreData.id)!;

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
          url: "${ApiPath.baseUrl}${ApiPath.growSheetGrowController}/${growControllerId.value}",
          requestType: HTTPRequestType.POST,
          headers: {
            "Authorization" : 'Bearer $token',
            "Content-Type" : "application/json"
          },
          parameter: createGrowSheet.toJson()
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.statusCode}");

      dynamic data = jsonDecode(apiResponse!.body);

      if ( apiResponse!.statusCode == 200 ) {
        return true;
      } else {

        if ( apiResponse!.statusCode == 403 ) {

          showSnack(
              width: 200.w,
              title: data["message"]
          );
        }

        return false;
      }

    } catch (e) {

      AppConst().debug(e.toString());

    }
  }

  Future deleteGrowSheet() async {

    bool isConnected = await checkNetConnectivity();

    if ( isConnected == true ) {

      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: "${ApiPath.baseUrl}${ApiPath.growSheet}",
              requestType: HTTPRequestType.DELETE,
              headers: {
                "Authorization": 'Bearer $token',
                "Content-Type" : "application/json"
              },
            parameter: {
                "growsheetIds" : growsheetIds
            }
          );

          apiResponse =
          await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

          if (apiResponse!.statusCode == 200) {

            return true;
          } else {
            if (apiResponse!.statusCode == 403) {
              showSnack(
                  width: 200.w,
                  title: data["message"]
              );
            }

            return false;
          }
        } catch (e) {
          AppConst().debug(e.toString());
        }
      }
    } else {
      showSnack(
          title: AppStrings.noInternetConnection,
          width: 200.w
      );
    }

  }

  Future updateGrowSheet({ required CreateGrowSheet createGrowSheet}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: "${ApiPath.baseUrl}${ApiPath.growSheet}/${growSheetId.value}",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: createGrowSheet.toJson()
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return true;
        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

  Future toggleApply({required int id, required bool applied}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      progressDialog(true, Get.context!);

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: "${ApiPath.baseUrl}${ApiPath.growSheet}/$id/toggle_apply",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: {
              "applied": applied
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if ( apiResponse!.statusCode == 200 ) {

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return true;
        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }
  }

  void onSave() async {

    isValid.value = true;

    if ( strainNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( seedBankController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( tagController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayRhController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightOnMinuteController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightOnHourController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightOffMinuteController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightOffHourController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayCo2Controller.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayDeadbandTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayDeadbandHumidityController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayDeadbandCo2Controller.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightRhController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightOnMinuteController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightOnHourController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightOffMinuteController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightOffHourController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightCo2Controller.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightDeadbandTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightDeadbandHumidityController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightDeadbandCo2Controller.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( descriptionController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        AppConst().debug("select irrigation id => ${irrigationId.value}");
        AppConst().debug("select fertigation id => ${fertigationId1.value}");
        AppConst().debug("select fertigation id => ${fertigationId2.value}");

        CreateGrowSheet data = CreateGrowSheet();

        data.strain = strainNameController.text;
        data.description = descriptionController.text;
        data.seedBank = seedBankController.text;
        data.tag = tagController.text;
        data.dayTargetTemperature = double.parse(dayTemperatureController.text);
        data.dayTemperatureDeadband = double.parse(dayDeadbandTemperatureController.text);
        data.dayTargetRelativeHumidity = double.parse(dayRhController.text);
        data.dayHumidityDeadband = double.parse(dayDeadbandHumidityController.text);
        data.dayTargetCo2 = double.parse(dayCo2Controller.text);
        data.dayCo2Deadband = double.parse(dayDeadbandCo2Controller.text);
        data.dayLightTimeOn = dayLightOnHourController.text.isNotEmpty ? "${dayLightOnHourController.text}"
            ":${dayLightOnMinuteController.text}" : "";
        data.dayLightTimeOff = dayLightOffHourController.text.isNotEmpty ? "${dayLightOffHourController.text}"
            ":${dayLightOffMinuteController.text}" : "";
        data.nightTargetTemperature = double.parse(nightTemperatureController.text);
        data.nightTemperatureDeadband = double.parse(nightDeadbandTemperatureController.text);
        data.nightTargetRelativeHumidity = double.parse(nightRhController.text);
        data.nightHumidityDeadband = double.parse(nightDeadbandHumidityController.text);
        data.nightTargetCo2 = double.parse(nightCo2Controller.text);
        data.nightCo2Deadband = double.parse(nightDeadbandCo2Controller.text);
        data.nightLightTimeOn = nightLightOnHourController.text.isNotEmpty ? "${nightLightOnHourController.text}"
            ":${nightLightOnMinuteController.text}" : "";
        data.nightLightTimeOff = nightLightOffHourController.text.isNotEmpty ? "${nightLightOffHourController.text}"
            ":${nightLightOffMinuteController.text}" : "";
        data.applied = false;

        if ( irrigationList.isNotEmpty ) {
          AppConst().debug("select irrigation id => ${irrigationValue.id}");
          data.irrigationControlId = irrigationId.value;
        }

        if ( fertigationList1.isNotEmpty ) {
          data.fertigationControlId01 = fertigationId1.value;
        }

        if ( fertigationList2.isNotEmpty ) {
          data.fertigationControlId02 = fertigationId2.value;
        }

        if ( isEdit.value == false ) {

          await createGrowSheet(createGrowSheet: data)
              .whenComplete(() {
            Get.back();
            getGrowSheetData();
          });

        } else {

          await updateGrowSheet( createGrowSheet: data ).whenComplete(() {
            Get.back();
            getGrowSheetData();
          });
        }

        strainNameController.clear();
        tagController.clear();
        descriptionController.clear();
        seedBankController.clear();
        dayDeadbandCo2Controller.clear();
        dayDeadbandHumidityController.clear();
        dayDeadbandTemperatureController.clear();
        dayCo2Controller.clear();
        dayLightOffHourController.clear();
        dayLightOffMinuteController.clear();
        dayLightOnHourController.clear();
        dayLightOnMinuteController.clear();
        dayRhController.clear();
        dayTemperatureController.clear();
        nightDeadbandCo2Controller.clear();
        nightDeadbandHumidityController.clear();
        nightDeadbandTemperatureController.clear();
        nightCo2Controller.clear();
        nightLightOffHourController.clear();
        nightLightOffMinuteController.clear();
        nightLightOnHourController.clear();
        nightLightOnMinuteController.clear();
        nightRhController.clear();
        nightTemperatureController.clear();

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }

    }

  }

}