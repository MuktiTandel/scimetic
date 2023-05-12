import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_status_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/common_time_textfield.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/temperature_control/controller/temperature_controller.dart';

class TemperatureControllerScreen extends StatelessWidget {
   TemperatureControllerScreen({Key? key}) : super(key: key);

   final controller = Get.put(TemperatureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          commonStatusWidget(isOn: controller.isOn),
          Expanded(
            child: ScrollConfiguration(
              behavior: AppBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonImageText(
                                    image: AppImages.fillSun,
                                    title: AppStrings.dayCoolingMode,
                                    color: AppColors.lightBlue
                                ),
                                SizedBox(height: 8.h,),
                                commonTexField(
                                    title: AppStrings.setTargetTemperature,
                                    controller: controller.dayCoolingTemperature,
                                    suffixText: "°C",
                                    hintText: AppStrings.temperature,
                                    onChanged: (value) {}
                                ),
                                SizedBox(height: 10.h,),
                                commonTexField(
                                    title: AppStrings.deadband,
                                    controller: controller.dayCoolingDeadband,
                                    suffixText: "°C",
                                    hintText: AppStrings.deadband,
                                    onChanged: (value) {}
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                  text: AppStrings.switchSelection,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 5.h,),
                                CustomDropDown(
                                    hintText: AppStrings.chooseSwitch,
                                    itemList: controller.dayCoolingItems,
                                    value: controller.dayCoolingValue.value,
                                    isFilled: Get.isDarkMode ? true : false,
                                    onChange: (value) {
                                      controller.dayCoolingValue.value = value;
                                    }
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonImageText(
                                      image: AppImages.fillMoon,
                                      title: AppStrings.nightCoolingMode,
                                      color: AppColors.lightBlue
                                  ),
                                  SizedBox(height: 8.h,),
                                  commonTexField(
                                      title: AppStrings.setTargetTemperature,
                                      controller: controller.nightCoolingTemperature,
                                      suffixText: "°C",
                                      hintText: AppStrings.temperature,
                                      onChanged: (value) {}
                                  ),
                                  SizedBox(height: 10.h,),
                                  commonTexField(
                                      title: AppStrings.deadband,
                                      controller: controller.nightCoolingDeadband,
                                      suffixText: "°C",
                                      hintText: AppStrings.deadband,
                                      onChanged: (value) {}
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    text: AppStrings.switchSelection,
                                    color: Get.isDarkMode
                                        ? AppColors.darkText : AppColors.lightText,
                                    fontSize: 12.h,
                                  ),
                                  SizedBox(height: 5.h,),
                                  CustomDropDown(
                                      hintText: AppStrings.chooseSwitch,
                                      itemList: controller.nightCoolingItems,
                                      value: controller.nightCoolingValue.value,
                                      onChange: (value) {
                                        controller.nightCoolingValue.value = value;
                                      },
                                    isFilled: Get.isDarkMode ? true : false,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonImageText(
                                    image: AppImages.fillSun,
                                    title: AppStrings.dayHeatingMode,
                                    color: AppColors.orange
                                ),
                                SizedBox(height: 8.h,),
                                commonTexField(
                                    title: AppStrings.setTargetTemperature,
                                    controller: controller.dayHeatingTemperature,
                                    suffixText: "°C",
                                    hintText: AppStrings.temperature,
                                    onChanged: (value) {}
                                ),
                                SizedBox(height: 10.h,),
                                commonTexField(
                                    title: AppStrings.deadband,
                                    controller: controller.dayHeatingDeadband,
                                    suffixText: "°C",
                                    hintText: AppStrings.deadband,
                                    onChanged: (value) {}
                                ),
                                SizedBox(height: 10.h,),
                                CustomText(
                                  text: AppStrings.switchSelection,
                                  color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                  fontSize: 12.h,
                                ),
                                SizedBox(height: 5.h,),
                                CustomDropDown(
                                    hintText: AppStrings.chooseSwitch,
                                    itemList: controller.dayHeatingItems,
                                    value: controller.dayHeatingValue.value,
                                    onChange: (value) {
                                      controller.dayHeatingValue.value = value;
                                    },
                                  isFilled: Get.isDarkMode ? true : false,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Get.isDarkMode
                                    ? AppColors.darkAppbar : AppColors.lightAppbar,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonImageText(
                                      image: AppImages.fillMoon,
                                      title: AppStrings.nightHeatingMode,
                                      color: AppColors.orange
                                  ),
                                  SizedBox(height: 8.h,),
                                  commonTexField(
                                      title: AppStrings.setTargetTemperature,
                                      controller: controller.nightHeatingTemperature,
                                      suffixText: "°C",
                                      hintText: AppStrings.temperature,
                                      onChanged: (value) {}
                                  ),
                                  SizedBox(height: 10.h,),
                                  commonTexField(
                                      title: AppStrings.deadband,
                                      controller: controller.nightHeatingDeadband,
                                      suffixText: "°C",
                                      hintText: AppStrings.deadband,
                                      onChanged: (value) {}
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    text: AppStrings.switchSelection,
                                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                    fontSize: 12.h,
                                  ),
                                  SizedBox(height: 5.h,),
                                  CustomDropDown(
                                      hintText: AppStrings.chooseSwitch,
                                      itemList: controller.nightHeatingItems,
                                      value: controller.nightHeatingValue.value,
                                      onChange: (value) {
                                        controller.nightHeatingValue.value = value;
                                      }
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: AppStrings.circulationFan,
                            fontSize: 14.sp,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperatureOOF,
                              controller: controller.circulationTemperature,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value){}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperatureOOFDeadband,
                              controller: controller.circulationDeadband,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.humidityON,
                              controller: controller.circulationHumidityTemperature,
                              suffixText: "%",
                                hintText: AppStrings.temperature,
                              contentPadding: 20.w,
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.humidityONDeadband,
                              controller: controller.circulationHumidityDeadband,
                              suffixText: "%",
                              hintText: AppStrings.temperature,
                              onChanged: (value){},
                            contentPadding: 20.w,
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
                                    text: AppStrings.timeON,
                                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                    fontSize: 12.h,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    children: [
                                      commonTimeTextField(
                                          controller: controller.timeOnHour,
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
                                          controller: controller.timeOnMinute,
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
                                    text: AppStrings.timeOFF,
                                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                    fontSize: 12.h,
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    children: [
                                      commonTimeTextField(
                                          controller: controller.timeOffHour,
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
                                          controller: controller.timeOffMinute,
                                          hintText: AppStrings.mm,
                                          onChanged: (value) {}
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppStrings.extractorFan,
                            fontSize: 14.sp,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperature,
                              controller: controller.extractorTemperature,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value){}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperatureOOF,
                              controller: controller.extractorTemperatureOOF,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value) {}
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppStrings.wetWall,
                            fontSize: 14.sp,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperature,
                              controller: controller.wetWallTemperature,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value){}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.temperatureDeadband,
                              controller: controller.wetWallDeadband,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value) {}
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: CustomButton(
                        onTap: () {
                          controller.timeOffMinute.clear();
                          controller.timeOffHour.clear();
                          controller.timeOnMinute.clear();
                          controller.timeOnHour.clear();
                          controller.wetWallDeadband.clear();
                          controller.wetWallTemperature.clear();
                          controller.extractorTemperatureOOF.clear();
                          controller.extractorTemperature.clear();
                          controller.circulationHumidityDeadband.clear();
                          controller.circulationHumidityTemperature.clear();
                          controller.circulationDeadband.clear();
                          controller.circulationTemperature.clear();
                          controller.nightHeatingDeadband.clear();
                          controller.nightHeatingTemperature.clear();
                          controller.dayHeatingDeadband.clear();
                          controller.dayHeatingTemperature.clear();
                          controller.nightCoolingDeadband.clear();
                          controller.nightCoolingTemperature.clear();
                        },
                        buttonText: AppStrings.save,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 30.h,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
