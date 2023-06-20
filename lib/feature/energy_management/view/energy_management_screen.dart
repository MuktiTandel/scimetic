import 'package:dotted_line/dotted_line.dart';
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
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
                    context: context,
                    title: AppStrings.temperature,
                    image: AppImages.menu_,
                    value: "24",
                    value1: "°C",
                    is1Hour: controller.is1Hour.value,
                    is6Hour: controller.is6Hour.value,
                    is12Hour: controller.is12Hour.value,
                    is24Hour: controller.isTemHour.value,
                    isWeek: controller.isTemWeek.value,
                    isMonth: controller.isTemMonth.value,
                    hour1Select: (){},
                    hour6Select: (){},
                    hour12Select: (){},
                    hour24Select: () {
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
                    context: context,
                    title: AppStrings.electricalLoad,
                    image: AppImages.fillSettings,
                    value: "82",
                    value1: "kw",
                    value2: "85",
                    value3: "91",
                    title1: AppStrings.phase1,
                    title2: AppStrings.phase2,
                    title3: AppStrings.phase3,
                    is1Hour: controller.is1Hour.value,
                    is6Hour: controller.is6Hour.value,
                    is12Hour: controller.is12Hour.value,
                    is24Hour: controller.isElectricalHour.value,
                    isWeek: controller.isElectricalWeek.value,
                    isMonth: controller.isElectricalMonth.value,
                    hour1Select: (){},
                    hour6Select: (){},
                    hour12Select: (){},
                    hour24Select: () {
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
                    context: context,
                    title: AppStrings.voltages,
                    image: AppImages.horizontalMenu,
                    value: "710",
                    value1: "v",
                    value2: "750",
                    value3: "810",
                    title1: "L-N, V",
                    title2: "L-L, V",
                    title3: "A",
                    is1Hour: controller.is1Hour.value,
                    is6Hour: controller.is6Hour.value,
                    is12Hour: controller.is12Hour.value,
                    is24Hour: controller.isVoltageHour.value,
                    isWeek: controller.isVoltageWeek.value,
                    isMonth: controller.isVoltageMonth.value,
                    hour1Select: (){},
                    hour6Select: (){},
                    hour12Select: (){},
                    hour24Select: () {
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
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 50.w, right: 50.w,),
                            child: Center(
                              child: SfRadialGauge(
                                  axes:<RadialAxis>[
                                    RadialAxis(
                                        showTicks: false,
                                      interval: 20,
                                      minimum: 20,
                                      maximum: 101,
                                      axisLineStyle: AxisLineStyle(
                                        thickness: 15,
                                          cornerStyle:CornerStyle.bothCurve,
                                        color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
                                      ),
                                      axisLabelStyle: GaugeTextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14.sp,
                                        color: Get.isDarkMode ? Colors.white : Colors.black
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
                                         NeedlePointer(
                                          value: 80,
                                          needleColor: AppColors.orange,
                                          knobStyle: KnobStyle(
                                            color: Get.isDarkMode ? AppColors.darkBlue : AppColors.subTitleColor
                                          ),
                                        ),
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                           angle: 80,
                                            positionFactor: 0.6,
                                            widget: Center(
                                              child: SizedBox(
                                                height: 71.h,
                                                width: 63.w,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                                SizedBox(
                                                  height: 31.5.h,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          "80",
                                                        style: TextStyle(
                                                          color: AppColors.orange,
                                                          fontSize: 32.sp,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: "Roboto"
                                                        ),
                                                      ),
                                                      CustomText(
                                                          text: "%",
                                                        color: AppColors.orange,
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.w600,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            Padding(
                                              padding: EdgeInsets.only(right: 12.w),
                                              child: CustomText(
                                                  text: AppStrings.total,
                                                fontSize: 15.sp,
                                                color: Get.isDarkMode
                                                    ? Colors.white : AppColors.subTitleColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ]
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15.w, right: 15.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        AppStrings.averageConsumption,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13.sp,
                                        color: AppColors.subTitleColor.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins"
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "10",
                                            style: TextStyle(
                                              fontSize: 25.h,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.lightBlue
                                            ),
                                          ),
                                          CustomText(
                                              text: "Lr/hr",
                                              color: AppColors.lightBlue,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(width: 10.w,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 4.w,),
                                DottedLine(
                                  direction: Axis.vertical,
                                  lineLength: 42.h,
                                  lineThickness: 0.3.w,
                                  dashGapLength: 3.h,
                                ),
                                SizedBox(width: 4.w,),
                                Column(
                                  children: [
                                    Text(
                                      AppStrings.currentConsumption,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 13.sp,
                                          color: AppColors.subTitleColor.withOpacity(0.5),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins"
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "79",
                                            style: TextStyle(
                                                fontSize: 25.h,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.green
                                            ),
                                          ),
                                          CustomText(
                                            text: "%",
                                            color: AppColors.green,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(width: 10.w,),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Row(
                          children: [
                            CustomText(
                              text: AppStrings.generatorReady,
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
                      Center(
                        child: Image.asset(
                            AppImages.generatorReady,
                          height: 250.h,
                          width: 250.w,
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Row(
                          children: [
                            CustomText(
                              text: AppStrings.generatorRunning,
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
                      Center(
                        child: Image.asset(
                          AppImages.generatorRunning,
                          height: 250.h,
                          width: 250.w,
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Container(
                  color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.w),
                        child: Row(
                          children: [
                            CustomText(
                              text: AppStrings.alarms,
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
                      Padding(
                          padding: EdgeInsets.all(15.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            alarmCommonWidget(
                                title: AppStrings.currentRunTime,
                                selectValue: controller.currentRunTime.value,
                                range: AppStrings.h100,
                              activeColor: AppColors.lightBlue
                            ),
                            SizedBox(height: 10.h,),
                            alarmCommonWidget(
                                title: AppStrings.serviceRunTime,
                                selectValue: controller.serviceRunTime.value,
                                range: AppStrings.h30,
                              activeColor: AppColors.green
                            ),
                            SizedBox(height: 10.h,),
                            alarmCommonWidget(
                                title: AppStrings.totalRunTime,
                                selectValue: controller.totalRunTime.value,
                                range: AppStrings.h130,
                                activeColor: AppColors.orange
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

  Widget alarmCommonWidget({required String title,
    required double selectValue,
    required String range,
    required Color activeColor
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: AppColors.lightGray1,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        SizedBox(height: 5.h,),
        Row(
          children: [
            SfSliderTheme(
              data: SfSliderThemeData(
                thumbRadius: 0,
                activeTrackHeight: 8.h,
                inactiveTrackHeight: 8.h,
                overlayRadius: 0.0,
                activeDividerRadius: 8,
              ),
              child: Expanded(
                child: SfSlider(
                  value: selectValue,
                  min: 0,
                  max: 100,
                  inactiveColor: AppColors.lightGray4,
                  activeColor: activeColor,
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            CustomText(
              text: range,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.subTitleColor,
            )
          ],
        )
      ],
    );
  }
}
