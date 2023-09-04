import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';

class TableData extends DataTableSource {

  final deviceController = Get.put(DeviceSettingsController());

  @override
  DataRow? getRow(int index) {
    throw UnimplementedError();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => deviceController.tableDataList.length;

  @override
  int get selectedRowCount => 0;

}