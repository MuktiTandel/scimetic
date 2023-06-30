import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/services/api_service.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/temperature_control/model/temperature_controller_model.dart';

class TemperatureController extends GetxController {
  RxBool isOn = false.obs;

  final TextEditingController extractorDayTemperature = TextEditingController();
  final TextEditingController extractorNightTemperature =
      TextEditingController();

  final TextEditingController wetWallDayTemperature = TextEditingController();
  final TextEditingController wetWallNightTemperature = TextEditingController();

  RxString dayCoolingSwitch = "".obs;
  RxString dayCoolingRelaySelection = "".obs;

  RxString nightCoolingSwitch = "".obs;
  RxString nightCoolingRelay = "".obs;

  RxString dayHeatingSwitch = "".obs;
  RxString dayHeatingRelay = "".obs;

  RxString nightHeatingSwitch = "".obs;
  RxString nightHeatingRelay = "".obs;

  RxString extractorFanDaySwitch = "".obs;
  RxString extractorFanNightSwitch = "".obs;
  RxString extractorFanDayRelay = "".obs;
  RxString extractorFanNightRelay = "".obs;

  RxString wetWallDaySwitch = "".obs;
  RxString wetWallNightSwitch = "".obs;
  RxString wetWalDayRelay = "".obs;
  RxString wetWalNightRelay = "".obs;

  List<String> switchList = [];

  List<String> dayCoolingRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightCoolingRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> dayHeatingRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightHeatingRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> dayExtractorRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightExtractorRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> dayWetWallRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightWetWallRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  RxBool isCoolingEnable = false.obs;
  RxBool isHeatingEnable = false.obs;
  RxBool isExtractorFanOn = false.obs;
  RxBool isWetWallOn = false.obs;

  TemperatureControllerModel temperatureControllerModel =
      TemperatureControllerModel();

  TemperatureControl temperatureControl = TemperatureControl();

  ApiService apiService = ApiService();

  RxBool isEdit = false.obs;

  Future getTemperatureControllerData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      switchList.clear();

