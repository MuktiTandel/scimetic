import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/Outline_button.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/extractor_control/controller/extractor_control_controller.dart';

class ExtractorControlScreen extends StatelessWidget {
  ExtractorControlScreen({Key? key}) : super(key: key);

  final controller = Get.put(ExtractorControlController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 5.h),
                child: Row(
                  children: [
                    CustomText(
                      text: AppStrings.auto,
                      fontSize: 14.sp,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(
                          () => GestureDetector(
                        onTap: () {
                          controller.isAuto.value = !controller.isAuto.value;
                        },
                        child: Image.asset(
                          controller.isAuto.value == false
                              ? Get.isDarkMode
                              ? AppImages.darkSelectedToggle
                              : AppImages.lightSelectToggle
                              : Get.isDarkMode
                              ? AppImages.darkUnselectToggle
                              : AppImages.lightUnselectToggle,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Obx(
                          () => CustomText(
                        text: controller.isAuto.value ? AppStrings.off : AppStrings.on,
                        fontSize: 14.sp,
                        color: controller.isAuto.value
                            ? AppColors.lightText
                            : Get.isDarkMode
                            ? AppColors.darkText
                            : AppColors.subTitleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: context.theme.cardColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => controller.isValid.value == false
                              ? Column(
                                  children: [
                                    commonErrorWidget(
                                        onTap: () {
                                          controller.isValid.value = true;
                                        },
                                        errorMessage:
                                            controller.errorMessage.value),
                                    SizedBox(
                                      height: 10.h,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink()),
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayMode,
                              color: AppColors.lightBlue),
                          SizedBox(
                            height: 10.h,
                          ),
                          commonTexField(
                              title: AppStrings.temperature,
                              controller: controller.dayTemperatureController,
                              suffixText: "°C",
                              hintText: AppStrings.temperature,
                              onChanged: (value) {}),
                          SizedBox(
                            height: 15.h,
                          ),
                          commonTexField(
                              title: AppStrings.temperatureDeadband,
                              controller:
                                  controller.dayTemperatureDeadbandController,
                              suffixText: "°C",
                              hintText: AppStrings.temperatureDeadband,
                              onChanged: (value) {}),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomText(
                            text: AppStrings.switchSelection,
                            color: Get.isDarkMode
                                ? AppColors.darkText
                                : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Obx(
                            () => CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.isGetData.value == true
                                  ? controller.switchList
                                  : [],
                              value: controller.daySwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.daySwitch.value = value;
                              },
                              isEdit: false.obs,
                              isEnable: false,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomText(
                            text: AppStrings.relaySelection,
                            color: Get.isDarkMode
                                ? AppColors.darkText
                                : AppColors.lightText,
                            fontSize: 12.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomDropDown(
                            width: 330.w,
                            hintText: AppStrings.chooseRelay,
                            itemList: controller.dayRelayList,
                            value: controller.dayRelay.value,
                            isFilled: Get.isDarkMode ? true : false,
                            onChange: (value) {
                              controller.dayRelay.value = value;
                            },
                            isEdit: false.obs,
                            isEnable: false,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Get.isDarkMode
                              ? AppColors.darkAppbar
                              : AppColors.lightAppbar,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonImageText(
                                image: AppImages.fillMoon,
                                title: AppStrings.nightMode,
                                color: AppColors.lightBlue),
                            SizedBox(
                              height: 10.h,
                            ),
                            commonTexField(
                                title: AppStrings.temperature,
                                controller:
                                    controller.nightTemperatureController,
                                suffixText: "°C",
                                hintText: AppStrings.temperature,
                                isFilled: true,
                                onChanged: (value) {}),
                            SizedBox(
                              height: 15.h,
                            ),
                            commonTexField(
                                title: AppStrings.temperatureDeadband,
                                controller: controller
                                    .nightTemperatureDeadbandController,
                                suffixText: "°C",
                                isFilled: true,
                                hintText: AppStrings.temperatureDeadband,
                                onChanged: (value) {}),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomText(
                              text: AppStrings.switchSelection,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Obx(
                              () => CustomDropDown(
                                width: 320.w,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.isGetData.value == true
                                    ? controller.switchList
                                    : [],
                                value: controller.nightSwitch.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.nightSwitch.value = value;
                                },
                                isEdit: false.obs,
                                isEnable: false,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomText(
                              text: AppStrings.relaySelection,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                              fontSize: 12.h,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseRelay,
                              itemList: controller.nightRelayList,
                              value: controller.nightRelay.value,
                              isFilled: true,
                              onChange: (value) {
                                controller.nightRelay.value = value;
                              },
                              isEdit: false.obs,
                              isEnable: false,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Row(
                  children: [
                    Expanded(
                      child: OutLineButton(
                        onTap: () {},
                        buttonText: AppStrings.cancel,
                        color: AppColors.red,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                        child: CustomButton(
                      onTap: () {
                        controller.onSave();
                      },
                      buttonText: AppStrings.save,
                      fontSize: 14.sp,
                      height: 40.h,
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
