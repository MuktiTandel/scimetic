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
import 'package:scimetic/feature/humidity_control/model/humidity_control_model.dart';
import 'package:scimetic/feature/humidity_control/model/humidity_model.dart';

class HumidityController extends GetxController {
  final TextEditingController dayHumidityRHController = TextEditingController();
  final TextEditingController dayHumidityRHDeadbandController =
      TextEditingController();
  final TextEditingController nightHumidityRHController =
      TextEditingController();
  final TextEditingController nightHumidityRHDeadbandController =
      TextEditingController();
  final TextEditingController dayDehumidityRHController =
      TextEditingController();
  final TextEditingController nightDehumidityRHController =
      TextEditingController();
  final TextEditingController dayDehumidityRHDeadbandController =
      TextEditingController();
  final TextEditingController nightDehumidityRHDeadbandController =
      TextEditingController();

  RxString dayHumiditySwitch = "".obs;
  RxString dayHumidityRelay = "".obs;

  RxString nightHumiditySwitch = "".obs;
  RxString nightHumidityRelay = "".obs;

  RxString dayDehumidificationSwitch = "".obs;
  RxString dayDehumidificationRelay = "".obs;

  RxString nightDehumidificationSwitch = "".obs;
  RxString nightDehumidificationRelay = "".obs;

  List<String> switchList = [];

  List<String> dayHumidityRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightHumidityRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> dayDehumidificationRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4'
  ];

  List<String> nightDehumidificationRelayList = [
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

  ApiService apiService = ApiService();

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isEdit = false.obs;

  HumidityControlModel humidityControlModel = HumidityControlModel();

  /// for get humidity controller data
  Future getHumidityControllerData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      isEdit.value = false;

      dayHumidityRHController.clear();
      dayHumidityRHDeadbandController.clear();
      nightHumidityRHController.clear();
      nightHumidityRHDeadbandController.clear();
      dayDehumidityRHController.clear();
      nightDehumidityRHController.clear();
      dayDehumidityRHDeadbandController.clear();
      nightDehumidityRHDeadbandController.clear();

      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.humidityControl}/${id.value}',
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
            switchList.clear();
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');
        });

        progressDialog(false, Get.context!);

        isGetData.value = true;

        if (apiResponse!.statusCode == 200) {
          isEdit.value = true;
          humidityControlModel = HumidityControlModel.fromJson(data);

          HumidityControl humidityControl =
              humidityControlModel.humidityControl!;

          dayHumidityRHController.text = humidityControl.dayHumidityRh != 0
              ? humidityControl.dayHumidityRh.toString()
              : "";
          dayHumidityRHDeadbandController.text =
              humidityControl.dayHumidityRhDeadband != 0
                  ? humidityControl.dayHumidityRhDeadband.toString()
                  : "";
          dayHumiditySwitch.value = humidityControl.dayHumiditySwitch ?? "";
          dayHumidityRelay.value = humidityControl.dayHumidityRelay ?? "";
          nightHumidityRHController.text = humidityControl.nightHumidityRh != 0
              ? humidityControl.nightHumidityRh.toString()
              : "";
          nightHumidityRHDeadbandController.text =
              humidityControl.nightHumidityRhDeadband != 0
                  ? humidityControl.nightHumidityRhDeadband.toString()
                  : "";
          nightHumiditySwitch.value = humidityControl.nightHumiditySwitch ?? "";
          nightHumidityRelay.value = humidityControl.nightHumidityRelay ?? "";
          dayDehumidityRHController.text = humidityControl.dayDehumidityRh != 0
              ? humidityControl.dayDehumidityRh.toString()
              : "";
          dayDehumidityRHDeadbandController.text =
              humidityControl.dayDehumidityRhDeadband != 0
                  ? humidityControl.dayDehumidityRhDeadband.toString()
                  : "";
          dayDehumidificationSwitch.value =
              humidityControl.dayDehumiditySwitch ?? "";
          dayDehumidificationRelay.value =
              humidityControl.dayDehumidityRelay ?? "";
          nightDehumidityRHController.text =
              humidityControl.nightDehumidityRh != 0
                  ? humidityControl.nightDehumidityRh.toString()
                  : "";
          nightDehumidityRHDeadbandController.text =
              humidityControl.nightDehumidityRhDeadband != 0
                  ? humidityControl.nightDehumidityRhDeadband.toString()
                  : "";
          nightDehumidificationSwitch.value =
              humidityControl.nightDehumiditySwitch ?? "";
          nightDehumidificationRelay.value =
              humidityControl.nightDehumidityRelay ?? "";

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

  /// for add new humidity control data
  Future addHumidityData({required HumidityModel humidityModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.humidityControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: humidityModel.toJson());

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

    if (dayHumidityRHController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayHumidityRHDeadbandController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightHumidityRHController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightHumidityRHDeadbandController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayDehumidityRHController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayDehumidityRHDeadbandController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightDehumidityRHController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightDehumidityRHDeadbandController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayHumiditySwitch.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayHumidityRelay.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightHumiditySwitch.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightHumidityRelay.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayDehumidificationSwitch.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayDehumidificationRelay.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightDehumidificationSwitch.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightDehumidificationRelay.value.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else {
      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        progressDialog(true, Get.context!);

        HumidityModel humidityModel = HumidityModel();

        humidityModel.dayHumidityRh =
            double.parse(dayHumidityRHController.text);
        humidityModel.dayHumidityRhDeadband =
            double.parse(dayHumidityRHDeadbandController.text);
        humidityModel.dayHumiditySwitch = dayHumiditySwitch.value;
        humidityModel.dayHumidityRelay = dayHumidityRelay.value;
        humidityModel.nightHumidityRh =
            double.parse(nightHumidityRHController.text);
        humidityModel.nightHumidityRhDeadband =
            double.parse(nightHumidityRHDeadbandController.text);
        humidityModel.nightHumiditySwitch = nightHumiditySwitch.value;
        humidityModel.nightHumidityRelay = nightHumidityRelay.value;
        humidityModel.dayDehumidityRh =
            double.parse(dayDehumidityRHController.text);
        humidityModel.dayDehumidityRhDeadband =
            double.parse(dayDehumidityRHDeadbandController.text);
        humidityModel.dayDehumiditySwitch = dayDehumidificationSwitch.value;
        humidityModel.dayDehumidityRelay = dayDehumidificationRelay.value;
        humidityModel.nightDehumidityRh =
            double.parse(nightDehumidityRHController.text);
        humidityModel.nightDehumidityRhDeadband =
            double.parse(nightDehumidityRHDeadbandController.text);
        humidityModel.nightDehumiditySwitch = nightDehumidificationSwitch.value;
        humidityModel.nightDehumidityRelay = nightDehumidificationRelay.value;

        await addHumidityData(humidityModel: humidityModel).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      } else {
        showSnack(title: AppStrings.noInternetConnection, width: 200.w);
      }
    }
  }
}
