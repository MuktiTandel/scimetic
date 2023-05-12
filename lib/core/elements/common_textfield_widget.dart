import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/custom_textfield.dart';

Widget commonTexField({
  required String title,
  required TextEditingController controller,
  required String suffixText,
  required String hintText,
  required ValueChanged<String>? onChanged,
   double? contentPadding
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
        text: title,
        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        fontSize: 12.h,
      ),
      SizedBox(height: 5.h,),
      SizedBox(
        height: 40.h,
        child: CustomTextField(
          controller: controller,
          borderRadius: 8,
          textInputType: TextInputType.number,
          contentPadding: EdgeInsets.only(left: 10.w),
          hintText: hintText,
          hintTextSize: 12.sp,
          isFilled: Get.isDarkMode ? true : false,
          suffixWidget: Padding(
            padding:  EdgeInsets.only(top: 10.h,left: contentPadding ??  10.w, right: 10.w),
            child: CustomText(
              text: suffixText,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            ),
          ),
          onchange: onChanged,
        ),
      )
    ],
  );
}