import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget selectWidget({ required VoidCallback onTap,
  required String text, required bool isSelected}) {
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
      height: 35.h,
      decoration: BoxDecoration(
          color: isSelected == true
              ? Get.isDarkMode ? AppColors.darkBlue : Colors.white
              : Get.isDarkMode ? AppColors.darkTheme : AppColors.lightGray2,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: CustomText(
          text: text,
          color: isSelected == true
              ? Get.isDarkMode ? Colors.white : Colors.black
              : Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}