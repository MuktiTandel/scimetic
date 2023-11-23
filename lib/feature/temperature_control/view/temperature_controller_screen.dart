import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_enable_title_widget.dart';
import 'package:scimetic/core/elements/common_imagetext_widget.dart';
import 'package:scimetic/core/elements/custom_button.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/temperature_control/controller/temperature_controller.dart';

class TemperatureControllerScreen extends StatelessWidget {
  TemperatureControllerScreen({Key? key}) : super(key: key);

  final controller = Get.put(TemperatureController());

  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: CustomDropDown(
                width: 330.w,
                hintText: dashboardController.selectItem.value,
                itemList: dashboardController.itemList,
                value: dashboardController.selectItem.value,
                onChange: (value) async {
                  dashboardController.selectItem.value = value;
                  for (var element in dashboardController.mainList) {
                    if (element.identifier!.contains(value)) {
                      controller.storeData.setData(StoreData.id, element.id!);
                      AppConst().debug('select id => ${element.id}');
                    }
                  }
                  controller.storeData.setData(StoreData.identifier, value);
                  AppConst().debug(
                      'select value => ${dashboardController.selectItem.value}');
                  for (var element in dashboardController.dataList) {
                    if (element.identifier!.contains(value)) {
                      controller.id.value = element.id!;
                    }
                  }
                  await controller.getTemperatureControllerData();
                },
                isEdit: false.obs,
                isEnable: false,
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: AppBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color:
                            Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonEnableTitleWidget(
                                title: AppStrings.cooling,
                                isSelect: controller.isCoolingEnable,
                                onTap: () async {
                                  await controller.addTemperatureControlData();
                                }),
                            Divider(
                              thickness: 1.w,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightBorder,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonImageText(
                                      image: AppImages.fillSun,
                                      title: AppStrings.dayCoolingMode,
                                      color: AppColors.lightBlue),
                                  SizedBox(
                                    height: 8.h,
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
                                  Obx(() => CustomDropDown(
                                        width: 330.w,
                                        hintText: AppStrings.chooseSwitch,
                                        itemList:
                                            controller.isGetData.value == true
                                                ? controller.switchList
                                                : [],
                                        value:
                                            controller.dayCoolingSwitch.value,
                                        isFilled: Get.isDarkMode ? true : false,
                                        onChange: (value) {
                                          controller.dayCoolingSwitch.value =
                                              value;
                                        },
                                        isEdit: controller.isEdit,
                                        isEnable:
                                            !controller.isCoolingEnable.value,
                                      )),
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
                                  Obx(
                                    () => CustomDropDown(
                                      width: 330.w,
                                      hintText: AppStrings.chooseRelay,
                                      itemList: controller.dayCoolingRelayList,
                                      value: controller
                                          .dayCoolingRelaySelection.value,
                                      isFilled: Get.isDarkMode ? true : false,
                                      onChange: (value) {
                                        controller.dayCoolingRelaySelection
                                            .value = value;
                                        if (value.contains("Relay 1")) {
                                          controller.dayCoolingRelaySelection
                                              .value = 'Relay_1';
                                        } else if (value.contains("Relay 2")) {
                                          controller.dayCoolingRelaySelection
                                              .value = 'Relay_2';
                                        } else if (value.contains("Relay 3")) {
                                          controller.dayCoolingRelaySelection
                                              .value = 'Relay_3';
                                        } else {
                                          controller.dayCoolingRelaySelection
                                              .value = 'Relay_4';
                                        }
                                      },
                                      isEdit: controller.isEdit,
                                      isEnable:
                                          !controller.isCoolingEnable.value,
                                    ),
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
                                        title: AppStrings.nightCoolingMode,
                                        color: AppColors.lightBlue),
                                    SizedBox(
                                      height: 8.h,
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
                                    Obx(() => CustomDropDown(
                                          width: 320.w,
                                          hintText: AppStrings.chooseSwitch,
                                          itemList:
                                              controller.isGetData.value == true
                                                  ? controller.switchList
                                                  : [],
                                          value: controller
                                              .nightCoolingSwitch.value,
                                          isFilled:
                                              Get.isDarkMode ? true : false,
                                          onChange: (value) {
                                            controller.nightCoolingSwitch
                                                .value = value;
                                          },
                                          isEdit: controller.isEdit,
                                          isEnable:
                                              !controller.isCoolingEnable.value,
                                        )),
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
                                    Obx(() => CustomDropDown(
                                          width: 320.w,
                                          hintText: AppStrings.chooseRelay,
                                          itemList:
                                              controller.nightCoolingRelayList,
                                          value: controller
                                              .nightCoolingRelay.value,
                                          isFilled:
                                              Get.isDarkMode ? true : false,
                                          onChange: (value) {
                                            controller.nightCoolingRelay.value =
                                                value;
                                            if (value.contains("Relay 1")) {
                                              controller.nightCoolingRelay
                                                  .value = 'Relay_1';
                                            } else if (value
                                                .contains("Relay 2")) {
                                              controller.nightCoolingRelay
                                                  .value = 'Relay_2';
                                            } else if (value
                                                .contains("Relay 3")) {
                                              controller.nightCoolingRelay
                                                  .value = 'Relay_3';
                                            } else {
                                              controller.nightCoolingRelay
                                                  .value = 'Relay_4';
                                            }
                                          },
                                          isEdit: controller.isEdit,
                                          isEnable:
                                              !controller.isCoolingEnable.value,
                                        )),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonEnableTitleWidget(
                                title: AppStrings.heating,
                                isSelect: controller.isHeatingEnable,
                                onTap: () async {
                                  await controller.addTemperatureControlData();
                                }),
                            Divider(
                              thickness: 1.w,
                              color: Get.isDarkMode
                                  ? AppColors.darkText
                                  : AppColors.lightBorder,
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonImageText(
                                      image: AppImages.fillSun,
                                      title: AppStrings.dayHeatingMode,
                                      color: AppColors.orange),
                                  SizedBox(
                                    height: 8.h,
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
                                  Obx(() => CustomDropDown(
                                        width: 330.w,
                                        hintText: AppStrings.chooseSwitch,
                                        itemList:
                                            controller.isGetData.value == true
                                                ? controller.switchList
                                                : [],
                                        value:
                                            controller.dayHeatingSwitch.value,
                                        isFilled: Get.isDarkMode ? true : false,
                                        onChange: (value) {
                                          controller.dayHeatingSwitch.value =
                                              value;
                                        },
                                        isEdit: controller.isEdit,
                                        isEnable:
                                            !controller.isHeatingEnable.value,
                                      )),
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
                                  Obx(
                                    () => CustomDropDown(
                                      width: 330.w,
                                      hintText: AppStrings.chooseRelay,
                                      itemList: controller.dayHeatingRelayList,
                                      value: controller.dayHeatingRelay.value,
                                      isFilled: Get.isDarkMode ? true : false,
                                      onChange: (value) {
                                        controller.dayHeatingRelay.value =
                                            value;
                                        if (value.contains("Relay 1")) {
                                          controller.dayHeatingRelay.value =
                                              'Relay_1';
                                        } else if (value.contains("Relay 2")) {
                                          controller.dayHeatingRelay.value =
                                              'Relay_2';
                                        } else if (value.contains("Relay 3")) {
                                          controller.dayHeatingRelay.value =
                                              'Relay_3';
                                        } else {
                                          controller.dayHeatingRelay.value =
                                              'Relay_4';
                                        }
                                      },
                                      isEdit: controller.isEdit,
                                      isEnable:
                                          !controller.isHeatingEnable.value,
                                    ),
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
                                        title: AppStrings.nightHeatingMode,
                                        color: AppColors.orange),
                                    SizedBox(
                                      height: 8.h,
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
                                    Obx(() => CustomDropDown(
                                          width: 320.w,
                                          hintText: AppStrings.chooseSwitch,
                                          itemList:
                                              controller.isGetData.value == true
                                                  ? controller.switchList
                                                  : [],
                                          value: controller
                                              .nightHeatingSwitch.value,
                                          isFilled:
                                              Get.isDarkMode ? true : false,
                                          onChange: (value) {
                                            controller.nightHeatingSwitch
                                                .value = value;
                                          },
                                          isEdit: controller.isEdit,
                                          isEnable:
                                              !controller.isHeatingEnable.value,
                                        )),
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
                                    Obx(() => CustomDropDown(
                                          width: 320.w,
                                          hintText: AppStrings.chooseRelay,
                                          itemList:
                                              controller.nightHeatingRelayList,
                                          value: controller
                                              .nightHeatingRelay.value,
                                          isFilled:
                                              Get.isDarkMode ? true : false,
                                          onChange: (value) {
                                            controller.nightHeatingRelay.value =
                                                value;
                                            if (value.contains("Relay 1")) {
                                              controller.nightHeatingRelay
                                                  .value = 'Relay_1';
                                            } else if (value
                                                .contains("Relay 2")) {
                                              controller.nightHeatingRelay
                                                  .value = 'Relay_2';
                                            } else if (value
                                                .contains("Relay 3")) {
                                              controller.nightHeatingRelay
                                                  .value = 'Relay_3';
                                            } else {
                                              controller.nightHeatingRelay
                                                  .value = 'Relay_4';
                                            }
                                          },
                                          isEdit: controller.isEdit,
                                          isEnable:
                                              !controller.isHeatingEnable.value,
                                        )),
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
                      // Container(
                      //   color:
                      //       Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       commonTitleWidget(
                      //           title: AppStrings.extractorFan,
                      //           isSelect: controller.isExtractorFanOn),
                      //       Divider(
                      //         thickness: 1.w,
                      //         color: Get.isDarkMode
                      //             ? AppColors.darkText
                      //             : AppColors.lightBorder,
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.all(15.w),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             commonImageText(
                      //                 image: AppImages.fillSun,
                      //                 title: AppStrings.dayMode,
                      //                 color: AppColors.lightBlue),
                      //             SizedBox(
                      //               height: 8.h,
                      //             ),
                      //             Obx(
                      //               () => commonTexField(
                      //                   title: AppStrings.temperature,
                      //                   controller:
                      //                       controller.extractorDayTemperature,
                      //                   suffixText: "°C",
                      //                   hintText: AppStrings.temperature,
                      //                   onChanged: (value) {},
                      //                   isReadOnly:
                      //                       !controller.isExtractorFanOn.value),
                      //             ),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             CustomText(
                      //               text: AppStrings.switchSelection,
                      //               color: Get.isDarkMode
                      //                   ? AppColors.darkText
                      //                   : AppColors.lightText,
                      //               fontSize: 12.h,
                      //             ),
                      //             SizedBox(
                      //               height: 5.h,
                      //             ),
                      //             Obx(() => CustomDropDown(
                      //                   width: 330.w,
                      //                   hintText: AppStrings.chooseSwitch,
                      //                   itemList:
                      //                       controller.isGetData.value == true
                      //                           ? controller.switchList
                      //                           : [],
                      //                   value: controller
                      //                       .extractorFanDaySwitch.value,
                      //                   isFilled: Get.isDarkMode ? true : false,
                      //                   onChange: (value) {
                      //                     controller.extractorFanDaySwitch
                      //                         .value = value;
                      //                   },
                      //                   isEdit: controller.isEdit.value == false
                      //                       ? false.obs
                      //                       : true.obs,
                      //                   isEnable:
                      //                       !controller.isExtractorFanOn.value,
                      //                 )),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             CustomText(
                      //               text: AppStrings.relaySelection,
                      //               color: Get.isDarkMode
                      //                   ? AppColors.darkText
                      //                   : AppColors.lightText,
                      //               fontSize: 12.h,
                      //             ),
                      //             SizedBox(
                      //               height: 5.h,
                      //             ),
                      //             Obx(() => CustomDropDown(
                      //                   width: 330.w,
                      //                   hintText: AppStrings.chooseRelay,
                      //                   itemList:
                      //                       controller.dayExtractorRelayList,
                      //                   value: controller
                      //                       .extractorFanDayRelay.value,
                      //                   isFilled: Get.isDarkMode ? true : false,
                      //                   onChange: (value) {
                      //                     controller.extractorFanDayRelay
                      //                         .value = value;
                      //                     if (value.contains("Relay 1")) {
                      //                       controller.extractorFanDayRelay
                      //                           .value = 'Relay_1';
                      //                     } else if (value
                      //                         .contains("Relay 2")) {
                      //                       controller.extractorFanDayRelay
                      //                           .value = 'Relay_2';
                      //                     } else if (value
                      //                         .contains("Relay 3")) {
                      //                       controller.extractorFanDayRelay
                      //                           .value = 'Relay_3';
                      //                     } else {
                      //                       controller.extractorFanDayRelay
                      //                           .value = 'Relay_4';
                      //                     }
                      //                   },
                      //                   isEdit: controller.isEdit,
                      //                   isEnable:
                      //                       !controller.isExtractorFanOn.value,
                      //                 )),
                      //           ],
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.all(10.w),
                      //         child: Container(
                      //           padding: EdgeInsets.all(10.w),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(8),
                      //             color: Get.isDarkMode
                      //                 ? AppColors.darkAppbar
                      //                 : AppColors.lightAppbar,
                      //           ),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               commonImageText(
                      //                   image: AppImages.fillMoon,
                      //                   title: AppStrings.nightMode,
                      //                   color: AppColors.lightBlue),
                      //               SizedBox(
                      //                 height: 8.h,
                      //               ),
                      //               Obx(
                      //                 () => commonTexField(
                      //                     title: AppStrings.temperature,
                      //                     controller: controller
                      //                         .extractorNightTemperature,
                      //                     suffixText: "°C",
                      //                     hintText: AppStrings.temperature,
                      //                     onChanged: (value) {},
                      //                     isReadOnly: !controller
                      //                         .isExtractorFanOn.value),
                      //               ),
                      //               SizedBox(
                      //                 height: 10.h,
                      //               ),
                      //               CustomText(
                      //                 text: AppStrings.switchSelection,
                      //                 color: Get.isDarkMode
                      //                     ? AppColors.darkText
                      //                     : AppColors.lightText,
                      //                 fontSize: 12.h,
                      //               ),
                      //               SizedBox(
                      //                 height: 5.h,
                      //               ),
                      //               Obx(
                      //                 () => CustomDropDown(
                      //                   width: 320.w,
                      //                   hintText: AppStrings.chooseSwitch,
                      //                   itemList:
                      //                       controller.isGetData.value == true
                      //                           ? controller.switchList
                      //                           : [],
                      //                   value: controller
                      //                       .extractorFanNightSwitch.value,
                      //                   isFilled: Get.isDarkMode ? true : false,
                      //                   onChange: (value) {
                      //                     controller.extractorFanNightSwitch
                      //                         .value = value;
                      //                   },
                      //                   isEdit: controller.isEdit.value == false
                      //                       ? false.obs
                      //                       : true.obs,
                      //                   isEnable:
                      //                       !controller.isExtractorFanOn.value,
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 10.h,
                      //               ),
                      //               CustomText(
                      //                 text: AppStrings.relaySelection,
                      //                 color: Get.isDarkMode
                      //                     ? AppColors.darkText
                      //                     : AppColors.lightText,
                      //                 fontSize: 12.h,
                      //               ),
                      //               SizedBox(
                      //                 height: 5.h,
                      //               ),
                      //               Obx(() => CustomDropDown(
                      //                     width: 320.w,
                      //                     hintText: AppStrings.chooseRelay,
                      //                     itemList: controller
                      //                         .nightExtractorRelayList,
                      //                     value: controller
                      //                         .extractorFanNightRelay.value,
                      //                     isFilled:
                      //                         Get.isDarkMode ? true : false,
                      //                     onChange: (value) {
                      //                       controller.extractorFanNightRelay
                      //                           .value = value;
                      //                       if (value.contains("Relay 1")) {
                      //                         controller.extractorFanNightRelay
                      //                             .value = 'Relay_1';
                      //                       } else if (value
                      //                           .contains("Relay 2")) {
                      //                         controller.extractorFanNightRelay
                      //                             .value = 'Relay_2';
                      //                       } else if (value
                      //                           .contains("Relay 3")) {
                      //                         controller.extractorFanNightRelay
                      //                             .value = 'Relay_3';
                      //                       } else {
                      //                         controller.extractorFanNightRelay
                      //                             .value = 'Relay_4';
                      //                       }
                      //                     },
                      //                     isEdit: controller.isEdit,
                      //                     isEnable: !controller
                      //                         .isExtractorFanOn.value,
                      //                   )),
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // Container(
                      //   color:
                      //       Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       commonTitleWidget(
                      //           title: AppStrings.wetWall,
                      //           isSelect: controller.isWetWallOn),
                      //       Divider(
                      //         thickness: 1.w,
                      //         color: Get.isDarkMode
                      //             ? AppColors.darkText
                      //             : AppColors.lightBorder,
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.all(15.w),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             commonImageText(
                      //                 image: AppImages.fillSun,
                      //                 title: AppStrings.dayMode,
                      //                 color: AppColors.lightBlue),
                      //             SizedBox(
                      //               height: 8.h,
                      //             ),
                      //             Obx(() => commonTexField(
                      //                 title: AppStrings.temperature,
                      //                 controller:
                      //                     controller.wetWallDayTemperature,
                      //                 suffixText: "°C",
                      //                 hintText: AppStrings.temperature,
                      //                 onChanged: (value) {},
                      //                 isReadOnly:
                      //                     controller.isWetWallOn.value)),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             CustomText(
                      //               text: AppStrings.switchSelection,
                      //               color: Get.isDarkMode
                      //                   ? AppColors.darkText
                      //                   : AppColors.lightText,
                      //               fontSize: 12.h,
                      //             ),
                      //             SizedBox(
                      //               height: 5.h,
                      //             ),
                      //             Obx(() => CustomDropDown(
                      //                   width: 330.w,
                      //                   hintText: AppStrings.chooseSwitch,
                      //                   itemList:
                      //                       controller.isGetData.value == true
                      //                           ? controller.switchList
                      //                           : [],
                      //                   value:
                      //                       controller.wetWallDaySwitch.value,
                      //                   isFilled: Get.isDarkMode ? true : false,
                      //                   onChange: (value) {
                      //                     controller.wetWallDaySwitch.value =
                      //                         value;
                      //                   },
                      //                   isEdit: controller.isEdit,
                      //                   isEnable: !controller.isWetWallOn.value,
                      //                 )),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             CustomText(
                      //               text: AppStrings.relaySelection,
                      //               color: Get.isDarkMode
                      //                   ? AppColors.darkText
                      //                   : AppColors.lightText,
                      //               fontSize: 12.h,
                      //             ),
                      //             SizedBox(
                      //               height: 5.h,
                      //             ),
                      //             Obx(() => CustomDropDown(
                      //                   width: 330.w,
                      //                   hintText: AppStrings.chooseRelay,
                      //                   itemList:
                      //                       controller.dayWetWallRelayList,
                      //                   value: controller.wetWalDayRelay.value,
                      //                   isFilled: Get.isDarkMode ? true : false,
                      //                   onChange: (value) {
                      //                     controller.wetWalDayRelay.value =
                      //                         value;
                      //                     if (value.contains("Relay 1")) {
                      //                       controller.wetWalDayRelay.value =
                      //                           'Relay_1';
                      //                     } else if (value
                      //                         .contains("Relay 2")) {
                      //                       controller.wetWalDayRelay.value =
                      //                           'Relay_2';
                      //                     } else if (value
                      //                         .contains("Relay 3")) {
                      //                       controller.wetWalDayRelay.value =
                      //                           'Relay_3';
                      //                     } else {
                      //                       controller.wetWalDayRelay.value =
                      //                           'Relay_4';
                      //                     }
                      //                   },
                      //                   isEdit: controller.isEdit,
                      //                   isEnable: !controller.isWetWallOn.value,
                      //                 )),
                      //           ],
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.all(10.w),
                      //         child: Container(
                      //           padding: EdgeInsets.all(10.w),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(8),
                      //             color: Get.isDarkMode
                      //                 ? AppColors.darkAppbar
                      //                 : AppColors.lightAppbar,
                      //           ),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               commonImageText(
                      //                   image: AppImages.fillMoon,
                      //                   title: AppStrings.nightMode,
                      //                   color: AppColors.lightBlue),
                      //               SizedBox(
                      //                 height: 8.h,
                      //               ),
                      //               Obx(
                      //                 () => commonTexField(
                      //                     title: AppStrings.temperature,
                      //                     controller: controller
                      //                         .wetWallNightTemperature,
                      //                     suffixText: "°C",
                      //                     hintText: AppStrings.temperature,
                      //                     onChanged: (value) {},
                      //                     isReadOnly:
                      //                         controller.isWetWallOn.value),
                      //               ),
                      //               SizedBox(
                      //                 height: 10.h,
                      //               ),
                      //               CustomText(
                      //                 text: AppStrings.switchSelection,
                      //                 color: Get.isDarkMode
                      //                     ? AppColors.darkText
                      //                     : AppColors.lightText,
                      //                 fontSize: 12.h,
                      //               ),
                      //               SizedBox(
                      //                 height: 5.h,
                      //               ),
                      //               Obx(() => CustomDropDown(
                      //                     width: 320.w,
                      //                     hintText: AppStrings.chooseSwitch,
                      //                     itemList:
                      //                         controller.isGetData.value == true
                      //                             ? controller.switchList
                      //                             : [],
                      //                     value: controller
                      //                         .wetWallNightSwitch.value,
                      //                     isFilled:
                      //                         Get.isDarkMode ? true : false,
                      //                     onChange: (value) {
                      //                       controller.wetWallNightSwitch
                      //                           .value = value;
                      //                     },
                      //                     isEdit: controller.isEdit,
                      //                     isEnable:
                      //                         !controller.isWetWallOn.value,
                      //                   )),
                      //               SizedBox(
                      //                 height: 10.h,
                      //               ),
                      //               CustomText(
                      //                 text: AppStrings.relaySelection,
                      //                 color: Get.isDarkMode
                      //                     ? AppColors.darkText
                      //                     : AppColors.lightText,
                      //                 fontSize: 12.h,
                      //               ),
                      //               SizedBox(
                      //                 height: 5.h,
                      //               ),
                      //               Obx(
                      //                 () => CustomDropDown(
                      //                     width: 320.w,
                      //                     hintText: AppStrings.chooseRelay,
                      //                     itemList:
                      //                         controller.nightWetWallRelayList,
                      //                     value:
                      //                         controller.wetWalNightRelay.value,
                      //                     isFilled:
                      //                         Get.isDarkMode ? true : false,
                      //                     isEdit: controller.isEdit,
                      //                     isEnable:
                      //                         !controller.isWetWallOn.value,
                      //                     onChange: (value) {
                      //                       controller.wetWalNightRelay.value =
                      //                           value;
                      //                       if (value.contains("Relay 1")) {
                      //                         controller.wetWalNightRelay
                      //                             .value = 'Relay_1';
                      //                       } else if (value
                      //                           .contains("Relay 2")) {
                      //                         controller.wetWalNightRelay
                      //                             .value = 'Relay_2';
                      //                       } else if (value
                      //                           .contains("Relay 3")) {
                      //                         controller.wetWalNightRelay
                      //                             .value = 'Relay_3';
                      //                       } else {
                      //                         controller.wetWalNightRelay
                      //                             .value = 'Relay_4';
                      //                       }
                      //                     }),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: CustomButton(
                          onTap: () async {
                            await controller.addTemperatureControlData();
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
            ),
          ],
        ));
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
          Expanded(
              child: SizedBox(
            width: 10.w,
          )),
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
              onTap: () async {
                isSelect.value = !isSelect.value;
                await controller.addTemperatureControlData();
              },
              child: Image.asset(
                isSelect.value == false
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
              text: isSelect.value ? AppStrings.off : AppStrings.on,
              fontSize: 14.sp,
              color: isSelect.value
                  ? AppColors.lightText
                  : Get.isDarkMode
                      ? AppColors.darkText
                      : AppColors.subTitleColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