      isGetData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.temperatureControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        await apiService.getSwitchData().whenComplete(() {
          if (apiService.switchList.isNotEmpty) {
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');
          isGetData.value = true;
        });

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
          temperatureControllerModel =
              TemperatureControllerModel.fromJson(data);

          if (temperatureControllerModel.temperatureControl != null) {
            isEdit.value = true;

            temperatureControl = temperatureControllerModel.temperatureControl!;

            dayCoolingSwitch.value = temperatureControl.dayCoolingSwitch ?? "";
            if (temperatureControl.dayCoolingRelay!.isNotEmpty) {
              if (temperatureControl.dayCoolingRelay!.contains("Relay_1")) {
                dayCoolingRelaySelection.value = 'Relay 1';
              } else if (temperatureControl.dayCoolingRelay!
                  .contains("Relay_2")) {
                dayCoolingRelaySelection.value = 'Relay 2';
              } else if (temperatureControl.dayCoolingRelay!
                  .contains("Relay_3")) {
                dayCoolingRelaySelection.value = 'Relay 3';
              } else {
                dayCoolingRelaySelection.value = 'Relay 4';
              }
            }
            nightCoolingSwitch.value =
                temperatureControl.nightCoolingSwitch ?? "";
            if (temperatureControl.nightCoolingRelay!.isNotEmpty) {
              if (temperatureControl.nightCoolingRelay!.contains("Relay_1")) {
                nightCoolingRelay.value = 'Relay 1';
              } else if (temperatureControl.nightCoolingRelay!
                  .contains("Relay_2")) {
                nightCoolingRelay.value = 'Relay 2';
              } else if (temperatureControl.nightCoolingRelay!
                  .contains("Relay_3")) {
                nightCoolingRelay.value = 'Relay 3';
              } else {
                nightCoolingRelay.value = 'Relay 4';
              }
            }
            dayHeatingSwitch.value = temperatureControl.dayHeatingSwitch ?? "";
            if (temperatureControl.dayHeatingRelay!.isNotEmpty) {
              if (temperatureControl.dayHeatingRelay!.contains("Relay_1")) {
                dayHeatingRelay.value = 'Relay 1';
              } else if (temperatureControl.dayHeatingRelay!
                  .contains("Relay_2")) {
                dayHeatingRelay.value = 'Relay 2';
              } else if (temperatureControl.dayHeatingRelay!
                  .contains("Relay_3")) {
                dayHeatingRelay.value = 'Relay 3';
              } else {
                dayHeatingRelay.value = 'Relay 4';
              }
            }
            nightHeatingSwitch.value =
                temperatureControl.nightHeatingSwitch ?? "";
            if (temperatureControl.nightHeatingRelay!.isNotEmpty) {
              if (temperatureControl.nightHeatingRelay!.contains("Relay_1")) {
                nightHeatingRelay.value = 'Relay 1';
              } else if (temperatureControl.nightHeatingRelay!
                  .contains("Relay_2")) {
                nightHeatingRelay.value = 'Relay 2';
              } else if (temperatureControl.nightHeatingRelay!
                  .contains("Relay_3")) {
                nightHeatingRelay.value = 'Relay 3';
              } else {
                nightHeatingRelay.value = 'Relay 4';
              }
            }
            extractorDayTemperature.text =
                "${temperatureControl.dayTemperatureExtractorFan}";
            extractorFanDaySwitch.value =
                temperatureControl.daySwitchExtractorFan ?? "";
            if (temperatureControl.dayRelayExtractorFan!.isNotEmpty) {
              if (temperatureControl.dayRelayExtractorFan!
                  .contains("Relay_1")) {
                extractorFanDayRelay.value = 'Relay 1';
              } else if (temperatureControl.dayRelayExtractorFan!
                  .contains("Relay_2")) {
                extractorFanDayRelay.value = 'Relay 2';
              } else if (temperatureControl.dayRelayExtractorFan!
                  .contains("Relay_3")) {
                extractorFanDayRelay.value = 'Relay 3';
              } else {
                extractorFanDayRelay.value = 'Relay 4';
              }
            }
            extractorNightTemperature.text =
                "${temperatureControl.nightTemperatureExtractorFan}";
            extractorFanNightSwitch.value =
                temperatureControl.nightSwitchExtractorFan ?? "";
            if (temperatureControl.nightRelayExtractorFan!.isNotEmpty) {
              if (temperatureControl.nightRelayExtractorFan!
                  .contains("Relay_1")) {
                extractorFanNightRelay.value = 'Relay 1';
              } else if (temperatureControl.nightRelayExtractorFan!
                  .contains("Relay_2")) {
                extractorFanNightRelay.value = 'Relay 2';
              } else if (temperatureControl.nightRelayExtractorFan!
                  .contains("Relay_3")) {
                extractorFanNightRelay.value = 'Relay 3';
              } else {
                extractorFanNightRelay.value = 'Relay 4';
              }
            }
            wetWallDayTemperature.text =
                "${temperatureControl.dayTemperatureWetWall}";
            wetWallDaySwitch.value = temperatureControl.daySwitchWetWall ?? "";
            if (temperatureControl.dayRelayWetWall!.contains("Relay_1")) {
              wetWalDayRelay.value = 'Relay 1';
            } else if (temperatureControl.dayRelayWetWall!
                .contains("Relay_2")) {
              wetWalDayRelay.value = 'Relay 2';
            } else if (temperatureControl.dayRelayWetWall!
                .contains("Relay_3")) {
              wetWalDayRelay.value = 'Relay 3';
            } else {
              wetWalDayRelay.value = 'Relay 4';
            }
            wetWallNightTemperature.text =
                "${temperatureControl.nightTemperatureWetWall}";
            wetWallNightSwitch.value =
                temperatureControl.nightSwitchWetWall ?? "";
            if (temperatureControl.nightRelayWetWall!.contains("Relay_1")) {
              wetWalNightRelay.value = 'Relay 1';
            } else if (temperatureControl.nightRelayWetWall!
                .contains("Relay_2")) {
              wetWalNightRelay.value = 'Relay 2';
            } else if (temperatureControl.nightRelayWetWall!
                .contains("Relay_3")) {
              wetWalNightRelay.value = 'Relay 3';
            } else {
              wetWalNightRelay.value = 'Relay 4';
            }
            isCoolingEnable.value = temperatureControl.coolingAuto ?? false;
            isHeatingEnable.value = temperatureControl.heatingAuto ?? false;
            isExtractorFanOn.value =
                temperatureControl.extractorFanAuto ?? false;
            isWetWallOn.value = temperatureControl.wetWallAuto ?? false;
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

  Future addTemperatureControlData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      switchList.clear();

      isGetData.value = false;

      TemperatureControl temperatureControl = TemperatureControl();

      temperatureControl.dayCoolingSwitch = dayCoolingSwitch.value;
      temperatureControl.nightCoolingSwitch = nightCoolingSwitch.value;
      temperatureControl.dayHeatingSwitch = dayHeatingSwitch.value;
      temperatureControl.nightHeatingSwitch = nightHeatingSwitch.value;
      temperatureControl.dayCoolingRelay = dayCoolingRelaySelection.value;
      temperatureControl.nightCoolingRelay = nightCoolingRelay.value;
      temperatureControl.dayHeatingRelay = dayHeatingRelay.value;
      temperatureControl.nightHeatingRelay = nightHeatingRelay.value;
      temperatureControl.dayTemperatureExtractorFan =
          extractorDayTemperature.text.isNotEmpty
              ? extractorDayTemperature.text
              : "";
      temperatureControl.nightTemperatureExtractorFan =
          extractorNightTemperature.text.isNotEmpty
              ? extractorNightTemperature.text
              : "";
      temperatureControl.dayTemperatureWetWall = wetWallDayTemperature.text;
      temperatureControl.nightTemperatureWetWall = wetWallNightTemperature.text;
      temperatureControl.daySwitchExtractorFan = extractorFanDaySwitch.value;
      temperatureControl.nightSwitchExtractorFan =
          extractorFanNightSwitch.value;
      temperatureControl.daySwitchWetWall = wetWallDaySwitch.value;
      temperatureControl.nightSwitchWetWall = wetWallNightSwitch.value;
      temperatureControl.dayRelayExtractorFan = extractorFanDayRelay.value;
      temperatureControl.nightRelayExtractorFan = extractorFanNightRelay.value;
      temperatureControl.dayRelayWetWall = wetWalDayRelay.value;
      temperatureControl.coolingAuto = isCoolingEnable.value;
      temperatureControl.heatingAuto = isHeatingEnable.value;
      temperatureControl.extractorFanAuto = isExtractorFanOn.value;
      temperatureControl.wetWallAuto = isWetWallOn.value;
      temperatureControl.createdAt = DateTime.now();
      temperatureControl.updatedAt = DateTime.now();

      try {
        progressDialog(true, Get.context!);

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.temperatureControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: temperatureControl.toJson());

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
}
