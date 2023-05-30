import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonStatusWidget({required RxBool isOn}) {
  return  Padding(
    padding: EdgeInsets.all(10.w),
    child: Row(
      children: [
        CustomText(
          text: AppStrings.status,
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
          color: AppColors.buttonColor,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() => CustomText(
          text: AppStrings.auto,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isOn.value == false
              ? AppColors.buttonColor
              : Get.isDarkMode ? Colors.white :AppColors.subTitleColor,
        ),),
        SizedBox(width: 5.w,),
        Obx(() => GestureDetector(
          onTap: (){
            isOn.value = !isOn.value;
          },
          child: Image.asset(
            isOn.value == false
                ? Get.isDarkMode
                ? AppImages.darkSelectedToggle : AppImages.lightSelectToggle
                : Get.isDarkMode
                ? AppImages.darkUnselectToggle : AppImages.lightUnselectToggle,
            height: 30.h,
            width: 30.w,
          ),
        ),),
        SizedBox(width: 5.w,),
        Obx(() => CustomText(
          text: AppStrings.on,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isOn.value == true
              ? AppColors.buttonColor
              : Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
        ),)
      ],
    ),
  );
}