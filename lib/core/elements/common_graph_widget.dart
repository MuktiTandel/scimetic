import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/hwm_select_widge.dart';

Widget commonGraphWidget( {
  required String title,
  required String image,
  required String value,
  required String value1,
  required bool isHour,
  required bool isWeek,
  required bool isMonth,
  required Widget graph,
  required VoidCallback hourSelect,
  required VoidCallback weekSelect,
  required VoidCallback monthSelect,
  required Color color,
  required VoidCallback onTap,
  required bool isPhase,
  String? value2,
  String? value3,
  String? title1,
  String? title2,
  String? title3
}) {
  return GestureDetector(
    onTap: (){
      onTap();
    },
    child: Container(
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
                isPhase == false ? SizedBox(
                  height: 40.h,
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
                ) : SizedBox(
                  height: 50.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 10.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: title1 ?? "",
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightGray1,
                            fontSize: 11.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: value,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                              SizedBox(width: 4.w,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: 3.h),
                                child: CustomText(
                                  text: value1,
                                  fontSize: 15.sp,
                                  color: color,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 10.w,),
                      SizedBox(
                        height: 22.h,
                        child: VerticalDivider(
                          thickness: 1.w,
                          color: Get.isDarkMode
                              ? AppColors.darkText : AppColors.lightGray1,
                        ),
                      ),
                      SizedBox(width: 20.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: title2 ?? "",
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightGray1,
                            fontSize: 11.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: value2 ?? "",
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                              SizedBox(width: 4.w,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: 3.h),
                                child: CustomText(
                                  text: value1,
                                  fontSize: 15.sp,
                                  color: color,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 20.w,),
                      SizedBox(
                        height: 22.h,
                        child: VerticalDivider(
                          thickness: 1.w,
                          color: Get.isDarkMode
                              ? AppColors.darkText : AppColors.lightGray1,
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: title3 ?? "",
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightGray1,
                            fontSize: 11.w,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(
                                text: value3 ?? "",
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                              SizedBox(width: 4.w,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: 3.h),
                                child: CustomText(
                                  text: value1,
                                  fontSize: 15.sp,
                                  color: color,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(width: 20.w,)
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    hwmSelectWidget(
                        title: AppStrings.hours,
                        width: 34.w,
                        isSelected: isHour,
                        onTap: (){
                          hourSelect();
                        }
                    ),
                    SizedBox(width: 10.w,),
                    hwmSelectWidget(
                        title: AppStrings.week,
                        width: 46.w,
                        isSelected: isWeek,
                        onTap: (){
                          weekSelect();
                        }
                    ),
                    SizedBox(width: 10.w,),
                    hwmSelectWidget(
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
    ),
  );
}