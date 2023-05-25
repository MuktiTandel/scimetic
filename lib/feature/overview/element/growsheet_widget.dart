import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

Widget growSheetWidget() {
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
                text: AppStrings.growsheet,
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
          padding:  EdgeInsets.all(15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.theTypeOfPlant,
                fontSize: 20.sp,
                color: AppColors.buttonColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5.h,),
              CustomText(
                text: AppStrings.theGenealogy,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? AppColors.darkBlue : AppColors.lightAppbar,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.stage,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          PopupMenuButton<int>(
                            offset: Offset(0, 23.h),
                            padding: EdgeInsets.zero,
                            color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                            constraints: BoxConstraints(
                                maxWidth: 126.w,
                                maxHeight: 138.h
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                CustomText(
                                  text: AppStrings.flowering,
                                  fontSize: 15.sp,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(width: 1.w,),
                                Image.asset(
                                  AppImages.downArrow,
                                  color: AppColors.red,
                                  height: 25.h,
                                  width: 25.w,
                                ),
                              ],
                            ),
                            onSelected: (item) {},
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                  padding: EdgeInsets.zero,
                                  value: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.germination,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Divider(
                                        color: Get.isDarkMode
                                            ? AppColors.darkBlue1
                                            : AppColors.lightGray2,
                                        thickness: 1.w,
                                      )
                                    ],
                                  )
                              ),
                              PopupMenuItem<int>(
                                  padding: EdgeInsets.zero,
                                  value: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.seedling,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Divider(
                                        color: Get.isDarkMode
                                            ? AppColors.darkBlue1
                                            : AppColors.lightGray2,
                                        thickness: 1.w,
                                      )
                                    ],
                                  )
                              ),
                              PopupMenuItem<int>(
                                  padding: EdgeInsets.zero,
                                  value: 0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                        child: CustomText(
                                          text: AppStrings.vegetative,
                                          fontSize: 15.sp,
                                          color: Get.isDarkMode
                                              ? AppColors.darkText : AppColors.lightGray1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Divider(
                                        color: Get.isDarkMode
                                            ? AppColors.darkBlue1
                                            : AppColors.lightGray2,
                                        thickness: 1.w,
                                      )
                                    ],
                                  )
                              ),
                              PopupMenuItem<int>(
                                  value: 1,
                                  padding: EdgeInsets.zero,
                                  height: 20.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                    child: CustomText(
                                      text: AppStrings.flowering,
                                      fontSize: 15.sp,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText : AppColors.lightGray1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.planted,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          CustomText(
                            text: "01.03.2020",
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.estimatedHarvestTime,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          CustomText(
                            text: "30.03.2021",
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          CustomText(
                            text: AppStrings.barcode,
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? AppColors.darkIcon
                                : AppColors.lightGray1,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          CustomText(
                            text: "1234567891012",
                            fontSize: 15.sp,
                            color: Get.isDarkMode
                                ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: -15,
                    endAngle: 350,
                    radiusFactor: 0.80,
                    canScaleToFit: true,
                    axisLineStyle:  AxisLineStyle(
                      thickness: 0.25,
                      color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
                      thicknessUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.startCurve,
                    ),
                    pointers: const <GaugePointer>[
                      RangePointer(
                        value: 85,
                        width: 0.25,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: AppColors.pink,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                      RangePointer(
                          value: 65,
                          width: 0.25,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: AppColors.lightGreen3,
                          cornerStyle: CornerStyle.bothCurve),
                      RangePointer(
                          value: 45,
                          width: 0.25,
                          color: AppColors.purple,
                          sizeUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve),
                    ],
                    annotations: [
                      GaugeAnnotation(
                          widget: Center(
                            child: Padding(
                              padding:  EdgeInsets.only(left: 30.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: "75%",
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Get.isDarkMode
                                        ? Colors.white : Colors.black,
                                  ),
                                  CustomText(
                                    text: AppStrings.progress,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightGray1,
                                    fontSize: 20.sp,
                                  )
                                ],
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}