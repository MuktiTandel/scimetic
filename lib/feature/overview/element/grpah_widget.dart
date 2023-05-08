import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/overview/element/select_widge.dart';

Widget graphWidget({
  required String title,
  required String image,
  required String value,
  required Color color,
  required String value1,
  required bool isHour,
  required VoidCallback hourSelect,
  required bool isWeek,
  required VoidCallback weekSelect,
  required bool isMonth,
  required VoidCallback monthSelect,
  required Widget graph
}) {
  return Container(
    width: Get.width,
    color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15.w),
          child: Row(
            children: [
              CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              Image.asset(
                image,
                height: 20.h,
                width: 20.w,
                color: Get.isDarkMode
                    ? AppColors.darkText : AppColors.lightText,
              )
            ],
          ),
        ),
        Divider(
          thickness: 1.2.w,
          color: Get.isDarkMode ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(
                height : 40.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: value,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                    SizedBox(width: 4.w,),
                    CustomText(
                      text: value1,
                      fontSize: 15.sp,
                      color: color,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  selectWidget(
                      title: AppStrings.hours,
                      width: 34.w,
                      isSelected: isHour,
                      onTap: (){
                        hourSelect();
                      }
                  ),
                  SizedBox(width: 10.w,),
                  selectWidget(
                      title: AppStrings.week,
                      width: 46.w,
                      isSelected: isWeek,
                      onTap: (){
                        weekSelect();
                      }
                  ),
                  SizedBox(width: 10.w,),
                  selectWidget(
                      title: AppStrings.month,
                      width: 50.w,
                      isSelected: isMonth,
                      onTap: (){
                        monthSelect();
                      }
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        graph,
        SizedBox(height: 2.h,),
      ],
    ),
  );
}