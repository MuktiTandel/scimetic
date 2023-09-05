import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';

class TableData extends DataTableSource {

  final deviceController = Get.put(DeviceSettingsController());

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(CustomText(
        text: deviceController.tableDataList[index]["title"],
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
      )),
      DataCell(
          Text(
            deviceController.tableDataList[index]["value"],
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                fontFamily: "Poppins"
            ),
          )
      )
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => deviceController.tableDataList.length;

  @override
  int get selectedRowCount => 0;

}