import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/services/api_service.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/co2_control/model/co2_model.dart';

class Co2Controller extends GetxController {

  final TextEditingController dayMinimumTarget = TextEditingController();
  final TextEditingController dayMaximumTarget = TextEditingController();
  final TextEditingController dayHighProtection = TextEditingController();

  final TextEditingController nightMinimumTarget = TextEditingController();
  final TextEditingController nightMaximumTarget = TextEditingController();
  final TextEditingController nightHighProtection = TextEditingController();

  RxString dayLightningSwitch = "".obs;
  RxString dayLightningRelay = "".obs;

  RxString nightLightningSwitch = "".obs;
  RxString nightLightningRelay = "".obs;

  List<String> switchList = [];

  List<String> dayLightningRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightLightningRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> relayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  ApiService apiService = ApiService();

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  Future getCo2ControllerData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      // progressDialog(false, Get.context!);

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.co2Control}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        await apiService.getSwitchData().whenComplete(() {
          if ( apiService.switchList.isNotEmpty ) {
            switchList.clear();
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');
        });

        // progressDialog(false, Get.context!);

        isGetData.value = true;

        if ( apiResponse!.statusCode == 200 ) {

           showSnack(
               width: 200.w,
               title: data["message"]
           );

          return true;

        } else {

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

  Future addCo2Data({required Co2Model co2model}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.co2Control}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: co2model.toJson()
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

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }

    }

  }

  void onSave() async {

    isValid.value = true;

    if ( dayMinimumTarget.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayMaximumTarget.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayHighProtection.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightningSwitch.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayLightningRelay.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightMinimumTarget.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightMaximumTarget.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightHighProtection.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightningRelay.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightLightningSwitch.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        progressDialog(true, Get.context!);

        Co2Model co2model = Co2Model();

        co2model.dayMinLevel = int.parse(dayMinimumTarget.text);
        co2model.dayMaxLevel = int.parse(dayMaximumTarget.text);
        co2model.dayHighLevel = int.parse(dayHighProtection.text);
        co2model.daySwitch = dayLightningSwitch.value;
        co2model.dayRelay = dayLightningRelay.value;
        co2model.nightMinLevel = int.parse(nightMinimumTarget.text);
        co2model.nightMaxLevel = int.parse(nightMaximumTarget.text);
        co2model.nightHighLevel = int.parse(nightHighProtection.text);
        co2model.nightSwitch = nightLightningSwitch.value;
        co2model.nightRelay = nightLightningRelay.value;

        await addCo2Data(co2model: co2model).whenComplete(() {

          progressDialog(false, Get.context!);

        });

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );
      }

    }

  }

}