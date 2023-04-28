import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/elements/hour_graph.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';

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
                  graph: HourGraph(
                    minY: 21,
                    maxY: 30,
                    dataList: controller.temperatureDataList,
                    graphColor: AppColors.orange,
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
                  graph: HourGraph(
                      minY: 80,
                      maxY: 91,
                      graphColor: AppColors.lightBlue,
                      dataList: controller.electricalDataList
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
                  graph: HourGraph(
                      minY: 700,
                      maxY: 810,
                      graphColor: AppColors.lightGreen1,
                      dataList: controller.co2DataList
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
                  graph: HourGraph(
                    minY: 35,
                    maxY: 46,
                    dataList: controller.lightningDataList,
                    graphColor: AppColors.pink,
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
              SizedBox(height: 10.h,)
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
      color: Colors.white,
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
                ),
                Expanded(child: SizedBox(width: 10.w,)),
                Image.asset(
                  image,
                  height: 15.h,
                  width: 15.w,
                )
              ],
            ),
          ),
          Divider(
            thickness: 1.w,
            color: AppColors.lightAppbar,
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
            color: isSelected == false ? AppColors.lightGray1 : Colors.black,
          ),
          Container(
            height: 1.5.h,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              color: isSelected == false ? AppColors.lightGray1 : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

