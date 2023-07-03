import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_enable_title_widget.dart';
import 'package:scimetic/core/elements/common_hour_minute_widget.dart';
import 'package:scimetic/core/elements/common_textfield_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/control_tab/controller/control_tab_controller.dart';

class ControlTabScreen extends StatelessWidget {
   ControlTabScreen({Key? key}) : super(key: key);

   final controller = Get.put(ControlTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Container(
        color: context.theme.cardColor,
        child: ScrollConfiguration(
          behavior: AppBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                commonEnableTitleWidget(
                    title: AppStrings.blackOutScreenSetting,
                    isSelect: controller.isBlackOutEnable,
                  titleColor: AppColors.lightBlue,
                  onTap: (){}
                ),
                Padding(
                    padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonTexField(
                          title: AppStrings.blackOutScreenOpen,
                          controller: controller.blackOutScreenOpenController,
                          suffixText: "µmol/s",
                          hintText: AppStrings.blackOutScreenOpen,
                          onChanged: (value) {}
                      ),
                      SizedBox(height: 10.h,),
                      commonTexField(
                          title: AppStrings.blackOutScreenClose,
                          controller: controller.blackOutScreenCloseController,
                          suffixText: "µmol/s",
                          hintText: AppStrings.blackOutScreenClose,
                          onChanged: (value) {}
                      ),
                      SizedBox(height: 10.h,),
                      commonHourMinuteWidget(
                          title1: AppStrings.timeON,
                          hour1: controller.timeOnHourController,
                          minute1: controller.timeOnMinuteController,
                          title2: AppStrings.timeOFF,
                          hour2: controller.timeOffHourController,
                          minute2: controller.timeOffMinuteController
                      ),
                      SizedBox(height: 10.h,),
                      CustomText(
                        text: AppStrings.switchSelection,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                        fontSize: 12.h,
                      ),
                      SizedBox(height: 5.h,),
                      Obx(() => CustomDropDown(
                        width: 330.w,
                        hintText: AppStrings.chooseSwitch,
                        itemList: controller.isGetData.value == true
                            ? controller.switchList : [],
                        value: controller.blackOutSwitch.value,
                        isFilled: Get.isDarkMode ? true : false,
                        onChange: (value) {
                          controller.blackOutSwitch.value = value;
                        },
                        isEdit: false.obs,
                        isEnable: false,
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomText(
                        text: AppStrings.relaySelection,
                        color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                        fontSize: 12.h,
                      ),
                      SizedBox(height: 5.h,),
                      CustomDropDown(
                          width: 330.w,
                          hintText: AppStrings.chooseRelay,
                          itemList: controller.blackOutRelayList,
                          value: controller.blackOutRelay.value,
                          isFilled: Get.isDarkMode ? true : false,
                          onChange: (value) {
                            controller.blackOutRelay.value = value;
                          },
                        isEdit: false.obs,
                        isEnable: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.isDarkMode ? AppColors.darkAppbar : AppColors.lightAppbar,
                    ),
                    child: Column(
                      children: [
                        commonEnableTitleWidget(
                            title: AppStrings.uVScreen,
                            isSelect: controller.isUvScreenEnable,
                          titleColor: AppColors.lightBlue,
                          onTap: (){}
                        ),
                        Padding(
                            padding: EdgeInsets.all(15.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTexField(
                                  title: AppStrings.uVScreenOpen,
                                  controller: controller.uVScreenOpenController,
                                  suffixText: "µmol/s",
                                  hintText: AppStrings.uVScreenOpen,
                                  isFilled: true,
                                  onChanged: (value) {}
                              ),
                              SizedBox(height: 10.h,),
                              commonTexField(
                                  title: AppStrings.uVScreenClose,
                                  controller: controller.uVScreenCloseController,
                                  suffixText: "µmol/s",
                                  hintText: AppStrings.uVScreenClose,
                                  onChanged: (value) {},
                                isFilled: true,
                              ),
                              SizedBox(height: 10.h,),
                              commonTexField(
                                  title: AppStrings.temperatureControl,
                                  controller: controller.temperatureController,
                                  suffixText: "°C",
                                  hintText: AppStrings.temperature,
                                  onChanged: (value) {},
                                isFilled: true,
                              ),
                              SizedBox(height: 10.h,),
                              commonTexField(
                                  title: AppStrings.deadband,
                                  controller: controller.deadBandController,
                                  suffixText: "°C",
                                  hintText: AppStrings.temperatureDeadband,
                                  onChanged: (value) {},
                                isFilled: true,
                              ),
                              SizedBox(height: 10.h,),
                              CustomText(
                                text: AppStrings.switchSelection,
                                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                fontSize: 12.h,
                              ),
                              SizedBox(height: 5.h,),
                              Obx(() => CustomDropDown(
                                width: 310.w,
                                yValue: 50,
                                hintText: AppStrings.chooseSwitch,
                                itemList: controller.isGetData.value == true
                                    ? controller.switchList : [],
                                value: controller.uVScreenSwitch.value,
                                isFilled: true,
                                onChange: (value) {
                                  controller.uVScreenSwitch.value = value;
                                },
                                isEdit: false.obs,
                                isEnable: false,
                              )),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText(
                                text: AppStrings.relaySelection,
                                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                                fontSize: 12.h,
                              ),
                              SizedBox(height: 5.h,),
                              CustomDropDown(
                                  width: 310.w,
                                  hintText: AppStrings.chooseRelay,
                                  itemList: controller.uvScreenRelayList,
                                  value: controller.uvScreenRelay.value,
                                  isFilled: true,
                                  onChange: (value) {
                                    controller.uvScreenRelay.value = value;
                                  },
                                isEdit: false.obs,
                                isEnable: false,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(15.w),
                  child: CustomButton(
                    onTap: () {
                    },
                    buttonText: AppStrings.save,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
