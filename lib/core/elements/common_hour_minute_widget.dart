import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget commonHourMinuteWidget( {
  required String title1,
  required TextEditingController hour1,
  required TextEditingController minute1,
  required String title2,
  required TextEditingController hour2,
  required TextEditingController minute2,
  bool? isField
}) {

  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title1,
            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
            fontSize: 12.h,
          ),
          SizedBox(height: 5.h,),
          Row(
            children: [
              commonTimeTextField(
                  controller: hour1,
                  hintText: AppStrings.hh,
                  isField: true,
                  onChanged: (value){
                    if ( value.isNotEmpty ) {
                      if (int.parse(value) > 23) {
                        hour1.text = "23";
                      }
                    }
                  }
              ),
              SizedBox(width: 5.w,),
              CustomText(
                text: ":",
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 5.w,),
              commonTimeTextField(
                  controller: minute1,
                  hintText: AppStrings.mm,
                  isField: true,
                  onChanged: (value) {
                    if ( value.isNotEmpty ) {
                      if (int.parse(value) > 59) {
                        minute1.text = "59";
                      }
                    }
                  }
              )
            ],
          )
        ],
      ),
      SizedBox(width: 20.w,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title2,
            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
            fontSize: 12.h,
          ),
          SizedBox(height: 5.h,),
          Row(
            children: [
              commonTimeTextField(
                  controller: hour2,
                  hintText: AppStrings.hh,
                  isField: true,
                  onChanged: (value){
                    if ( value.isNotEmpty ) {
                      if (int.parse(value) > 23) {
                        hour2.text = "23";
                      }
                    }
                  }
              ),
              SizedBox(width: 5.w,),
              CustomText(
                text: ":",
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 5.w,),
              commonTimeTextField(
                  controller: minute2,
                  hintText: AppStrings.mm,
                  isField: true,
                  onChanged: (value) {
                    if ( value.isNotEmpty ) {
                      if (int.parse(value) > 59) {
                        minute2.text = "59";
                      }
                    }
                  }
              )
            ],
          ),
        ],
      ),
    ],
  );

}