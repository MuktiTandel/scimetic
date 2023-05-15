import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_status_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/humidity_control/controller/humidity_controller.dart';

class HumidityControlScreen extends StatelessWidget {
   HumidityControlScreen({Key? key}) : super(key: key);

   final controller = Get.put(HumidityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              commonStatusWidget(isOn: controller.isOn),
              Container(
                color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayHumidityMode,
                              color: AppColors.lightBlue
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.setTargetRelativeHumidity,
                              controller: controller.dayHumidityTarget,
                              suffixText: "%",
                              hintText: AppStrings.rH,
                              onChanged: (value) {},
                            contentPadding: 20.w
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.deadband,
                              controller: controller.dayHumidityDeadband,
                              suffixText: "%",
                              hintText: AppStrings.rH,
                              onChanged: (value){},
                              contentPadding: 20.w
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
                              itemList: controller.dayHumidityList,
                              value: controller.dayHumidityValue.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayHumidityValue.value = value;
                              }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10.w),
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
                                title: AppStrings.nightHumidityMode,
                                color: AppColors.lightBlue
                            ),
                            SizedBox(height: 8.h,),
                            commonTexField(
                                title: AppStrings.setTargetRelativeHumidity,
                                controller: controller.nightHumidityTarget,
                                suffixText: "%",
                                hintText: AppStrings.rH,
                                onChanged: (value) {},
                                contentPadding: 20.w
                            ),
                            SizedBox(height: 10.h,),
                            commonTexField(
                                title: AppStrings.deadband,
                                controller: controller.nightHumidityDeadband,
                                suffixText: "%",
                                hintText: AppStrings.rH,
                                onChanged: (value) {},
                                contentPadding: 20.w
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
                              itemList: controller.nightHumidityList,
                              value: controller.nightHumidityValue.value,
                              onChange: (value) {
                                controller.nightHumidityValue.value = value;
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
              SizedBox(height: 10.h,),
              Container(
                color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayDehumidificationMode,
                              color: AppColors.lightGray1
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.setTargetRelativeHumidity,
                              controller: controller.dayDehumidificationTarget,
                              suffixText: "%",
                              hintText: AppStrings.rH,
                              onChanged: (value) {},
                              contentPadding: 20.w
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.deadband,
                              controller: controller.dayDehumidificationDeadband,
                              suffixText: "%",
                              hintText: AppStrings.rH,
                              onChanged: (value){},
                              contentPadding: 20.w
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
                              itemList: controller.dayDehumidificationList,
                              value: controller.dayDehumidificationValue.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayDehumidificationValue.value = value;
                              }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
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
                                title: AppStrings.nightHumidityMode,
                                color: AppColors.lightGray1
                            ),
                            SizedBox(height: 8.h,),
                            commonTexField(
                                title: AppStrings.setTargetRelativeHumidity,
                                controller: controller.nightDehumidificationTarget,
                                suffixText: "%",
                                hintText: AppStrings.rH,
                                onChanged: (value) {},
                                contentPadding: 20.w
                            ),
                            SizedBox(height: 10.h,),
                            commonTexField(
                                title: AppStrings.deadband,
                                controller: controller.nightDehumidificationDeadband,
                                suffixText: "%",
                                hintText: AppStrings.rH,
                                onChanged: (value) {},
                                contentPadding: 20.w
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
                              itemList: controller.nightDehumidificationList,
                              value: controller.nightDehumidificationValue.value,
                              onChange: (value) {
                                controller.nightDehumidificationValue.value = value;
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
              Padding(
                padding: EdgeInsets.all(15.w),
                child: CustomButton(
                  onTap: () {
                    controller.nightDehumidificationDeadband.clear();
                    controller.nightDehumidificationTarget.clear();
                    controller.dayDehumidificationDeadband.clear();
                    controller.dayDehumidificationTarget.clear();
                    controller.nightHumidityDeadband.clear();
                    controller.nightHumidityTarget.clear();
                    controller.dayHumidityDeadband.clear();
                    controller.dayHumidityTarget.clear();
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
    );
  }
}
