import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';

Widget commonTimeTextField({
  required TextEditingController controller,
  required String hintText,
  required ValueChanged<String>? onChanged,
  double? width
}) {
  return SizedBox(
    height: 40.h,
    width: width ?? 50.w ,
    child: CustomTextField(
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      textInputType: TextInputType.number,
      borderRadius: 8,
      hintText: hintText,
      isFilled: Get.isDarkMode ? true : false,
      contentPadding: EdgeInsets.only(top: 10.h, bottom: 10.h),
      onchange: onChanged,
    ),
  );
}