import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonEnableTitleWidget({required String title, required RxBool isSelect}) {
  return Padding(
    padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
    child: Row(
      children: [
        CustomText(
          text: title,
          fontSize: 15.sp,
          color: AppColors.buttonColor,
          fontWeight: FontWeight.w500,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() =>  CustomText(
          text: isSelect.value ? AppStrings.enable : AppStrings.disable,
          fontSize: 15.sp,
          color: AppColors.buttonColor,
          fontWeight: FontWeight.w500,
        ),),
        SizedBox(width: 10.w,),
        Obx(() => GestureDetector(
          onTap: (){
            isSelect.value = !isSelect.value;
          },
          child: Image.asset(
            isSelect.value == false
                ? Get.isDarkMode
                ? AppImages.darkSelectedToggle : AppImages.lightSelectToggle
                : Get.isDarkMode
                ? AppImages.darkUnselectToggle : AppImages.lightUnselectToggle,
            height: 30.h,
            width: 30.w,
          ),
        ),),
      ],
    ),
  );
}