import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget selectWidget( {
  required String title,
  required double width,
  required bool isSelected,
  required VoidCallback onTap
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: (){
      onTap();
    },
    child: Column(
      children: [
        CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isSelected == false
              ? Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1
              : Get.isDarkMode ? Colors.white : Colors.black,
        ),
        Container(
          height: 1.5.h,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected == false
                ? Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1
                : Get.isDarkMode ? Colors.white : Colors.black,
          ),
        )
      ],
    ),
  );
}