import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/common_graph_widget.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/energy_management/controller/energy_management_controller.dart';
import 'package:scimetic/feature/energy_management/element/energy_month_graph.dart';
import 'package:scimetic/feature/energy_management/element/energy_week_graph.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class EnergyManagementScreen extends StatelessWidget {
   EnergyManagementScreen({Key? key}) : super(key: key);

   final controller = Get.put(EnergyManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
          behavior: AppBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h,),
                Obx(() => commonGraphWidget(
                    title: AppStrings.temperature,
                    image: AppImages.menu_,
                    value: "24",
                    value1: "°C",
                    isHour: controller.isTemHour.value,
                    isWeek: controller.isTemWeek.value,
                    isMonth: controller.isTemMonth.value,
                    hourSelect: () {
                      if ( controller.isTemHour.value == false ) {
                        controller.isTemHour.value = true;
                        controller.isTemWeek.value = false;
                        controller.isTemMonth.value = false;
                      }
                    },
                    weekSelect: (){
                      if ( controller.isTemWeek.value == false ) {
                        controller.isTemHour.value = false;
                        controller.isTemWeek.value = true;
                        controller.isTemMonth.value = false;
                      }
                    },
                    monthSelect: (){
                      if ( controller.isTemMonth.value == false ) {
                        controller.isTemHour.value = false;
                        controller.isTemWeek.value = false;
                        controller.isTemMonth.value = true;
                      }
                    },
                    graph: controller.isTemHour.value == true ? HourGraph(
                      minY: 20,
                      maxY: 31,
                      dataList: controller.temperatureHourDataList,
                      graphColor: AppColors.orange,
                      format: "°C",
                    ) : controller.isTemWeek.value == true ? EnergyWeekGraph(
                        minY: 20,
                        maxY: 31,
                        graphColor: AppColors.orange,
                        dataList: controller.temperatureWeekDataList,
                        format: "°C",
                        graphColor1: AppColors.darkOrange1,
                        graphColor2: AppColors.darkOrange
                    ) : EnergyMonthGraph(
                        minY: 20,
                        maxY: 31,
                        graphColor: AppColors.orange,
                        dataList: controller.temperatureMonthData,
                        format: "°C",
                        graphColor1: AppColors.darkOrange,
                        graphColor2: AppColors.darkOrange1
                    ),
                    color: AppColors.orange,
                    onTap: (){
                    },
                  isPhase: false
                )),
                SizedBox(height: 10.h,),
                Obx(() => commonGraphWidget(
                    title: AppStrings.electricalLoad,
                    image: AppImages.fillSettings,
                    value: "82",
                    value1: "kw",
                    value2: "85",
                    value3: "91",
                    title1: AppStrings.phase1,
                    title2: AppStrings.phase2,
                    title3: AppStrings.phase3,
                    isHour: controller.isElectricalHour.value,
                    isWeek: controller.isElectricalWeek.value,
                    isMonth: controller.isElectricalMonth.value,
                    hourSelect: () {
                      if ( controller.isElectricalHour.value == false ) {
                        controller.isElectricalHour.value = true;
                        controller.isElectricalWeek.value = false;
                        controller.isElectricalMonth.value = false;
                      }
                    },
                    weekSelect: (){
                      if ( controller.isElectricalWeek.value == false ) {
                        controller.isElectricalHour.value = false;
                        controller.isElectricalWeek.value = true;
                        controller.isElectricalMonth.value = false;
                      }
                    },
                    monthSelect: (){
                      if ( controller.isElectricalMonth.value == false ) {
                        controller.isElectricalHour.value = false;
                        controller.isElectricalWeek.value = false;
                        controller.isElectricalMonth.value = true;
                      }
                    },
                    graph: controller.isElectricalHour.value == true ? HourGraph(
                      minY: 80,
                      maxY: 91,
                      dataList: controller.electricalLoadHourData,
                      graphColor: AppColors.lightBlue1,
                      format: "kw",
                    ) : controller.isElectricalWeek.value == true ? EnergyWeekGraph(
                        minY: 80,
                        maxY: 91,
                        graphColor: AppColors.lightBlue1,
                        dataList: controller.electricalLoadWeekData,
                        format: "kw",
                        graphColor1: AppColors.lightBlue,
                        graphColor2: AppColors.lightBlue3
                    ) : EnergyMonthGraph(
                        minY: 80,
                        maxY: 91,
                        graphColor: AppColors.lightBlue1,
                        dataList: controller.electricalLoadMonthData,
                        format: "kw",
                        graphColor1: AppColors.lightBlue,
                        graphColor2: AppColors.lightBlue3
                    ),
                    color: AppColors.lightBlue,
                    onTap: (){
                    },
                  isPhase: true
                )),
                SizedBox(height: 10.h,),
                Obx(() => commonGraphWidget(
                    title: AppStrings.voltages,
                    image: AppImages.horizontalMenu,
                    value: "710",
                    value1: "v",
                    value2: "750",
                    value3: "810",
                    title1: "L-N, V",
                    title2: "L-L, V",
                    title3: "A",
                    isHour: controller.isVoltageHour.value,
                    isWeek: controller.isVoltageWeek.value,
                    isMonth: controller.isVoltageMonth.value,
                    hourSelect: () {
                      if ( controller.isVoltageHour.value == false ) {
                        controller.isVoltageHour.value = true;
                        controller.isVoltageWeek.value = false;
                        controller.isVoltageMonth.value = false;
                      }
                    },
                    weekSelect: (){
                      if ( controller.isVoltageWeek.value == false ) {
                        controller.isVoltageHour.value = false;
                        controller.isVoltageWeek.value = true;
                        controller.isVoltageMonth.value = false;
                      }
                    },
                    monthSelect: (){
                      if ( controller.isVoltageMonth.value == false ) {
                        controller.isVoltageHour.value = false;
                        controller.isVoltageWeek.value = false;
                        controller.isVoltageMonth.value = true;
                      }
                    },
                    graph: controller.isVoltageHour.value == true ? HourGraph(
                      minY: 700,
                      maxY: 800,
                      dataList: controller.voltageHourData,
                      graphColor: AppColors.lightBlue1,
                      format: "v",
                    ) : controller.isVoltageWeek.value == true ? EnergyWeekGraph(
                        minY: 700,
                        maxY: 800,
                        graphColor: AppColors.lightGreen4,
                        dataList: controller.voltageWeekData,
                        format: "v",
                        graphColor1: AppColors.lightGreen1,
                        graphColor2: AppColors.lightGreen2
                    ) : EnergyMonthGraph(
                        minY: 700,
                        maxY: 800,
                        graphColor: AppColors.lightGreen4,
                        dataList: controller.voltageMonthData,
                        format: "v",
                        graphColor1: AppColors.lightGreen1,
                        graphColor2: AppColors.lightGreen2
                    ),
                    color: AppColors.lightGreen1,
                    onTap: (){
                    },
                    isPhase: true
                )),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Row(
                          children: [
                            CustomText(
                              text: AppStrings.fuelLevel,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Get.isDarkMode ? Colors.white : Colors.black,
                            ),
                            Expanded(child: SizedBox(width: 10.w,)),
                            Image.asset(
                              AppImages.horizontalMenu,
                              height: 20.h,
                              width: 20.w,
                              color: Get.isDarkMode
                                  ? AppColors.darkText : AppColors.lightText,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.2.w,
                        color: Get.isDarkMode ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                          padding: EdgeInsets.all(15.w),
                        child: Column(
                          children: [
                            Center(
                              child: SfRadialGauge(
                                  axes:<RadialAxis>[
                                    RadialAxis(
                                        showTicks: false,
                                      interval: 20,
                                      minimum: 20,
                                      maximum: 101,
                                      axisLineStyle: const AxisLineStyle(
                                        thickness: 15,
                                          cornerStyle:CornerStyle.bothCurve,
                                        color: AppColors.lightAppbar,
                                      ),
                                      axisLabelStyle: GaugeTextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14.sp
                                      ),
                                      pointers: <GaugePointer>[
                                        RangePointer(
                                          width: 13.w,
                                          value: 80,
                                          gradient: const SweepGradient(
                                              colors: [
                                            AppColors.lightGreen2,
                                            AppColors.orange
                                          ],
                                          ),
                                          cornerStyle: CornerStyle.bothCurve,
                                        ),
                                        const NeedlePointer(
                                          value: 80,
                                          needleColor: AppColors.orange,
                                        )
                                      ],
                                    )
                                  ]
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.h,)
              ],
            ),
          )
      ),
    );
  }
}
