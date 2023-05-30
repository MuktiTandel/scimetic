import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_status_widget.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/feature/lightning_control/controller/lightning_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LightningControlScreen extends StatelessWidget {
  LightningControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(LightningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            commonStatusWidget(isOn: controller.isOn),
            Container(
              color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 15.w, right: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonImageText(
                            image: AppImages.fillSun,
                            title: AppStrings.dayLightningSettings,
                            color: AppColors.lightBlue
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: AppStrings.lightONTime,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    commonTimeTextField(
                                        controller: controller.dayLightOnHour,
                                        hintText: AppStrings.hh,
                                        onChanged: (value){}
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
                                        controller: controller.dayLightOnMinute,
                                        hintText: AppStrings.mm,
                                        onChanged: (value) {}
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
                                  text: AppStrings.lightOFFTime,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 5.h,),
                                Row(
                                  children: [
                                    commonTimeTextField(
                                        controller: controller.dayLightOffHour,
                                        hintText: AppStrings.hh,
                                        onChanged: (value){}
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
                                        controller: controller.dayLightOffMinute,
                                        hintText: AppStrings.mm,
                                        onChanged: (value) {}
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        CustomText(
                          text: AppStrings.lightOutputLevel,
                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                          fontSize: 12.h,
                        ),
                        SizedBox(height: 10.h,),
                        Obx(() =>  CustomText(
                          text: "${controller.dayLightOutput.round()}%",
                          color: AppColors.buttonColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),),
                      ],
                    ),
                  ),
                  slider(selectValue: controller.dayLightOutput),
                  SizedBox(height: 10.h,),
                  Padding(
                      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 10.w),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonImageText(
                                    image: AppImages.fillMoon,
                                    title: AppStrings.nightLightningSettings,
                                    color: AppColors.lightBlue
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.lightONTime,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
                                        Row(
                                          children: [
                                            commonTimeTextField(
                                                controller: controller.nightLightOnHour,
                                                hintText: AppStrings.hh,
                                                onChanged: (value){}
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
                                                controller: controller.nightLightOnMinute,
                                                hintText: AppStrings.mm,
                                                onChanged: (value) {}
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
                                          text: AppStrings.lightOFFTime,
                                          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                          fontSize: 12.h,
                                        ),
                                        SizedBox(height: 5.h,),
                                        Row(
                                          children: [
                                            commonTimeTextField(
                                                controller: controller.nightLightOffHour,
                                                hintText: AppStrings.hh,
                                                onChanged: (value){}
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
                                                controller: controller.nightLightOffMinute,
                                                hintText: AppStrings.mm,
                                                onChanged: (value) {}
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                  text: AppStrings.lightOutputLevel,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 10.h,),
                                Obx(() =>  CustomText(
                                  text: "${controller.nightLightOutput.round()}%",
                                  color: AppColors.buttonColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),),
                              ],
                            ),
                          ),
                          slider(
                              selectValue: controller.nightLightOutput
                          ),
                          SizedBox(height: 15.h,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,)
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: context.theme.scaffoldBackgroundColor,
        padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
        child: CustomButton(
          onTap: () {
            controller.nightLightOffMinute.clear();
            controller.nightLightOffHour.clear();
            controller.nightLightOnMinute.clear();
            controller.nightLightOnHour.clear();
            controller.dayLightOffMinute.clear();
            controller.dayLightOffHour.clear();
            controller.dayLightOnMinute.clear();
            controller.dayLightOnHour.clear();
          },
          buttonText: AppStrings.save,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget slider({ required RxDouble selectValue}) {
    return Obx(() => Center(
      child: SfSliderTheme(
        data: SfSliderThemeData(
          activeTrackHeight: 6.h,
          inactiveTrackHeight: 6.h,
          activeTrackColor: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightGray2,
          inactiveTrackColor: Get.isDarkMode ? AppColors.darkIcon : AppColors.lightGray2,
          activeLabelStyle: TextStyle(
              color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightGray3,
              fontSize: 12.sp,
              fontFamily: "Poppins"
          ),
          inactiveLabelStyle: TextStyle(
              color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightGray3,
              fontSize: 12.sp,
              fontFamily: "Poppins"
          ),
          thumbColor: Get.isDarkMode ? AppColors.darkIcon : Colors.white,
          thumbStrokeColor: AppColors.buttonColor,
          thumbStrokeWidth: 2.w,
          overlayColor: AppColors.buttonColor.withOpacity(0.1),
        ),
        child: SizedBox(
          width: Get.width,
          child: SfSlider(
              value: selectValue.value,
              min: 0.0,
              max: 100.0,
              labelFormatterCallback: (dynamic actualValue, String value) {
                return actualValue = "$value%";
              },
              showLabels: true,
              onChanged: (value) {
                selectValue.value = value;
              }
          ),
        ),
      ),
    ));
  }
}
