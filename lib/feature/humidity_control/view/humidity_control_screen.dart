import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_erroe_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
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
              Obx(() => controller.isValid.value == true
                  ? const SizedBox.shrink()
                  : Padding(
                padding:  EdgeInsets.all(15.w),
                child: commonErrorWidget(
                    onTap: (){
                      controller.isValid.value = true;
                    },
                    errorMessage: controller.errorMessage.value),
              ),),
              Obx(() => controller.isValid.value == false
                  ? SizedBox(height: 10.h,) : const SizedBox.shrink(),),
              Container(
                color:
                Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayHumidityMode,
                              color: AppColors.lightBlue),
                          SizedBox(
                            height: 10.h,
                          ),
                          commonTexField(
                              title: AppStrings.setTargetRelativeHumidity,
                              controller: controller.dayHumidityRHController,
                              suffixText: "%",
                              hintText: "RH",
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.deadband,
                              controller: controller.dayHumidityRHDeadbandController,
                              suffixText: "%",
                              hintText: "RH",
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
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
                          Obx(() => CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.dayHumiditySwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayHumiditySwitch.value =
                                    value;
                              },
                            isEdit: false.obs,
                              ),
                          ),
                          SizedBox(
                            height: 10.h,
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
                              itemList: controller.dayHumidityRelayList,
                              value: controller.dayHumidityRelay.value,
                              isFilled: true,
                              onChange: (value) {
                                controller.dayHumidityRelay.value = value;

                                controller.dayDehumidificationRelayList
                                    .removeWhere((element)
                                => (element.contains(value)));

                              },
                            isEdit: false.obs,
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
                          color: Get.isDarkMode
                              ? AppColors.darkAppbar
                              : AppColors.lightAppbar,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonImageText(
                                image: AppImages.fillMoon,
                                title: AppStrings.nightHumidityMode,
                                color: AppColors.lightBlue),
                            SizedBox(
                              height: 10.h,
                            ),
                            commonTexField(
                                title: AppStrings.setTargetRelativeHumidity,
                                controller: controller.nightHumidityRHController,
                                suffixText: "%",
                                hintText: "RH",
                                isFilled: true,
                                onChanged: (value) {}
                            ),
                            SizedBox(height: 10.h,),
                            commonTexField(
                                title: AppStrings.deadband,
                                controller: controller.nightHumidityRHDeadbandController,
                                suffixText: "%",
                                hintText: "RH",
                                onChanged: (value) {},
                              isFilled: true,
                            ),
                            SizedBox(height: 10.h,),
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
                            Obx(() => CustomDropDown(
                              width: 320.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller.nightHumiditySwitch.value,
                              onChange: (value) {
                                controller.nightHumiditySwitch.value =
                                    value;
                              },
                              isFilled: true,
                              isEdit: false.obs,
                            ),),
                            SizedBox(
                              height: 10.h,
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
                                width: 320.w,
                                hintText: AppStrings.chooseRelay,
                                itemList:
                                controller.nightHumidityRelayList,
                                value:
                                controller.nightHumidityRelay.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.nightHumidityRelay.value =
                                      value;

                                  controller.nightDehumidificationRelayList
                                      .removeWhere((element) => (element.contains(value)));
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
                color:
                Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonImageText(
                              image: AppImages.fillSun,
                              title: AppStrings.dayDehumidificationMode,
                              color: AppColors.lightGray1),
                          SizedBox(
                            height: 10.h,
                          ),
                          commonTexField(
                              title: AppStrings.setTargetRelativeHumidity,
                              controller: controller.dayDehumidityRHController,
                              suffixText: "%",
                              hintText: "RH",
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
                          commonTexField(
                              title: AppStrings.deadband,
                              controller: controller.dayDehumidityRHDeadbandController,
                              suffixText: "%",
                              hintText: "RH",
                              onChanged: (value) {}
                          ),
                          SizedBox(height: 10.h,),
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
                          Obx(() => CustomDropDown(
                              width: 330.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller
                                  .dayDehumidificationSwitch.value,
                              isFilled: Get.isDarkMode ? true : false,
                              onChange: (value) {
                                controller.dayDehumidificationSwitch
                                    .value = value;
                              },
                            isEdit: false.obs,
                              ),
                          ),
                          SizedBox(
                            height: 10.h,
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
                              itemList:
                              controller.dayDehumidificationRelayList,
                              value: controller
                                  .dayDehumidificationRelay.value,
                              isFilled: true,
                              onChange: (value) {
                                controller.dayDehumidificationRelay
                                    .value = value;

                                controller.dayHumidityRelayList
                                    .removeWhere((element) =>
                                (element.contains(value)));

                              },
                            isEdit: false.obs,
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
                          color: Get.isDarkMode
                              ? AppColors.darkAppbar
                              : AppColors.lightAppbar,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonImageText(
                                image: AppImages.fillMoon,
                                title: AppStrings.nightHumidityMode,
                                color: AppColors.lightGray1),
                            SizedBox(
                              height: 10.h,
                            ),
                            commonTexField(
                                title: AppStrings.setTargetRelativeHumidity,
                                controller: controller.nightDehumidityRHController,
                                suffixText: "%",
                                hintText: "RH",
                                onChanged: (value) {},
                              isFilled: true,
                            ),
                            SizedBox(height: 10.h,),
                            commonTexField(
                                title: AppStrings.deadband,
                                controller: controller.nightDehumidityRHDeadbandController,
                                suffixText: "%",
                                hintText: "RH",
                                onChanged: (value) {},
                              isFilled: true,
                            ),
                            SizedBox(height: 10.h,),
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
                            Obx(() => CustomDropDown(
                              width: 320.w,
                              hintText: AppStrings.chooseSwitch,
                              itemList: controller.switchList,
                              value: controller
                                  .nightDehumidificationSwitch.value,
                              onChange: (value) {

                                controller.nightDehumidificationSwitch
                                    .value = value;

                                controller.nightHumidityRelayList
                                    .removeWhere((element) => (element.contains(value)));

                              },
                              isFilled: true,
                              isEdit: false.obs,
                            ),),
                            SizedBox(
                              height: 10.h,
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
                                width: 320.w,
                                yValue: 0,
                                hintText: AppStrings.chooseRelay,
                                itemList: controller
                                    .nightDehumidificationRelayList,
                                value: controller
                                    .nightDehumidificationRelay.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.nightDehumidificationRelay
                                      .value = value;
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
              Padding(
                padding: EdgeInsets.all(15.w),
                child: CustomButton(
                  onTap: () {
                    controller.onSave();
                  },
                  buttonText: AppStrings.save,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
