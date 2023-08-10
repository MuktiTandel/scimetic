import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_graph_widget.dart';
import 'package:scimetic/core/elements/custom_dropdown.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';
import 'package:scimetic/feature/overview/element/device_overview_widget.dart';
import 'package:scimetic/feature/overview/element/growsheet_widget.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final controller = Get.put(OverviewController());

  final homeController = Get.put(HomeController());

  final dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    homeController.isDashboard.value = false;
    controller.isOverview.value = true;
    // Timer.periodic(const Duration(minutes: 1), (timer) {
    //   if (controller.isGraphScreen.value = true) {
    //     if (controller.is1Hour.value == true) {
    //       controller.get1HourData(
    //           id: controller.id.value,
    //           identifier: dashboardController.selectItem.value);
    //     } else if (controller.isWeek.value == true) {
    //       controller.getWeekData(
    //           id: controller.id.value,
    //           identifier: dashboardController.selectItem.value);
    //     } else if (controller.isMonth.value == true) {
    //       controller.getMonthData(
    //         id: controller.id.value,
    //         identifier: dashboardController.selectItem.value,
    //       );
    //     } else if (controller.is6Hour.value == true) {
    //       controller.get6HourData(
    //           id: controller.id.value,
    //           identifier: dashboardController.selectItem.value);
    //     } else if (controller.is12Hour.value == true) {
    //       controller.get12HourData(
    //           id: controller.id.value,
    //           identifier: dashboardController.selectItem.value);
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    controller.isGraphScreen.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          child: CustomDropDown(
            width: 330.w,
            hintText: dashboardController.selectItem.value,
            itemList: dashboardController.itemList,
            value: dashboardController.selectItem.value,
            onChange: (value) {
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
              if (controller.is24Hour.value == true) {
                controller.get24HourData(
                    id: controller.id.value,
                    identifier: dashboardController.selectItem.value);
              } else if (controller.isWeek.value == true) {
                controller.getWeekData(
                    id: controller.id.value,
                    identifier: dashboardController.selectItem.value);
              } else if (controller.isMonth.value == true) {
                controller.getMonthData(
                    id: controller.id.value,
                    identifier: dashboardController.selectItem.value);
              }
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
                    Obx(() => controller.isGetData.value == false
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.buttonColor,
                            ),
                          )
                        : Column(
                            children: [
                              Obx(() => commonGraphWidget(
                                  context: context,
                                  title: AppStrings.temperature,
                                  image: AppImages.menu_,
                                  value: controller.temperatureValue.value
                                      .toStringAsFixed(2)
                                      .toString(),
                                  value1: "°C",
                                  is1Hour: controller.is1Hour.value,
                                  is6Hour: controller.is6Hour.value,
                                  is12Hour: controller.is12Hour.value,
                                  is24Hour: controller.is24Hour.value,
                                  isWeek: controller.isWeek.value,
                                  isMonth: controller.isMonth.value,
                                  hour1Select: () {
                                    controller.get1HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is1Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = true;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour6Select: () {
                                    controller.get6HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is6Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = true;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour12Select: () {
                                    controller.get12HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is12Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = true;
                                    }
                                  },
                                  hour24Select: () {
                                    controller.get24HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is24Hour.value == false) {
                                      controller.is24Hour.value = true;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  weekSelect: () {
                                    controller.getWeekData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isWeek.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = true;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  monthSelect: () {
                                    controller.getMonthData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isMonth.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = true;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  graph: Obx(() =>
                                      controller.isClimateData.value == true
                                          ? HourGraph(
                                              minY: controller
                                                  .minTemperatureY.value,
                                              maxY: controller
                                                  .maxTemperatureY.value,
                                              dataList: controller
                                                  .temperatureDataList,
                                              graphColor: AppColors.orange,
                                              format: "°C",
                                            )
                                          : SizedBox(
                                              height: 150.h,
                                            )),
                                  color: AppColors.orange,
                                  onTap: () {
                                    controller.isTemperature.value = true;
                                    Get.toNamed(AppPages.GRAPH);
                                  },
                                  isPhase: false)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => commonGraphWidget(
                                  context: context,
                                  title: AppStrings.humidity,
                                  image: AppImages.fillSettings,
                                  value: controller.humidityValue.value
                                      .toStringAsFixed(2)
                                      .toString(),
                                  value1: "%",
                                  is1Hour: controller.is1Hour.value,
                                  is6Hour: controller.is6Hour.value,
                                  is12Hour: controller.is12Hour.value,
                                  is24Hour: controller.is24Hour.value,
                                  isWeek: controller.isWeek.value,
                                  isMonth: controller.isMonth.value,
                                  graph: Obx(() => controller
                                              .isClimateData.value ==
                                          true
                                      ? HourGraph(
                                          minY: controller.minHumidityY.value,
                                          maxY: controller.maxHumidityY.value,
                                          graphColor: AppColors.lightBlue,
                                          dataList: controller.humidityDataList,
                                          format: "kW",
                                        )
                                      : SizedBox(
                                          height: 150.h,
                                        )),
                                  hour1Select: () {
                                    controller.get1HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is1Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = true;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour6Select: () {
                                    controller.get6HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is6Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = true;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour12Select: () {
                                    controller.get12HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is12Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = true;
                                    }
                                  },
                                  hour24Select: () {
                                    if (controller.is24Hour.value == false) {
                                      controller.get24HourData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      controller.is24Hour.value = true;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  weekSelect: () {
                                    controller.getWeekData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isWeek.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = true;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  monthSelect: () {
                                    controller.getMonthData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isMonth.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = true;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  color: AppColors.lightBlue,
                                  onTap: () {
                                    controller.isElectricalLoad.value = true;
                                    Get.toNamed(AppPages.GRAPH);
                                  },
                                  isPhase: false)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => commonGraphWidget(
                                  context: context,
                                  title: AppStrings.cO2,
                                  image: AppImages.horizontalMenu,
                                  value: controller.co2Value.value.toString(),
                                  value1: AppStrings.ppm,
                                  is1Hour: controller.is1Hour.value,
                                  is6Hour: controller.is6Hour.value,
                                  is12Hour: controller.is12Hour.value,
                                  is24Hour: controller.is24Hour.value,
                                  isWeek: controller.isWeek.value,
                                  isMonth: controller.isMonth.value,
                                  graph: Obx(() =>
                                      controller.isClimateData.value == true
                                          ? HourGraph(
                                              minY: controller.minCo2Y.value,
                                              maxY: controller.maxCo2Y.value,
                                              graphColor: AppColors.lightGreen1,
                                              dataList: controller.co2DataList,
                                              format: " ppm",
                                            )
                                          : SizedBox(
                                              height: 150.h,
                                            )),
                                  hour1Select: () {
                                    controller.get1HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is1Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = true;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour6Select: () {
                                    controller.get6HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is6Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = true;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour12Select: () {
                                    controller.get12HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is12Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = true;
                                    }
                                  },
                                  hour24Select: () {
                                    controller.get24HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is24Hour.value == false) {
                                      controller.is24Hour.value = true;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  weekSelect: () {
                                    controller.getWeekData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isWeek.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = true;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  monthSelect: () {
                                    controller.getMonthData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isMonth.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = true;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  color: AppColors.lightGreen1,
                                  onTap: () {
                                    controller.isCo2.value = true;
                                    Get.toNamed(AppPages.GRAPH);
                                  },
                                  isPhase: false)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(
                                () => commonGraphWidget(
                                    context: context,
                                    title: AppStrings.lightMode,
                                    image: AppImages.menu_,
                                    value: controller.lightningValue.value
                                        .toString(),
                                    value1: AppStrings.molM2day,
                                    is1Hour: controller.is1Hour.value,
                                    is6Hour: controller.is6Hour.value,
                                    is12Hour: controller.is12Hour.value,
                                    is24Hour: controller.is24Hour.value,
                                    isWeek: controller.isWeek.value,
                                    isMonth: controller.isMonth.value,
                                    graph: Obx(() => controller
                                                .isClimateData.value ==
                                            true
                                        ? HourGraph(
                                            minY: controller.minLightY.value,
                                            maxY: controller.maxLightY.value,
                                            dataList: controller.vpdDataList,
                                            graphColor: AppColors.pink,
                                            format: " mol/m2day",
                                          )
                                        : SizedBox(
                                            height: 150.h,
                                          )),
                                    hour1Select: () {
                                      controller.get1HourData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      if (controller.is1Hour.value == false) {
                                        controller.is24Hour.value = false;
                                        controller.isWeek.value = false;
                                        controller.isMonth.value = false;
                                        controller.is1Hour.value = true;
                                        controller.is6Hour.value = false;
                                        controller.is12Hour.value = false;
                                      }
                                    },
                                    hour6Select: () {
                                      controller.get6HourData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      if (controller.is6Hour.value == false) {
                                        controller.is24Hour.value = false;
                                        controller.isWeek.value = false;
                                        controller.isMonth.value = false;
                                        controller.is1Hour.value = false;
                                        controller.is6Hour.value = true;
                                        controller.is12Hour.value = false;
                                      }
                                    },
                                    hour12Select: () {
                                      controller.get12HourData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      if (controller.is12Hour.value == false) {
                                        controller.is24Hour.value = false;
                                        controller.isWeek.value = false;
                                        controller.isMonth.value = false;
                                        controller.is1Hour.value = false;
                                        controller.is6Hour.value = false;
                                        controller.is12Hour.value = true;
                                      }
                                    },
                                    hour24Select: () {
                                      if (controller.is24Hour.value == false) {
                                        controller.get24HourData(
                                            id: controller.id.value,
                                            identifier: dashboardController
                                                .selectItem.value);
                                        controller.is24Hour.value = true;
                                        controller.isWeek.value = false;
                                        controller.isMonth.value = false;
                                        controller.is1Hour.value = false;
                                        controller.is6Hour.value = false;
                                        controller.is12Hour.value = false;
                                      }
                                    },
                                    weekSelect: () {
                                      controller.getWeekData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      if (controller.isWeek.value == false) {
                                        controller.is24Hour.value = false;
                                        controller.isWeek.value = true;
                                        controller.isMonth.value = false;
                                        controller.is1Hour.value = false;
                                        controller.is6Hour.value = false;
                                        controller.is12Hour.value = false;
                                      }
                                    },
                                    monthSelect: () {
                                      controller.getMonthData(
                                          id: controller.id.value,
                                          identifier: dashboardController
                                              .selectItem.value);
                                      if (controller.isMonth.value == false) {
                                        controller.is24Hour.value = false;
                                        controller.isWeek.value = false;
                                        controller.isMonth.value = true;
                                        controller.is1Hour.value = false;
                                        controller.is6Hour.value = false;
                                        controller.is12Hour.value = false;
                                      }
                                    },
                                    color: AppColors.pink,
                                    onTap: () {
                                      controller.isLightning.value = true;
                                      Get.toNamed(AppPages.GRAPH);
                                    },
                                    isPhase: false),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(() => commonGraphWidget(
                                  context: context,
                                  title: AppStrings.vpd,
                                  image: AppImages.horizontalMenu,
                                  value: controller.vpdValue.value.toString(),
                                  value1: AppStrings.kPa,
                                  is1Hour: controller.is1Hour.value,
                                  is6Hour: controller.is6Hour.value,
                                  is12Hour: controller.is12Hour.value,
                                  is24Hour: controller.is24Hour.value,
                                  isWeek: controller.isWeek.value,
                                  isMonth: controller.isMonth.value,
                                  graph: Obx(() =>
                                      controller.isClimateData.value == true
                                          ? HourGraph(
                                              minY: controller.minVpdY.value,
                                              maxY: controller.maxVpdY.value,
                                              graphColor: AppColors.lightBlue2,
                                              dataList: controller.vpdDataList,
                                              format: " kPa",
                                            )
                                          : SizedBox(
                                              height: 150.h,
                                            )),
                                  hour1Select: () {
                                    controller.get1HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is1Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = true;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour6Select: () {
                                    controller.get6HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is6Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = true;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  hour12Select: () {
                                    controller.get12HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is12Hour.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = true;
                                    }
                                  },
                                  hour24Select: () {
                                    controller.get24HourData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.is24Hour.value == false) {
                                      controller.is24Hour.value = true;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  weekSelect: () {
                                    controller.getWeekData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isWeek.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = true;
                                      controller.isMonth.value = false;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  monthSelect: () {
                                    controller.getMonthData(
                                        id: controller.id.value,
                                        identifier: dashboardController
                                            .selectItem.value);
                                    if (controller.isMonth.value == false) {
                                      controller.is24Hour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = true;
                                      controller.is1Hour.value = false;
                                      controller.is6Hour.value = false;
                                      controller.is12Hour.value = false;
                                    }
                                  },
                                  color: AppColors.lightBlue2,
                                  onTap: () {
                                    controller.isVdp.value = true;
                                    Get.toNamed(AppPages.GRAPH);
                                  },
                                  isPhase: false)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: Get.width,
                                color: Get.isDarkMode
                                    ? AppColors.darkTheme
                                    : Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: AppStrings.irrigationOverview,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            width: 10.w,
                                          )),
                                          Image.asset(
                                            AppImages.horizontalMenu,
                                            height: 20.h,
                                            width: 20.w,
                                            color: Get.isDarkMode
                                                ? AppColors.darkText
                                                : AppColors.lightText,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.2.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText.withOpacity(0.5)
                                          : AppColors.lightAppbar,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 40.h,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  text: "12",
                                                  fontSize: 35.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.buttonColor,
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                CustomText(
                                                  text: AppStrings.feedsFrom15,
                                                  fontSize: 17.sp,
                                                  color: AppColors.buttonColor,
                                                  fontWeight: FontWeight.w400,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                text: AppStrings.nextFeedAt,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Get.isDarkMode
                                                    ? AppColors.darkText
                                                    : AppColors.lightGray1,
                                              ),
                                              CustomText(
                                                text: "14:35",
                                                fontSize: 15.sp,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.formulaName,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.formulaNameField,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.buttonColor,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.seedling,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                color: Get.isDarkMode
                                    ? AppColors.darkTheme
                                    : Colors.white,
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Row(
                                        children: [
                                          CustomText(
                                            text: AppStrings.growsheet,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            width: 10.w,
                                          )),
                                          Image.asset(
                                            AppImages.horizontalMenu,
                                            height: 20.h,
                                            width: 20.w,
                                            color: Get.isDarkMode
                                                ? AppColors.darkText
                                                : AppColors.lightText,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.2.w,
                                      color: Get.isDarkMode
                                          ? AppColors.darkText.withOpacity(0.5)
                                          : AppColors.lightAppbar,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: AppStrings.growsheetName,
                                            fontSize: 20.sp,
                                            color: AppColors.buttonColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CustomText(
                                            text: AppStrings.seedling,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Get.isDarkMode
                                                    ? AppColors.darkBlue
                                                    : AppColors.lightAppbar,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.w),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        text: AppStrings
                                                            .temperature,
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? AppColors.darkIcon
                                                            : AppColors
                                                                .lightGray1,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Expanded(
                                                          child: SizedBox(
                                                        width: 10.w,
                                                      )),
                                                      CustomText(
                                                        text: controller
                                                                .growSheetData
                                                                .growsheets!
                                                                .isNotEmpty
                                                            ? "${controller.growSheetData.growsheets!.first.dayTargetTemperature}°C "
                                                                "/ ${controller.growSheetData.growsheets!.first.nightTargetTemperature}°C"
                                                            : "-",
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            AppStrings.humidity,
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? AppColors.darkIcon
                                                            : AppColors
                                                                .lightGray1,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Expanded(
                                                          child: SizedBox(
                                                        width: 10.w,
                                                      )),
                                                      CustomText(
                                                        text: controller
                                                                .growSheetData
                                                                .growsheets!
                                                                .isNotEmpty
                                                            ? "${controller.growSheetData.growsheets!.first.dayTargetRelativeHumidity}% "
                                                                "/ ${controller.growSheetData.growsheets!.first.nightTargetRelativeHumidity}%"
                                                            : "-",
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        text: AppStrings.cO2,
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? AppColors.darkIcon
                                                            : AppColors
                                                                .lightGray1,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Expanded(
                                                          child: SizedBox(
                                                        width: 10.w,
                                                      )),
                                                      CustomText(
                                                        text: controller
                                                                .growSheetData
                                                                .growsheets!
                                                                .isNotEmpty
                                                            ? "${controller.growSheetData.growsheets!.first.dayTargetCo2}ppm / "
                                                                "${controller.growSheetData.growsheets!.first.nightTargetCo2}ppm"
                                                            : "-",
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        text: AppStrings
                                                            .lightning,
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? AppColors.darkIcon
                                                            : AppColors
                                                                .lightGray1,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Expanded(
                                                          child: SizedBox(
                                                        width: 10.w,
                                                      )),
                                                      CustomText(
                                                        text: "18 / 6",
                                                        fontSize: 15.sp,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              growSheetWidget(
                                  selectStage: controller.selectStage,
                                  isVegetative: controller.isVegetative,
                                  isSeedling: controller.isSeedling,
                                  isGermination: controller.isGermination,
                                  isFlowering: controller.isFlowering,
                                  context: context,
                                  harvestDate: controller.harvestDate,
                                  plantedDate: controller.plantedDate,
                                  plantedDateValue: controller.plantedDateValue,
                                  harvestDateValue: controller.harvestDateValue,
                                  controller: controller.barcodeController,
                                  plantController: controller.plantController,
                                  genealogyController:
                                      controller.genealogyController,
                                  rangeValue1: controller.rangeValue1,
                                  rangeValue2: controller.rangeValue2,
                                  rangeValue3: controller.rangeValue3,
                                  rangeValue4: controller.rangeValue4,
                                  progressValue: controller.progressValue,
                                  onTap: () {
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      controller.addGrowSheetLabeler();
                                    });
                                  },
                                  plantedTap: () {
                                    if (controller.harvestDate.selectedDate!
                                        .toString()
                                        .isNotEmpty) {
                                      controller.progressValue.value = 0;

                                      controller.totalPeriod.value = controller
                                              .harvestDate.selectedDate!
                                              .difference(controller
                                                  .plantedDate.selectedDate!)
                                              .inDays +
                                          1;

                                      controller.currentDay.value =
                                          DateTime.now()
                                                  .difference(controller
                                                      .plantedDate
                                                      .selectedDate!)
                                                  .inDays +
                                              1;

                                      final data = controller.graphData();

                                      final num totalSpent = data.values
                                          .reduce((prev, curr) => prev + curr);
                                      controller.progressValue.value =
                                          ((totalSpent /
                                                      controller
                                                          .totalPeriod.value) *
                                                  100)
                                              .ceil()
                                              .clamp(0, 100);

                                      AppConst().debug(
                                          "progress value => ${controller.progressValue.value}");

                                      controller.resolveAngles(
                                          data, controller.totalPeriod.value);
                                    }
                                  },
                                  harvestTap: () async {
                                    if (controller.plantedDate.selectedDate!
                                        .toString()
                                        .isNotEmpty) {
                                      controller.progressValue.value = 0;

                                      controller.totalPeriod.value = controller
                                              .harvestDate.selectedDate!
                                              .difference(controller
                                                  .plantedDate.selectedDate!)
                                              .inDays +
                                          1;

                                      controller.currentDay.value =
                                          DateTime.now()
                                                  .difference(controller
                                                      .plantedDate
                                                      .selectedDate!)
                                                  .inDays +
                                              1;

                                      final data = controller.graphData();

                                      final num totalSpent = data.values
                                          .reduce((prev, curr) => prev + curr);
                                      controller.progressValue.value =
                                          ((totalSpent /
                                                      controller
                                                          .totalPeriod.value) *
                                                  100)
                                              .ceil()
                                              .clamp(0, 100);

                                      AppConst().debug(
                                          "progress value => ${controller.progressValue.value}");

                                      controller.resolveAngles(
                                          data, controller.totalPeriod.value);
                                    }
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Obx(
                                () => deviceOverviewWidget(
                                    onTap: () {
                                      dashboardController.isOverView.value =
                                          false;
                                      homeController.isDeviceSetup.value = true;
                                      homeController.isSetting.value = true;
                                      homeController.changeModuleIndex(5);
                                    },
                                    switchesOnline: controller.isGetDevice.value == true
                                        ? controller.deviceModel.devices!
                                            .devicesSwitch!.online
                                            .toString()
                                        : "0",
                                    switchesOffline:
                                        controller.isGetDevice.value == true
                                            ? controller.deviceModel.devices!
                                                .devicesSwitch!.offline
                                                .toString()
                                            : "0",
                                    sensorOnline: controller.isGetDevice.value == true
                                        ? controller.deviceModel.devices!.sensor!.online
                                            .toString()
                                        : "0",
                                    sensorOffline: controller.isGetDevice.value == true
                                        ? controller.deviceModel.devices!
                                            .sensor!.offline
                                            .toString()
                                        : "0",
                                    valvesOnline: controller.isGetDevice.value == true
                                        ? controller.deviceModel.devices!.valve!.online
                                            .toString()
                                        : "0",
                                    valvesOffline: controller.isGetDevice.value == true
                                        ? controller.deviceModel.devices!.valve!.offline.toString()
                                        : "0"),
                              ),
                              SizedBox(
                                height: 20.h,
                              )
                            ],
                          ))
                  ],
                ),
              )),
        )
      ],
    );
  }
}
