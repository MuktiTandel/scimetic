import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/temperature_control/model/switch_model.dart';
import 'package:scimetic/feature/temperature_control/model/temperature_controller_model.dart';

class TemperatureController extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController extractorDayTemperature = TextEditingController();
  final TextEditingController extractorNightTemperature = TextEditingController();

  final TextEditingController wetWallDayTemperature = TextEditingController();
  final TextEditingController wetWallNightTemperature = TextEditingController();

  RxString dayCoolingValue = "".obs;
  RxString dayCoolingRelaySelection = "".obs;

  RxString nightCoolingSwitch = "".obs;
  RxString nightCoolingRelay = "".obs;

  RxString extractorFanDaySwitch = "".obs;
  RxString extractorFanNightSwitch = "".obs;
  RxString extractorFanDayRelay = "".obs;
  RxString extractorFanNightRelay = "".obs;

  RxString wetWallDaySwitch = "".obs;
  RxString wetWallNightSwitch = "".obs;
  RxString wetWalDayRelay = "".obs;
  RxString wetWalNightRelay = "".obs;

  List<String> switchList = [];

  List<String> dayCoolingRelayList = [];

  List<String> nightCoolingRelayList = [];

  List<String> extractorFanDayRelayList = [];

  List<String> extractorFanNightRelayList = [];

  List<String> wetWalDayRelayList = [];
  List<String> wetWalNightRelayList = [];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  RxBool isCoolingEnable = false.obs;
  RxBool isHeatingEnable = false.obs;
  RxBool isExtractorFanOn = false.obs;
  RxBool isWetWallOn = false.obs;

  TemperatureControllerModel temperatureControllerModel = TemperatureControllerModel();

  SwitchModel switchModel = SwitchModel();

  Future getTemperatureControllerData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.temperatureControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          temperatureControllerModel = TemperatureControllerModel.fromJson(data);

          if ( temperatureControllerModel.temperatureControl!.dayCoolingRelay!.isNotEmpty ) {
            dayCoolingRelayList.clear();
            dayCoolingRelayList.add(temperatureControllerModel.temperatureControl!.dayCoolingRelay!);
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

  Future getSwitchData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.switches}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          switchModel = SwitchModel.fromJson(data);

          if ( switchModel.devices!.isNotEmpty ) {

            switchList.clear();

            for (var element in switchModel.devices!) {
              switchList.add(element.serialNumber!);
            }
          }

          AppConst().debug("switches list length => ${switchList.length}");


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

}