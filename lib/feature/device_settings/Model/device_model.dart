import 'package:get/get.dart';

class DeviceModel {

  final String name;
  final int totalDevices;
  final int totalOnline;
  final int totalOffline;
  final RxBool isSelect;

  DeviceModel({
    required this.name,
    required this.totalDevices,
    required this.totalOnline,
    required this.totalOffline,
    required this.isSelect
  });
}