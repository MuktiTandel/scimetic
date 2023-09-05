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
import 'package:scimetic/feature/lightning_control/model/lightning_control_model.dart';
import 'package:scimetic/feature/lightning_control/model/lightning_model.dart';

class LightningController extends GetxController {
  RxBool isOn = false.obs;

  final TextEditingController dayLightOnHour = TextEditingController();
  final TextEditingController dayLightOnMinute = TextEditingController();

  final TextEditingController dayLightOffHour = TextEditingController();
  final TextEditingController dayLightOffMinute = TextEditingController();

  final TextEditingController nightLightOnHour = TextEditingController();
  final TextEditingController nightLightOnMinute = TextEditingController();

  final TextEditingController nightLightOffHour = TextEditingController();
  final TextEditingController nightLightOffMinute = TextEditingController();

  final TextEditingController daySpectrumController = TextEditingController();
  final TextEditingController nightSpectrumController = TextEditingController();

  RxDouble dayLightOutput = 0.0.obs;

  RxDouble nightLightOutput = 0.0.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  ApiService apiService = ApiService();

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  LightningControlModel lightningControlModel = LightningControlModel();

  /// for get lightning data
  Future getLightningData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {

      dayLightOnHour.clear();
      dayLightOnMinute.clear();
      dayLightOffHour.clear();
      dayLightOffMinute.clear();
      nightLightOnHour.clear();
      nightLightOnMinute.clear();
      nightLightOffHour.clear();
      nightLightOffMinute.clear();
      daySpectrumController.clear();
      nightSpectrumController.clear();
      dayLightOutput.value = 0.0;
      nightLightOutput.value = 0.0;

      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.lightingControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
          lightningControlModel = LightningControlModel.fromJson(data);

          if ( lightningControlModel.lightingControl != null ) {
            LightingControl lightingControl =
            lightningControlModel.lightingControl!;

            if (lightingControl.dayTimeOn!.isNotEmpty) {
              setTime(
                  time: lightingControl.dayTimeOn!,
                  hour: dayLightOnHour,
                  minute: dayLightOnMinute
              );
            }

            if (lightingControl.dayTimeOff!.isNotEmpty) {
              setTime(
                  time: lightingControl.dayTimeOff!,
                  hour: dayLightOffHour,
                  minute: dayLightOffMinute
              );
            }

            dayLightOutput.value = lightingControl.dayOutput ?? 0.0;

            daySpectrumController.text = lightingControl.daySpectrum ?? "";

            if ( lightingControl.nightTimeOn!.isNotEmpty ) {

              setTime(
                  time: lightingControl.nightTimeOn!,
                  hour: nightLightOnHour,
                  minute: nightLightOnMinute
              );
              
            }
            
            if ( lightingControl.nightTimeOff!.isNotEmpty ) {
              
              setTime(
                  time: lightingControl.nightTimeOff!, 
                  hour: nightLightOffHour,
                  minute: nightLightOffMinute
              );
              
            }

            nightLightOutput.value = lightingControl.nightOutput ?? 0.0;
            nightSpectrumController.text = lightingControl.nightSpectrum ?? "";

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

  /// for set time
  void setTime({
    required String time,
    required TextEditingController hour,
    required TextEditingController minute
  }) {

      final dayStart = time;

      AppConst().debug(dayStart);

      final split = dayStart.split(":");

      final Map<int, String> values = {
        for (int i = 0; i < split.length; i++) i: split[i]
      };

      AppConst().debug('${values[0]}');

      hour.text = values[0]!;
      minute.text = values[1]!;

  }

  /// for add new lightning data
  Future addLightningData({required LightningModel lightningModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.lightingControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: lightningModel.toJson());

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

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

  /// for check validation
  void onSave() async {
    isValid.value = true;

    if (dayLightOnMinute.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayLightOnHour.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayLightOffHour.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayLightOffMinute.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (daySpectrumController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightLightOnHour.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightLightOnMinute.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightLightOffHour.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightLightOffMinute.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightSpectrumController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else {
      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        progressDialog(true, Get.context!);

        LightningModel lightningModel = LightningModel();

        lightningModel.dayTimeOn =
            "${dayLightOnHour.text}:${dayLightOnMinute.text}";
        lightningModel.dayTimeOff =
            "${dayLightOffHour.text}:${dayLightOffMinute.text}";
        lightningModel.dayOutput = dayLightOutput.value;
        lightningModel.daySpectrum = daySpectrumController.text;
        lightningModel.nightTimeOn =
            "${nightLightOnHour.text}:${nightLightOnMinute.text}";
        lightningModel.nightTimeOff =
            "${nightLightOffHour.text}:${nightLightOffMinute.text}";
        lightningModel.nightOutput = nightLightOutput.value;
        lightningModel.nightSpectrum = nightSpectrumController.text;

        await addLightningData(lightningModel: lightningModel).whenComplete(() {
          progressDialog(false, Get.context!);
          daySpectrumController.clear();
          dayLightOffMinute.clear();
          dayLightOffHour.clear();
          dayLightOnMinute.clear();
          dayLightOnHour.clear();
          dayLightOutput.value = 0.0;
          nightSpectrumController.clear();
          nightLightOffMinute.clear();
          nightLightOffHour.clear();
          nightLightOnMinute.clear();
          nightLightOnHour.clear();
          nightLightOutput.value = 0.0;
        });
      } else {
        showSnack(title: AppStrings.noInternetConnection, width: 200.w);
      }
    }
  }
}
