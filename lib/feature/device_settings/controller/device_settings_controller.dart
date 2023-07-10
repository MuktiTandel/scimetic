import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/device_settings/Model/device_model.dart';

class DeviceSettingsController extends GetxController {

  RxBool isSelect = false.obs;

  RxInt locationLength = 0.obs;

  RxInt descriptionLength = 0.obs;

  RxBool isSwitches = false.obs;
  RxBool isSensors = false.obs;
  RxBool isValves = false.obs;

  RxBool isEdit = false.obs;

  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deviceTypeController = TextEditingController();

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  DeviceModel deviceModel = DeviceModel();

  RxBool isGetData = false.obs;

  List<SensorDevice> sensorDeviceList = [];

  List<SensorDevice> valvesDeviceList = [];

  List<SwitchDevice> switchDeviceList = [];

  List<RxBool> selectSensorDevice = [];
  List<RxBool> selectValvesDevice = [];
  List<RxBool> selectSwitchDevice = [];

  RxBool isGetDevice = false.obs;

  Future getDeviceData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {
      try {

        isGetDevice.value = false;

        progressDialog(true, Get.context!);

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.device}/${id.value}',
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

          isGetDevice.value = true;

          deviceModel = DeviceModel.fromJson(data);

          AppConst().debug('device => ${deviceModel.devices!.devicesSwitch!.total}');

          if ( deviceModel.devices!.sensor!.devices!.isNotEmpty ) {
            sensorDeviceList.clear();
            sensorDeviceList.addAll(deviceModel.devices!.sensor!.devices!);
          }

          if ( deviceModel.devices!.valve!.devices!.isNotEmpty ) {
            valvesDeviceList.clear();
            valvesDeviceList.addAll(deviceModel.devices!.valve!.devices!);
          }

          if ( deviceModel.devices!.devicesSwitch!.devices!.isNotEmpty ) {
            switchDeviceList.clear();
            switchDeviceList.addAll(deviceModel.devices!.devicesSwitch!.devices!);
          }

          if ( sensorDeviceList.isNotEmpty ) {
            selectSensorDevice.clear();
            selectSensorDevice = List.generate(sensorDeviceList.length, (index) => false.obs);
          }

          if ( valvesDeviceList.isNotEmpty ) {
            selectValvesDevice.clear();
            selectValvesDevice = List.generate(valvesDeviceList.length, (index) => false.obs);
          }

          if ( switchDeviceList.isNotEmpty ) {
            selectSwitchDevice.clear();
            selectSwitchDevice = List.generate(switchDeviceList.length, (index) => false.obs);
          }

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

  Future updateDevice({
    required SensorDevice sensorDevice,
    required int id,
    required SwitchDevice switchDevice,
  }) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: "${ApiPath.baseUrl}${ApiPath.device}/$id",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: isSensors.value == true || isValves.value == true
                ? sensorDevice.toJson()
                : switchDevice.toJson()
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {
          isEdit.value = false;
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
