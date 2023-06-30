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
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/circulation_control/model/circulation_model.dart';

class CirculationControlController extends GetxController {

  final TextEditingController temperatureOffController = TextEditingController();
  final TextEditingController temperatureOffDeadbandController = TextEditingController();

  final TextEditingController humidityOnController = TextEditingController();
  final TextEditingController humidityOnDeadbandController = TextEditingController();

  final TextEditingController timeOnHour = TextEditingController();
  final TextEditingController timeOnMinute = TextEditingController();

  final TextEditingController timeOffHour = TextEditingController();
  final TextEditingController timeOffMinute = TextEditingController();

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  CirculationModel circulationModel = CirculationModel();

  CirculationFanControl circulationFanControl = CirculationFanControl();

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  Future getCirculationControlData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      progressDialog(true, Get.context!);

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.circulationFanControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if ( apiResponse!.statusCode == 200 ) {

          circulationModel = CirculationModel.fromJson(data);

          circulationFanControl = circulationModel.circulationFanControl!;

          if ( circulationFanControl.temperatureOff != null ) {
            temperatureOffController.text = "${circulationFanControl.temperatureOff}";
          }

          if ( circulationFanControl.temperatureOffDeadband != null ) {
            temperatureOffDeadbandController.text = "${circulationFanControl.temperatureOffDeadband}";
          }

          if ( circulationFanControl.humidityOn != null ) {
            humidityOnController.text = "${circulationFanControl.humidityOn}";
          }

          if ( circulationFanControl.humidityOnDeadband != null ) {
            humidityOnDeadbandController.text = "${circulationFanControl.humidityOnDeadband}";
          }

          if ( circulationFanControl.timeOn!.isNotEmpty ) {

            final timeOn = circulationFanControl.timeOn!;

            AppConst().debug(timeOn);

            final split = timeOn.split(":");

            final Map<int, String> values = {
              for (int i = 0; i < split.length; i++)
                i: split[i]
            };

            AppConst().debug('${values[0]}');

            timeOnHour.text = values[0]!;
            timeOnMinute.text = values[1]!;

          }

          if ( circulationFanControl.timeOff!.isNotEmpty ) {

            final timeOff = circulationFanControl.timeOff!;

            AppConst().debug(timeOff);

            final split = timeOff.split(":");

            final Map<int, String> values = {
              for (int i = 0; i < split.length; i++)
                i: split[i]
            };

            AppConst().debug('${values[0]}');

            timeOffHour.text = values[0]!;
            timeOffMinute.text = values[1]!;

          }

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

  Future saveCirculationData({ required CirculationFanControl circulationFanControl }) async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.circulationFanControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: circulationModel.toJson()
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

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

  void onSave ()  async {

    isValid.value = true;

    if ( temperatureOffController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( temperatureOffDeadbandController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( humidityOnController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( humidityOnDeadbandController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( timeOnHour.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( timeOnMinute.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( timeOffHour.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( timeOffMinute.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      CirculationFanControl circulationFanControl = CirculationFanControl();

      circulationFanControl.temperatureOff = temperatureOffController.text;
      circulationFanControl.temperatureOffDeadband = temperatureOffDeadbandController.text;
      circulationFanControl.humidityOn = humidityOnController.text;
      circulationFanControl.humidityOnDeadband = humidityOnDeadbandController.text;
      circulationFanControl.timeOn = "${timeOnHour.text}:${timeOnMinute.text}";
      circulationFanControl.timeOff = "${timeOffHour.text}:${timeOffMinute.text}";

      await saveCirculationData(circulationFanControl: circulationFanControl).whenComplete(() async {
        temperatureOffController.clear();
        temperatureOffDeadbandController.clear();
        humidityOnController.clear();
        humidityOnDeadbandController.clear();
        timeOnHour.clear();
        timeOnMinute.clear();
        timeOffHour.clear();
        timeOffMinute.clear();
        await getCirculationControlData();
      });



    }

  }

}