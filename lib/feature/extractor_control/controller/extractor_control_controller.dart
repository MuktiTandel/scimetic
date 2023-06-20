import 'dart:convert';

import 'package:flutter/material.dart';
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
import 'package:scimetic/feature/extractor_control/model/Extractor_control_model.dart';

class ExtractorControlController extends GetxController {

  final TextEditingController dayTemperatureController = TextEditingController();
  final TextEditingController nightTemperatureController = TextEditingController();
  final TextEditingController dayTemperatureDeadbandController = TextEditingController();
  final TextEditingController nightTemperatureDeadbandController = TextEditingController();

  RxString daySwitch = "".obs;

  RxString nightSwitch = "".obs;

  RxString dayRelay = "".obs;

  RxString nightRelay = "".obs;

  RxList<String> switchList = <String>[].obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  List<String> dayRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  ApiService apiService = ApiService();

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isAuto = false.obs;

  Future getExtractorFanControlData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    progressDialog(true, Get.context!);

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      switchList.clear();

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.extractorFanControl}/${id.value}',
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
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');

        });

        isGetData.value = true;

        progressDialog(false, Get.context!);

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

  Future addExtractorFanControlData({required ExtractorControlModel extractorControlModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {

      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.extractorFanControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json",
            },
            parameter: extractorControlModel.toJson()
        );

        apiResponse =
        await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
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

    if ( dayTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayTemperatureDeadbandController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( daySwitch.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayRelay.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightTemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightTemperatureDeadbandController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightSwitch.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightRelay.value.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        ExtractorControlModel extractorControlModel = ExtractorControlModel();

        extractorControlModel.dayTemperature = double.parse(dayTemperatureController.text);
        extractorControlModel.dayTemperatureDeadband = double.parse(dayTemperatureDeadbandController.text);
        extractorControlModel.daySwitch = daySwitch.value;
        extractorControlModel.dayRelay = dayRelay.value;
        extractorControlModel.nightTemperature = double.parse(nightTemperatureController.text);
        extractorControlModel.nightTemperatureDeadband = double.parse(nightTemperatureDeadbandController.text);
        extractorControlModel.nightRelay = nightRelay.value;
        extractorControlModel.nightSwitch = nightSwitch.value;

        await addExtractorFanControlData(extractorControlModel: extractorControlModel);

      }

    }
  }

}