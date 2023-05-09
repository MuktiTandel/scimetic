import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/device_settings/Model/device_model.dart';

class DeviceSettingsController extends GetxController {

  List<DeviceModel> deviceList = [
    DeviceModel(
        name: AppStrings.switches,
        totalDevices: 18,
        totalOnline: 15,
        totalOffline: 3
    ),
    DeviceModel(
        name: AppStrings.sensors,
        totalDevices: 25,
        totalOnline: 23,
        totalOffline: 2
    ),
    DeviceModel(
        name: AppStrings.valves,
        totalDevices: 8,
        totalOnline: 7,
        totalOffline: 1
    ),
  ];
}