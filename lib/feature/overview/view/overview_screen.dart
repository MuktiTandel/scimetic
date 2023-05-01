import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/month_graph.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/elements/hour_graph.dart';
import 'package:scimetic/core/elements/week_graph.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class OverviewScreen extends StatelessWidget {
   OverviewScreen({Key? key}) : super(key: key);

   final controller = Get.put(OverviewController());

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h,),
              Obx(() => commonWidget(
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
                  ) : controller.isTemWeek.value == true ? WeekGraph(
                      minY: 20,
                      maxY: 31,
                      graphColor: AppColors.orange,
                      dataList: controller.temperatureWeekDataList,
                      format: "°C",
                      graphColor1: AppColors.darkOrange
                  ) : MonthGraph(
                      minY: 20,
                      maxY: 31,
                      graphColor: AppColors.orange,
                      dataList: controller.temperatureMonthDataList,
                      format: "°C"
                  ),
                color: AppColors.orange
              )),
              SizedBox(height: 10.h,),
              Obx(() => commonWidget(
                  title: AppStrings.electricalLoad,
                  image: AppImages.fillSettings,
                  value: "85",
                  value1: "%",
                  isHour: controller.isElectricHour.value,
                  isWeek: controller.isElectricWeek.value,
                  isMonth: controller.isElectricMonth.value,
                  graph: controller.isElectricHour.value == true ? HourGraph(
                      minY: 80,
                      maxY: 91,
                      graphColor: AppColors.lightBlue,
                      dataList: controller.electricalDataList,
                    format: "kW",
                  ) : controller.isElectricWeek.value == true
                      ? WeekGraph(
                      minY: 80,
                      maxY: 91,
                      graphColor: AppColors.lightBlue,
                      dataList: controller.electricalWeekDataList,
                      format: "kW",
                      graphColor1: AppColors.lightBlue3
                  ) : MonthGraph(
                      minY: 80,
                      maxY: 91,
                      graphColor: AppColors.lightBlue,
                      dataList: controller.electricalMonthDataList,
                      format: "kW"
                  ),
                  hourSelect: () {
                    if ( controller.isElectricHour.value == false ) {
                      controller.isElectricHour.value = true;
                      controller.isElectricWeek.value = false;
                      controller.isElectricMonth.value = false;
                    }
                  },
                  weekSelect: (){
                    if ( controller.isElectricWeek.value == false ) {
                      controller.isElectricHour.value = false;
                      controller.isElectricWeek.value = true;
                      controller.isElectricMonth.value = false;
                    }
                  },
                  monthSelect: (){
                    if ( controller.isElectricMonth.value == false ) {
                      controller.isElectricHour.value = false;
                      controller.isElectricWeek.value = false;
                      controller.isElectricMonth.value = true;
                    }
                  },
                  color: AppColors.lightBlue
              )
              ),
              SizedBox(height: 10.h,),
              Obx(() => commonWidget(
                  title: AppStrings.cO2,
                  image: AppImages.horizontalMenu,
                  value: "750",
                  value1: AppStrings.ppm,
                  isHour: controller.isCo2Hour.value,
                  isWeek: controller.isCo2Week.value,
                  isMonth: controller.isCo2Month.value,
                  graph: controller.isCo2Hour.value == true ? HourGraph(
                      minY: 700,
                      maxY: 810,
                      graphColor: AppColors.lightGreen1,
                      dataList: controller.co2DataList,
                    format: " ppm",
                  ) : controller.isCo2Week.value == true
                      ? WeekGraph(
                      minY: 700,
                      maxY: 810,
                      graphColor: AppColors.lightGreen1,
                      dataList: controller.co2WeekDataList,
                      format: " ppm",
                      graphColor1: AppColors.lightGreen2
                  ) : MonthGraph(
                      minY: 700,
                      maxY: 810,
                      graphColor: AppColors.lightGreen1,
                      dataList: controller.co2MonthDataList,
                      format: " ppm"
                  ),
                  hourSelect: () {
                    if ( controller.isCo2Hour.value == false ) {
                      controller.isCo2Hour.value = true;
                      controller.isCo2Week.value = false;
                      controller.isCo2Month.value = false;
                    }
                  },
                  weekSelect: (){
                    if ( controller.isElectricWeek.value == false ) {
                      controller.isCo2Hour.value = false;
                      controller.isCo2Week.value = true;
                      controller.isCo2Month.value = false;
                    }
                  },
                  monthSelect: (){
                    if ( controller.isCo2Month.value == false ) {
                      controller.isCo2Hour.value = false;
                      controller.isCo2Week.value = false;
                      controller.isCo2Month.value = true;
                    }
                  },
                  color: AppColors.lightGreen1)
              ),
              SizedBox(height: 10.h,),
              Obx(() => commonWidget(
                  title: AppStrings.lightMode,
                  image: AppImages.menu_,
                  value: "40",
                  value1: AppStrings.molM2day,
                  isHour: controller.isLightHour.value,
                  isWeek: controller.isLightWeek.value,
                  isMonth: controller.isLightMonth.value,
                  graph: controller.isLightHour.value == true ? HourGraph(
                    minY: 35,
                    maxY: 46,
                    dataList: controller.lightningDataList,
                    graphColor: AppColors.pink,
                    format: " mol/m2day",
                  ) : controller.isLightWeek.value == true
                      ? WeekGraph(
                      minY: 35,
                      maxY: 46,
                      graphColor: AppColors.lightPink,
                      dataList: controller.lightningWeekDataList,
                      format: " mol/m2day",
                      graphColor1: AppColors.pink
                  ) : MonthGraph(
                      minY: 35,
                      maxY: 46,
                      graphColor: AppColors.pink,
                      dataList: controller.lightningMonthDataList,
                      format: " mol/m2day"
                  ),
                  hourSelect: (){
                    if ( controller.isLightHour.value == false ) {
                      controller.isLightHour.value = true;
                      controller.isLightWeek.value = false;
                      controller.isLightMonth.value = false;
                    }
                  },
                  weekSelect: (){
                    if ( controller.isLightWeek.value == false ) {
                      controller.isLightHour.value = false;
                      controller.isLightWeek.value = true;
                      controller.isLightMonth.value = false;
                    }
                  },
                  monthSelect: (){
                    if ( controller.isLightMonth.value == false ) {
                      controller.isLightHour.value = false;
                      controller.isLightWeek.value = false;
                      controller.isLightMonth.value = true;
                    }
                  },
                color: AppColors.pink
                  ),
              ),
              SizedBox(height: 10.h,),
              Obx(() => commonWidget(
                  title: AppStrings.vpd,
                  image: AppImages.horizontalMenu,
                  value: "0.95",
                  value1: AppStrings.kPa,
                  isHour: controller.isVdpHour.value,
                  isWeek: controller.isVdpWeek.value,
                  isMonth: controller.isVdpMonth.value,
                  graph: controller.isVdpHour.value == true ? HourGraph(
                      minY: 0.85,
                      maxY: 1.06,
                      graphColor: AppColors.lightBlue2,
                      dataList: controller.vdpDataList,
                    format: " kPa",
                  ) : controller.isVdpWeek.value == true
                      ? WeekGraph(
                      minY: 0.85,
                      maxY: 1.06,
                      graphColor: AppColors.lightBlue2,
                      dataList: controller.vdpWeekDataList,
                      format: " kPa",
                      graphColor1: AppColors.darkBlue2,
                  ) : MonthGraph(
                      minY: 0.85,
                      maxY: 1.06,
                      graphColor: AppColors.lightBlue2,
                      dataList: controller.vdpMonthDataList,
                      format: " kPa"
                  ),
                  hourSelect: (){
                    if ( controller.isVdpHour.value == false ) {
                      controller.isVdpHour.value = true;
                      controller.isVdpWeek.value = false;
                      controller.isVdpMonth.value = false;
                    }
                  },
                  weekSelect: (){
                    if ( controller.isVdpWeek.value == false ) {
                      controller.isVdpHour.value = false;
                      controller.isVdpWeek.value = true;
                      controller.isVdpMonth.value = false;
                    }
                  },
                  monthSelect: (){
                    if ( controller.isLightMonth.value == false ) {
                      controller.isVdpHour.value = false;
                      controller.isVdpWeek.value = false;
                      controller.isVdpMonth.value = true;
                    }
                  },
                  color: AppColors.lightBlue2
              )
              ),
              SizedBox(height: 10.h,),
              Container(
                width: Get.width,
                color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Row(
                        children: [
                          CustomText(
                            text: AppStrings.irrigationOverview,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          Image.asset(
                            AppImages.horizontalMenu,
                            height: 15.h,
                            width: 15.w,
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightText,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.2.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height : 40.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "12",
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.buttonColor,
                                ),
                                SizedBox(width: 4.w,),
                                CustomText(
                                  text: AppStrings.feedsFrom15,
                                  fontSize: 17.sp,
                                  color: AppColors.buttonColor,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              CustomText(
                                text: AppStrings.nextFeedAt,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Get.isDarkMode
                                    ? AppColors.darkText : AppColors.lightGray1,
                              ),
                              CustomText(
                                text: "14:35",
                                fontSize: 15.sp,
                                color: Get.isDarkMode
                                    ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          CustomText(
                            text: AppStrings.formulaName,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 3.h,),
                          CustomText(
                            text: AppStrings.formulaNameField,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.buttonColor,
                          ),
                          SizedBox(height: 5.h,),
                          CustomText(
                            text: AppStrings.seedling,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Row(
                        children: [
                          CustomText(
                            text: AppStrings.growsheet,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          Image.asset(
                            AppImages.horizontalMenu,
                            height: 15.h,
                            width: 15.w,
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightText,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.2.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppStrings.growsheetName,
                            fontSize: 20.sp,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 5.h,),
                          CustomText(
                            text: AppStrings.seedling,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.darkBlue : AppColors.lightAppbar,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.temperature,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "27°C / 23°C",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.humidity,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "75% / 80%",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.cO2,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "800ppm",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.lightning,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "18 / 6",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
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
              SizedBox(height: 10.h,),
              Container(
                width: Get.width,
                color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Row(
                        children: [
                          CustomText(
                            text: AppStrings.growsheet,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          Image.asset(
                            AppImages.horizontalMenu,
                            height: 15.h,
                            width: 15.w,
                            color: Get.isDarkMode
                                ? AppColors.darkText : AppColors.lightText,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.2.w,
                      color: Get.isDarkMode
                          ? AppColors.darkText.withOpacity(0.5) : AppColors.lightAppbar,
                    ),
                    Padding(
                      padding:  EdgeInsets.all(15.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: AppStrings.theTypeOfPlant,
                            fontSize: 20.sp,
                            color: AppColors.buttonColor,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 5.h,),
                          CustomText(
                            text: AppStrings.theGenealogy,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(height: 10.h,),
                          Container(
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.darkBlue : AppColors.lightAppbar,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.stage,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      PopupMenuButton<int>(
                                        offset: Offset(0, 23.h),
                                        padding: EdgeInsets.zero,
                                        color: Get.isDarkMode ? AppColors.darkTheme : Colors.white,
                                        constraints: BoxConstraints(
                                            maxWidth: 115.w,
                                            maxHeight: 75.h
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              text: AppStrings.flowering,
                                              fontSize: 15.sp,
                                              color: AppColors.red,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(width: 1.w,),
                                            Image.asset(
                                              AppImages.downArrow,
                                              color: AppColors.red,
                                              height: 25.h,
                                              width: 25.w,
                                            ),
                                          ],
                                        ),
                                        onSelected: (item) {},
                                        itemBuilder: (context) => [
                                          PopupMenuItem<int>(
                                              padding: EdgeInsets.zero,
                                              value: 0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:  EdgeInsets.only(left: 10.w,right: 20.w),
                                                    child: CustomText(
                                                      text: AppStrings.flowering,
                                                      fontSize: 15.sp,
                                                      color: AppColors.buttonColor,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Get.isDarkMode
                                                        ? AppColors.darkBlue1
                                                        : AppColors.lightGray2,
                                                    thickness: 1.w,
                                                  )
                                                ],
                                              )
                                          ),
                                          PopupMenuItem<int>(
                                              value: 1,
                                              padding: EdgeInsets.zero,
                                              height: 20.h,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                                child: Row(
                                                  children: [
                                                    CustomText(
                                                      text: AppStrings.seedling,
                                                      fontSize: 15.sp,
                                                      color: Get.isDarkMode
                                                          ? AppColors.darkText : AppColors.lightGray1,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    Expanded(child: SizedBox(width: 20.w,)),
                                                    Image.asset(
                                                        AppImages.rightArrow,
                                                      height: 10.h,
                                                      width: 10.w,
                                                      color: Get.isDarkMode
                                                          ? AppColors.darkText : AppColors.lightGray1,
                                                    )
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.planted,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "01.03.2020",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.estimatedHarvestTime,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "30.03.2021",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: AppStrings.barcode,
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? AppColors.darkIcon
                                            : AppColors.lightGray1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      CustomText(
                                        text: "1234567891012",
                                        fontSize: 15.sp,
                                        color: Get.isDarkMode
                                            ? Colors.white : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SfRadialGauge(
                            axes: [
                              RadialAxis(
                                minimum: 0,
                                maximum: 100,
                                showLabels: false,
                                showTicks: false,
                                startAngle: 0,
                                endAngle: 360,
                                radiusFactor: 0.7,
                                canScaleToFit: true,
                                axisLineStyle:  AxisLineStyle(
                                  thickness: 0.25,
                                  color: Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar,
                                  thicknessUnit: GaugeSizeUnit.factor,
                                  cornerStyle: CornerStyle.startCurve,
                                ),
                                pointers: const <GaugePointer>[
                                  RangePointer(
                                      value: 85,
                                      width: 0.25,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: AppColors.pink,
                                      cornerStyle: CornerStyle.bothCurve,
                                  ),
                                  RangePointer(
                                      value: 65,
                                      width: 0.25,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      color: AppColors.lightGreen3,
                                      cornerStyle: CornerStyle.bothCurve),
                                  RangePointer(
                                      value: 45,
                                      width: 0.25,
                                      color: AppColors.purple,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      cornerStyle: CornerStyle.bothCurve),
                                ],
                                annotations: [
                                  GaugeAnnotation(
                                      widget: Center(
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 30.w),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CustomText(
                                                  text: "75%",
                                                fontSize: 35.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Get.isDarkMode
                                                    ? Colors.white : Colors.black,
                                              ),
                                              CustomText(
                                                  text: AppStrings.progress,
                                                color: Get.isDarkMode
                                                    ? AppColors.darkText : AppColors.lightGray1,
                                                fontSize: 20.sp,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Widget commonWidget( {
    required String title,
    required String image,
    required String value,
    required String value1,
    required bool isHour,
    required bool isWeek,
    required bool isMonth,
    required Widget graph,
    required VoidCallback hourSelect,
    required VoidCallback weekSelect,
    required VoidCallback monthSelect,
    required Color color
  }) {
    return Container(
      color: Get.isDarkMode ? AppColors.darkTheme :  Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Row(
              children: [
                CustomText(
                  text: title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
                Expanded(child: SizedBox(width: 10.w,)),
                Image.asset(
                  image,
                  height: 15.h,
                  width: 15.w,
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
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(
                  height : 40.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        text: value,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                      SizedBox(width: 4.w,),
                      CustomText(
                        text: value1,
                        fontSize: 15.sp,
                        color: color,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Row(
                  children: [
                    selectWidget(
                        title: AppStrings.hours,
                        width: 34.w,
                        isSelected: isHour,
                        onTap: (){
                          hourSelect();
                        }
                    ),
                    SizedBox(width: 10.w,),
                    selectWidget(
                        title: AppStrings.week,
                        width: 46.w,
                        isSelected: isWeek,
                        onTap: (){
                         weekSelect();
                        }
                    ),
                    SizedBox(width: 10.w,),
                    selectWidget(
                        title: AppStrings.month,
                        width: 50.w,
                        isSelected: isMonth,
                        onTap: (){
                          monthSelect();
                        }
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          graph,
          SizedBox(height: 2.h,),
        ],
      ),
    );
  }

  Widget selectWidget( {
    required String title,
    required double width,
    required bool isSelected,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        onTap();
      },
      child: Column(
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected == false
                ? Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1
                : Get.isDarkMode ? Colors.white : Colors.black,
          ),
          Container(
            height: 1.5.h,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              color: isSelected == false
                  ? Get.isDarkMode ? AppColors.darkText : AppColors.lightGray1
                  : Get.isDarkMode ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

