import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/irrigation_control/model/irrigation_model.dart';

class IrrigationController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController day100TemperatureController = TextEditingController();
  final TextEditingController day100DurationController = TextEditingController();
  final TextEditingController night100TemperatureController = TextEditingController();
  final TextEditingController night100DurationController = TextEditingController();
  final TextEditingController day0TemperatureController = TextEditingController();
  final TextEditingController day0DurationController = TextEditingController();
  final TextEditingController night0TemperatureController = TextEditingController();
  final TextEditingController night0DurationController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  RxBool isSelect = false.obs;

  RxBool isApply = false.obs;

  RxDouble listHeight = 80.0.obs;

  List<Schedule> scheduleList = [];

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];

  List<TextEditingController> dayHourList = [
    TextEditingController()
  ];

  List<TextEditingController> dayMinuteList = [
    TextEditingController()
  ];

  List<TextEditingController> nightHourList = [
    TextEditingController()
  ];

  List<TextEditingController> nightMinuteList = [
    TextEditingController()
  ];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  Future getIrrigationControlData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.irrigationControl}/${id.value}',
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

  Future addIrrigationControlData({required IrrigationModel irrigationModel}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.irrigationControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
          parameter: irrigationModel.toJson()
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

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

  void onSave() async {

    isValid.value = true;

    if ( day100TemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( day100DurationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( day0TemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( day0DurationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dayHourList.isNotEmpty ) {

      for (var element in dayHourList) {
        if ( element.text.isEmpty ) {

          isValid.value = false;
          errorMessage.value = AppStrings.allFieldRequired;

        }
      }
    } else if ( dayMinuteList.isNotEmpty ) {

      for (var element in dayMinuteList) {
        if ( element.text.isEmpty ) {

          isValid.value = false;
          errorMessage.value = AppStrings.allFieldRequired;

        }
      }

    } else if ( night100TemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( night100DurationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( night0TemperatureController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( night0DurationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nightHourList.isNotEmpty ) {

      for (var element in nightHourList) {

        if ( element.text.isEmpty ) {
          isValid.value = false;
          errorMessage.value = AppStrings.allFieldRequired;
        }
      }

    } else if ( nightMinuteList.isNotEmpty ) {

      for (var element in nightMinuteList) {
        if ( element.text.isEmpty ) {
          isValid.value = false;
          errorMessage.value = AppStrings.allFieldRequired;
        }
      }

    } else if ( nameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( tagController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( descriptionController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        IrrigationModel irrigationModel = IrrigationModel();

        irrigationModel.day100Temperature = int.parse(day100TemperatureController.text);
        irrigationModel.day100Duration = int.parse(day100DurationController.text);
        irrigationModel.day0Temperature = int.parse(day0TemperatureController.text);
        irrigationModel.day0Duration = int.parse(day0DurationController.text);
        irrigationModel.night100Temperature = int.parse(night100TemperatureController.text);
        irrigationModel.night100Duration = int.parse(night100DurationController.text);
        irrigationModel.night0Temperature = int.parse(night0TemperatureController.text);
        irrigationModel.night0Duration = int.parse(night0DurationController.text);
        irrigationModel.name = nameController.text;
        irrigationModel.tag = tagController.text;
        irrigationModel.description = descriptionController.text;

        Schedule schedule = Schedule();

        for (var element in dayHourList) {

        }

        await addIrrigationControlData(irrigationModel: irrigationModel);

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

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

      Get.back();
    }



  }

}