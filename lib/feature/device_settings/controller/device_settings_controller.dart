import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/device_settings/Model/device_model.dart';

class DeviceSettingsController extends GetxController {

  RxBool isSelect = false.obs;

  RxInt locationLength = 0.obs;

  RxInt descriptionLength = 0.obs;

  RxBool isSwitches = false.obs;
  RxBool isSensors = false.obs;
  RxBool isValves = false.obs;

  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<DeviceModel> deviceList = [
    DeviceModel(
        name: AppStrings.switches,
        totalDevices: 18,
        totalOnline: 15,
        totalOffline: 3,
      isSelect: false.obs
    ),
    DeviceModel(
        name: AppStrings.sensors,
        totalDevices: 25,
        totalOnline: 23,
        totalOffline: 2,
      isSelect: false.obs
    ),
    DeviceModel(
        name: AppStrings.valves,
        totalDevices: 8,
        totalOnline: 7,
        totalOffline: 1,
      isSelect: false.obs
    ),
  ];

  RxString value = "123456789101".obs;

  List<String> idList = [
    "123456789101"
  ];
}
