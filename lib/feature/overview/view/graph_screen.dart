import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_appbar.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/overview/controller/graph_controller.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:scimetic/feature/overview/element/device_overview_widget.dart';
import 'package:scimetic/feature/overview/element/growsheet_widget.dart';
import 'package:scimetic/feature/overview/element/grpah_widget.dart';

class GraphScreen extends StatelessWidget {
   GraphScreen({Key? key}) : super(key: key);

   final controller = Get.put(GraphController());

   final overviewController = Get.put(OverviewController());

   final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 45.h),
        child: CommonAppbar(
          drawerTap: (){
            Get.back();
            if ( overviewController.is1Hour.value == true ) {
              overviewController.get1HourData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            } else if ( overviewController.is6Hour.value == true ) {
              overviewController.get6HourData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            } else if ( overviewController.is12Hour.value == true ) {
              overviewController.get12HourData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            } else if ( overviewController.is24Hour.value == true ) {
              overviewController.get24HourData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            } else if ( overviewController.isWeek.value == true ) {
              overviewController.getWeekData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            } else {
              overviewController.getMonthData(
                  id: overviewController.id.value,
                  identifier: dashboardController
                      .selectItem.value);
            }
           Future.delayed(const Duration(seconds: 1), (){
             if ( overviewController.isTemperature.value == true ) {
               overviewController.isTemperature.value = false;
             } else if ( overviewController.isElectricalLoad.value == true ) {
               overviewController.isElectricalLoad.value = false;
             } else if ( overviewController.isCo2.value == true ) {
               overviewController.isCo2.value = false;
             } else if ( overviewController.isLightning.value == true ) {
               overviewController.isLightning.value = false;
             } else if ( overviewController.isVdp.value == true ) {
               overviewController.isVdp.value = false;
             }
           });
          },
          title: AppStrings.overview,
          notificationTap: (){
            Get.toNamed(AppPages.NOTIFICATION);
          },
          profileTap: (){},
          leadingIcon: AppImages.backArrow,
          isPersonal: false.obs,
          isCrop: false.obs,
        ),
      ),
      body: Obx(() => overviewController.isGetData.value == false ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.buttonColor,
        ),
      ) : ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Obx(() => graphWidget(
                  title: controller.title(),
                  image: controller.image(),
                  value: controller.value(),
                  color: controller.color(),
                  value1: controller.value_(),
                  is24Hour: overviewController.is24Hour.value,
                  hour24Select: (){
                    overviewController.get24HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.is24Hour.value == false) {
                      overviewController.is24Hour.value = true;
                      overviewController.isWeek.value = false;
                      overviewController.isMonth.value = false;
                      overviewController.is1Hour.value = false;
                      overviewController.is6Hour.value = false;
                      overviewController.is12Hour.value = false;
                    }
                  },
                  isWeek: overviewController.isWeek.value,
                  weekSelect: (){
                    overviewController.getWeekData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.isWeek.value == false) {
                      overviewController.is24Hour.value = false;
                      overviewController.isWeek.value = true;
                      overviewController.isMonth.value = false;
                      overviewController.is1Hour.value = false;
                      overviewController.is6Hour.value = false;
                      overviewController.is12Hour.value = false;
                    }
                  },
                  isMonth: overviewController.isMonth.value,
                  monthSelect: (){
                    overviewController.getMonthData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.isMonth.value == false) {
                      overviewController.is24Hour.value = false;
                      overviewController.isWeek.value = false;
                      overviewController.isMonth.value = true;
                      overviewController.is1Hour.value = false;
                      overviewController.is6Hour.value = false;
                      overviewController.is12Hour.value = false;
                    }
                  },
                  is1Hour: overviewController.is1Hour.value,
                  hour1Select: (){
                    overviewController.get1HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.is1Hour.value == false) {
                      overviewController.is24Hour.value = false;
                      overviewController.isWeek.value = false;
                      overviewController.isMonth.value = false;
                      overviewController.is1Hour.value = true;
                      overviewController.is6Hour.value = false;
                      overviewController.is12Hour.value = false;
                    }
                  },
                  is6Hour: overviewController.is6Hour.value,
                  hour6Select: (){
                    overviewController.get6HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.is6Hour.value == false) {
                      overviewController.is24Hour.value = false;
                      overviewController.isWeek.value = false;
                      overviewController.isMonth.value = false;
                      overviewController.is1Hour.value = false;
                      overviewController.is6Hour.value = true;
                      overviewController.is12Hour.value = false;
                    }
                  },
                  is12Hour: overviewController.is12Hour.value,
                  hour12Select: (){
                    overviewController.get12HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (overviewController.is12Hour.value == false) {
                      overviewController.is24Hour.value = false;
                      overviewController.isWeek.value = false;
                      overviewController.isMonth.value = false;
                      overviewController.is1Hour.value = false;
                      overviewController.is6Hour.value = false;
                      overviewController.is12Hour.value = true;
                    }
                  },
                  graph: Obx(() => overviewController.isClimateData.value == true
                      ? controller.graph()
                      : SizedBox(height: 150.h,))
              ),),
              SizedBox(height: 10.h,),
              growSheetWidget(
                selectStage: overviewController.selectStage,
                isFlowering: overviewController.isFlowering,
                isGermination: overviewController.isGermination,
                isSeedling: overviewController.isSeedling,
                isVegetative: overviewController.isVegetative,
                context: context,
                plantedDate: overviewController.plantedDate,
                harvestDate: overviewController.harvestDate,
                plantedDateValue: overviewController.plantedDateValue,
                harvestDateValue: overviewController.harvestDateValue,
                controller: overviewController.barcodeController,
                plantController: overviewController.plantController,
                genealogyController: overviewController.genealogyController,
                  rangeValue1: overviewController.rangeValue1,
                  rangeValue2: overviewController.rangeValue2,
                  rangeValue3: overviewController.rangeValue3,
                  rangeValue4: overviewController.rangeValue4,
                  progressValue: overviewController.progressValue,
                onTap: (){},
                  plantedTap: () {
                    if (overviewController.harvestDate.selectedDate!
                        .toString()
                        .isNotEmpty) {

                      overviewController.progressValue.value = 0;

                      overviewController.totalPeriod.value = overviewController
                          .harvestDate.selectedDate!
                          .difference(overviewController
                          .plantedDate.selectedDate!)
                          .inDays +
                          1;

                      overviewController.currentDay.value =
                          DateTime.now()
                              .difference(overviewController
                              .plantedDate
                              .selectedDate!)
                              .inDays +
                              1;

                      final data = overviewController.graphData();

                      final num totalSpent = data.values
                          .reduce((prev, curr) => prev + curr);
                      overviewController.progressValue.value =
                          ((totalSpent /
                              overviewController
                                  .totalPeriod.value) *
                              100)
                              .ceil()
                              .clamp(0, 100);

                      AppConst().debug(
                          "progress value => ${overviewController.progressValue.value}");

                      overviewController.resolveAngles(data, overviewController.totalPeriod.value);

                    }
                  },
                  harvestTap: () async {

                    if ( overviewController.plantedDate.selectedDate!.toString().isNotEmpty ) {
                      overviewController.progressValue.value = 0;

                      overviewController.totalPeriod.value = overviewController
                          .harvestDate.selectedDate!
                          .difference(overviewController
                          .plantedDate.selectedDate!)
                          .inDays +
                          1;

                      overviewController.currentDay.value = DateTime
                          .now()
                          .difference(overviewController
                          .plantedDate.selectedDate!)
                          .inDays +
                          1;

                      final data = overviewController.graphData();

                      final num totalSpent = data.values
                          .reduce((prev, curr) => prev + curr);
                      overviewController.progressValue.value =
                          ((totalSpent /
                              overviewController
                                  .totalPeriod.value) *
                              100)
                              .ceil()
                              .clamp(0, 100);

                      AppConst().debug(
                          "progress value => ${overviewController
                              .progressValue.value}");

                      overviewController.resolveAngles(data, overviewController.totalPeriod.value);
                    }
                  }
              ),
              SizedBox(height: 10.h,),
              deviceOverviewWidget(
                  onTap: (){},
                  switchesOnline: overviewController.deviceModel.devices!
                      .devicesSwitch!.online.toString(),
                  switchesOffline: overviewController.deviceModel
                      .devices!.devicesSwitch!.offline.toString(),
                  sensorOnline: overviewController.deviceModel
                      .devices!.sensor!.online.toString(),
                  sensorOffline: overviewController.deviceModel
                      .devices!.sensor!.offline.toString(),
                  valvesOnline: overviewController.deviceModel
                      .devices!.valve!.online.toString(),
                  valvesOffline: overviewController.deviceModel
                      .devices!.valve!.offline.toString()
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      )),
    );
  }
}
