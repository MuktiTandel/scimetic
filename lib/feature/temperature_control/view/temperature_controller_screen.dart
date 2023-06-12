import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/commom_enable_title_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
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
      body: Obx(() =>  controller.isGetData.value == true
          ? ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonEnableTitleWidget(
                        title: AppStrings.cooling,
                        isSelect: controller.isCoolingEnable
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBorder,
                    ),
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
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.dayCoolingValue.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayCoolingValue.value = value;
                              },
                            isEdit: false.obs,
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.dayCoolingRelayList,
                              value: controller.dayCoolingRelaySelection.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayCoolingRelaySelection.value = value;
                              },
                            isEdit: false.obs,
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
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.nightCoolingSwitch.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.nightCoolingSwitch.value = value;
                                },
                              isEdit: false.obs,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.nightCoolingRelayList,
                                value: controller.nightCoolingRelay.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.nightCoolingRelay.value = value;
                                },
                              isEdit: false.obs,
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
                    commonEnableTitleWidget(
                        title: AppStrings.heating,
                        isSelect: controller.isHeatingEnable
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBorder,
                    ),
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
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.dayCoolingValue.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayCoolingValue.value = value;
                              },
                            isEdit: false.obs,
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.dayCoolingRelayList,
                              value: controller.dayCoolingRelaySelection.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayCoolingRelaySelection.value = value;
                              },
                            isEdit: false.obs,
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
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.dayCoolingValue.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.dayCoolingValue.value = value;
                                },
                              isEdit: false.obs,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.dayCoolingRelayList,
                                value: controller.dayCoolingRelaySelection.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.dayCoolingRelaySelection.value = value;
                                },
                              isEdit: false.obs,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTitleWidget(
                        title: AppStrings.extractorFan,
                        isSelect: controller.isExtractorFanOn
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBorder,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayMode,
                              color: AppColors.lightBlue
                          ),
                          SizedBox(height: 8.h,),
                          commonTexField(
                              title: AppStrings.temperature,
                              controller: controller.extractorDayTemperature,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value){}
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.extractorFanDaySwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.extractorFanDaySwitch.value = value;
                              },
                            isEdit: false.obs,
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.extractorFanDayRelayList,
                              value: controller.extractorFanDayRelay.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.extractorFanDayRelay.value = value;
                              },
                            isEdit: false.obs,
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
                                title: AppStrings.nightMode,
                                color: AppColors.lightBlue
                            ),
                            SizedBox(height: 8.h,),
                            commonTexField(
                                title: AppStrings.temperature,
                                controller: controller.extractorNightTemperature,
                                suffixText: "°C",
                                hintText: AppStrings.temperature,
                                onChanged: (value){}
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.extractorFanNightSwitch.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.extractorFanNightSwitch.value = value;
                                },
                              isEdit: false.obs,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.extractorFanNightRelayList,
                                value: controller.extractorFanNightRelay.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.extractorFanNightRelay.value = value;
                                },
                              isEdit: false.obs,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonTitleWidget(
                        title: AppStrings.wetWall,
                        isSelect: controller.isExtractorFanOn
                    ),
                    Divider(
                      thickness: 1.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText : AppColors.lightBorder,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayMode,
                              color: AppColors.lightBlue
                          ),
                          SizedBox(height: 8.h,),
                          commonTexField(
                              title: AppStrings.temperature,
                              controller: controller.wetWallDayTemperature,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value){}
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.wetWallDaySwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.wetWallDaySwitch.value = value;
                              },
                            isEdit: false.obs,
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(height: 5.h,),
                          CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.wetWalDayRelayList,
                              value: controller.wetWalDayRelay.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.wetWalDayRelay.value = value;
                              },
                            isEdit: false.obs,
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
                                title: AppStrings.nightMode,
                                color: AppColors.lightBlue
                            ),
                            SizedBox(height: 8.h,),
                            commonTexField(
                                title: AppStrings.temperature,
                                controller: controller.wetWallNightTemperature,
                                suffixText: "°C",
                                hintText: AppStrings.temperature,
                                onChanged: (value){}
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.switchList,
                                value: controller.wetWallNightSwitch.value,
                                isFilled: Get.isDarkMode ? true : false,
                                onChange: (value) {
                                  controller.wetWallNightSwitch.value = value;
                                },
                              isEdit: false.obs,
                            ),
                            SizedBox(height: 10.h,),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(height: 5.h,),
                            CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller.wetWalNightRelayList,
                                value: controller.wetWalNightRelay.value,
                                isFilled: Get.isDarkMode ? true : false,
                                isEdit: false.obs,
                                onChange: (value) {
                                  controller.wetWalNightRelay.value = value;
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
      )
          : const Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,
        ),
      ),)
    );
  }

  Widget commonTitleWidget({required String title, required RxBool isSelect}) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
      child: Row(
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            color: AppColors.buttonColor,
            fontWeight: FontWeight.w500,
          ),
          Expanded(child: SizedBox(width: 10.w,)),
          CustomText(
            text: AppStrings.auto,
            fontSize: 14.sp,
            color: AppColors.buttonColor,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(width: 5.w,),
          Obx(() => GestureDetector(
            onTap: (){
              controller.isExtractorFanOn.value = !controller.isExtractorFanOn.value;
            },
            child: Image.asset(
              controller.isExtractorFanOn.value == false
                  ? Get.isDarkMode
                  ? AppImages.darkSelectedToggle : AppImages.lightSelectToggle
                  : Get.isDarkMode
                  ? AppImages.darkUnselectToggle : AppImages.lightUnselectToggle,
              height: 30.h,
              width: 30.w,
            ),
          ),),
          SizedBox(width: 5.w,),
          Obx(() =>  CustomText(
            text: controller.isExtractorFanOn.value
                ? AppStrings.off : AppStrings.on,
            fontSize: 14.sp,
            color: controller.isExtractorFanOn.value
                ? AppColors.lightText
                : Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
            fontWeight: FontWeight.w500,
          ),)
        ],
      ),
    );
  }
}
