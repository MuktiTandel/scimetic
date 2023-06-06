import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
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
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.dayHumiditySwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayHumiditySwitch.value = value;
                              }
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 310.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.dayHumidityRelayList,
                              value: controller.dayHumidityRelay.value,
                              isFilled: true,
                              onChange: (value) {
                                controller.dayHumidityRelay.value = value;
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
                              itemList: controller.switchList,
                              value: controller.nightHumiditySwitch.value,
                              onChange: (value) {
                                controller.nightHumiditySwitch.value = value;
                              },
                              isFilled: true,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 310.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.nightHumidityRelayList,
                                value: controller.nightHumidityRelay.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.nightHumidityRelay.value = value;
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
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.dayDehumidificationSwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayDehumidificationSwitch.value = value;
                              }
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 310.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.dayDehumidificationRelayList,
                              value: controller.dayDehumidificationRelay.value,
                              isFilled: true,
                              onChange: (value) {
                                controller.dayDehumidificationRelay.value = value;
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
                              itemList: controller.switchList,
                              value: controller.nightDehumidificationSwitch.value,
                              onChange: (value) {
                                controller.nightDehumidificationSwitch.value = value;
                              },
                              isFilled: true,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 310.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.nightDehumidificationRelayList,
                                value: controller.nightDehumidificationRelay.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.nightDehumidificationRelay.value = value;
                                }
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
