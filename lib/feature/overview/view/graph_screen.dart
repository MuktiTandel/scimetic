import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
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
            overviewController.get24HourData(
                id: overviewController.id.value,
                identifier: dashboardController.selectItem.value
            );
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
                  is24Hour: controller.is24Hour.value,
                  hour24Select: (){
                    overviewController.get24HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.is24Hour.value == false) {
                      controller.is24Hour.value = true;
                      controller.isWeek.value = false;
                      controller.isMonth.value = false;
                      controller.is1Hour.value = false;
                      controller.is6Hour.value = false;
                      controller.is12Hour.value = false;
                    }
                  },
                  isWeek: controller.isWeek.value,
                  weekSelect: (){
                    overviewController.getWeekData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.isWeek.value == false) {
                      controller.is24Hour.value = false;
                      controller.isWeek.value = true;
                      controller.isMonth.value = false;
                      controller.is1Hour.value = false;
                      controller.is6Hour.value = false;
                      controller.is12Hour.value = false;
                    }
                  },
                  isMonth: controller.isMonth.value,
                  monthSelect: (){
                    overviewController.getMonthData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.isMonth.value == false) {
                      controller.is24Hour.value = false;
                      controller.isWeek.value = false;
                      controller.isMonth.value = true;
                      controller.is1Hour.value = false;
                      controller.is6Hour.value = false;
                      controller.is12Hour.value = false;
                    }
                  },
                  is1Hour: controller.is1Hour.value,
                  hour1Select: (){
                    overviewController.get1HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.is1Hour.value == false) {
                      controller.is24Hour.value = false;
                      controller.isWeek.value = false;
                      controller.isMonth.value = false;
                      controller.is1Hour.value = true;
                      controller.is6Hour.value = false;
                      controller.is12Hour.value = false;
                    }
                  },
                  is6Hour: controller.is6Hour.value,
                  hour6Select: (){
                    overviewController.get6HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.is6Hour.value == false) {
                      controller.is24Hour.value = false;
                      controller.isWeek.value = false;
                      controller.isMonth.value = false;
                      controller.is1Hour.value = false;
                      controller.is6Hour.value = true;
                      controller.is12Hour.value = false;
                    }
                  },
                  is12Hour: controller.is12Hour.value,
                  hour12Select: (){
                    overviewController.get12HourData(
                        id: overviewController.id.value,
                        identifier: dashboardController.selectItem.value
                    );
                    if (controller.is12Hour.value == false) {
                      controller.is24Hour.value = false;
                      controller.isWeek.value = false;
                      controller.isMonth.value = false;
                      controller.is1Hour.value = false;
                      controller.is6Hour.value = false;
                      controller.is12Hour.value = true;
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
                plantedDateValue: controller.plantedDateValue,
                harvestDateValue: controller.harvestDateValue,
                controller: controller.barcodeController,
                plantController: controller.plantController,
                genealogyController: controller.genealogyController,
                  rangeValue1: controller.rangeValue1,
                  rangeValue2: controller.rangeValue2,
                  rangeValue3: controller.rangeValue3,
                  rangeValue4: controller.rangeValue4,
                  progressValue: controller.progressValue,
                onTap: (){},
                harvestTap: (){},
                plantedTap: (){}
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
