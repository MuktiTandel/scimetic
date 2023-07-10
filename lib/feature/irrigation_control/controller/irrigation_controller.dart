import 'dart:convert';

import 'package:flutter/material.dart';
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
import 'package:scimetic/feature/irrigation_control/model/irrigation_control_model.dart';
import 'package:scimetic/feature/irrigation_control/model/irrigation_model.dart';

class IrrigationController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController day100TemperatureController =
      TextEditingController();
  final TextEditingController day100DurationController =
      TextEditingController();
  final TextEditingController night100TemperatureController =
      TextEditingController();
  final TextEditingController night100DurationController =
      TextEditingController();
  final TextEditingController day0TemperatureController =
      TextEditingController();
  final TextEditingController day0DurationController = TextEditingController();
  final TextEditingController night0TemperatureController =
      TextEditingController();
  final TextEditingController night0DurationController =
      TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxBool isApply = false.obs;

  RxDouble listHeight = 90.0.obs;

  List<Schedule1> scheduleList = [];

  List<TextEditingController> dayHourList = [TextEditingController()];

  List<TextEditingController> dayMinuteList = [TextEditingController()];

  List<TextEditingController> nightHourList = [TextEditingController()];

  List<TextEditingController> nightMinuteList = [TextEditingController()];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isCheckAll = false.obs;

  RxBool isDayHour = false.obs;

  RxBool isDayMinute = false.obs;

  RxBool isNightHour = false.obs;

  RxBool isNightMinute = false.obs;

  List<int> irrigationControlIds = [];

  RxList irrigationList = [].obs;

  List<IrrigationControl> mainList = [];

  IrrigationControlModel irrigationControlModel = IrrigationControlModel();

  List<RxBool> showList = [];

  List<RxBool> selectList = [];

  RxBool isSelect = false.obs;

  List<RxBool> appliedList = [];

  List<bool> checkList = [];

  RxBool isEdit = false.obs;

  RxInt irrigationId = 0.obs;

  Future getIrrigationControlData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      irrigationList.clear();

      mainList.clear();

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.irrigationControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if (apiResponse!.statusCode == 200) {
          irrigationControlModel = IrrigationControlModel.fromJson(data);

          if (irrigationControlModel.irrigationControls!.isNotEmpty) {
            irrigationList.addAll(irrigationControlModel.irrigationControls!);
            mainList.addAll(irrigationControlModel.irrigationControls!);
          }

          if (irrigationList.isNotEmpty) {
            showList =
                List.generate(irrigationList.length, (index) => false.obs);

            selectList =
                List.generate(irrigationList.length, (index) => false.obs);

            appliedList =
                List.generate(irrigationList.length, (index) => false.obs);

            if (appliedList.isNotEmpty) {
              for (int i = 0; i < irrigationList.length; i++) {
                IrrigationControl data = irrigationList[i];

                if (data.applied == true) {
                  appliedList[i].value = true;
                }
              }
            }
          }

          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  Future addIrrigationControlData(
      {required IrrigationModel irrigationModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.irrigationControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: irrigationModel.toJson());

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if (apiResponse!.statusCode == 200) {
          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  Future deleteIrrigationControl() async {
    bool isConnected = await checkNetConnectivity();

    if (isConnected == true) {
      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: "${ApiPath.baseUrl}${ApiPath.irrigationControl}",
              requestType: HTTPRequestType.DELETE,
              headers: {
                "Authorization": 'Bearer $token',
                "Content-Type": "application/json"
              },
              parameter: {
                "irrigationControlIds": irrigationControlIds
              });

          apiResponse =
              await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

          if (apiResponse!.statusCode == 200) {
            return true;
          } else {
            if (apiResponse!.statusCode == 403) {
              showSnack(width: 200.w, title: data["message"]);
            }

            return false;
          }
        } catch (e) {
          AppConst().debug(e.toString());
        }
      }
    } else {
      showSnack(title: AppStrings.noInternetConnection, width: 200.w);
    }
  }

  Future toggleApply({required bool applied, required int id}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                "${ApiPath.baseUrl}${ApiPath.irrigationControl}/$id/toggle_apply",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: {
              "applied": applied
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  Future updateFertigationControl(
      {required IrrigationModel irrigationModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                '${ApiPath.baseUrl}${ApiPath.irrigationControl}/${irrigationId.value}',
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: irrigationModel.toJson());

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if (apiResponse!.statusCode == 200) {
          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  void onSave() async {
    isValid.value = true;

    isDayHour.value = false;
    isDayMinute.value = false;
    isNightHour.value = false;
    isNightMinute.value = false;

    for (var element in dayMinuteList) {
      if (element.text.isEmpty) {
        isDayMinute.value = true;
      }
    }

    for (var element in dayHourList) {
      if (element.text.isEmpty) {
        isDayHour.value = true;
      }
    }

    for (var element in nightHourList) {
      if (element.text.isEmpty) {
        isNightHour.value = true;
      }
    }

    for (var element in nightMinuteList) {
      if (element.text.isEmpty) {
        isNightMinute.value = true;
      }
    }

    if (day100TemperatureController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (day100DurationController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (day0TemperatureController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (day0DurationController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (isDayHour.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (isDayMinute.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (night100TemperatureController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (night100DurationController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (night0TemperatureController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (night0DurationController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (isNightHour.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (isNightMinute.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nameController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (tagController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (descriptionController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else {
      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        IrrigationModel irrigationModel = IrrigationModel();

        irrigationModel.day100Temperature =
            int.parse(day100TemperatureController.text);
        irrigationModel.day100Duration =
            int.parse(day100DurationController.text);
        irrigationModel.day0Temperature =
            int.parse(day0TemperatureController.text);
        irrigationModel.day0Duration = int.parse(day0DurationController.text);
        irrigationModel.night100Temperature =
            int.parse(night100TemperatureController.text);
        irrigationModel.night100Duration =
            int.parse(night100DurationController.text);
        irrigationModel.night0Temperature =
            int.parse(night0TemperatureController.text);
        irrigationModel.night0Duration =
            int.parse(night0DurationController.text);
        irrigationModel.name = nameController.text;
        irrigationModel.tag = tagController.text;
        irrigationModel.description = descriptionController.text;

        Schedule1 schedule = Schedule1();

        for (int i = 0; i < dayHourList.length; i++) {
          String dayHour = dayHourList[i].text;
          String dayMinute = dayMinuteList[i].text;
          String nightHour = nightHourList[i].text;
          String nightMinute = nightMinuteList[i].text;

          schedule.dayTimeActivate = "$dayHour:$dayMinute";
          schedule.nightTimeActivate = "$nightHour:$nightMinute";

          scheduleList.add(schedule);
        }

        irrigationModel.schedules = scheduleList;

        AppConst().debug('name => ${irrigationModel.name}');

        if (isEdit.value == false) {
          await addIrrigationControlData(irrigationModel: irrigationModel)
              .whenComplete(() async {
            Get.back();
            await getIrrigationControlData();
          });
        } else {
          await updateFertigationControl(irrigationModel: irrigationModel)
              .whenComplete(() async {
                isEdit.value = false;
                listHeight.value = 80.0;
            Get.back();
            await getIrrigationControlData();
          });
        }
      } else {
        showSnack(title: AppStrings.noInternetConnection, width: 200.w);
      }

      day100TemperatureController.clear();
      day100DurationController.clear();
      day0TemperatureController.clear();
      day0DurationController.clear();
      for (var element in dayHourList) {
        element.clear();
      }
      for (var element in dayMinuteList) {
        element.clear();
      }
      night100TemperatureController.clear();
      night100DurationController.clear();
      night0TemperatureController.clear();
      night0DurationController.clear();
      for (var element in nightHourList) {
        element.clear();
      }
      for (var element in nightMinuteList) {
        element.clear();
      }
      nameController.clear();
      tagController.clear();
      descriptionController.clear();
    }
  }
}
