import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';

Widget deviceOverviewWidget() {
  return Container(
    width: Get.width,
    color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
    child: Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(15.w),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.deviceOverview,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              Image.asset(
                AppImages.horizontalMenu,
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
          color: Get.isDarkMode
              ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
        ),
        Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              commonDeviceOverviewWidget(title: AppStrings.switches),
              SizedBox(height: 10.h,),
              commonDeviceOverviewWidget(title: AppStrings.sensor),
              SizedBox(height: 10.h,),
              commonDeviceOverviewWidget(title: AppStrings.valves),
              SizedBox(height: 15.h,),
              CustomButton(
                onTap: (){},
                height: 42.h,
                buttonText: AppStrings.addNewDevice,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.add,
                        height: 15.h,
                        width: 15.w,
                      ),
                      SizedBox(width: 10.w,),
                      CustomText(
                        text: AppStrings.addNewDevice,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget commonDeviceOverviewWidget( {required String title }) {
  return Container(
    padding: EdgeInsets.all(10.w),
    color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
    child: Column(
      children: [
        Row(
          children: [
            CustomText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.buttonColor,
            ),
            Expanded(child: SizedBox(width: 10.w,)),
            Row(
              children: [
                Image.asset(
                  AppImages.warning,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 5.w,),
                CustomText(
                  text: AppStrings.check,
                  fontSize: 14.sp,
                  color: AppColors.darkOrange1,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: 10.w,),
                Image.asset(
                  AppImages.rightArrow,
                  height: 12.h,
                  width: 12.w,
                  color: AppColors.darkOrange1,
                )
              ],
            )
          ],
        ),
        SizedBox(height: 8.h,),
        Row(
          children: [
            Image.asset(
              AppImages.greenEllipse,
              height: 8.h,
              width: 8.w,
            ),
            SizedBox(width: 5.w,),
            CustomText(
              text: "15",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            CustomText(
              text: AppStrings.online,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            SizedBox(width: 15.w,),
            Image.asset(
              AppImages.redEllipse,
              height: 8.h,
              width: 8.w,
            ),
            SizedBox(width: 5.w,),
            CustomText(
              text: "3",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            CustomText(
              text: AppStrings.offline,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ],
        )
      ],
    ),
  );
}