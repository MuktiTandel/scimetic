import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.w),
                      child: Row(
                        children: [
                          CustomText(
                              text: AppStrings.temperature,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          Expanded(child: SizedBox(width: 10.w,)),
                          Image.asset(
                            AppImages.menu_,
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
                            height : 45.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                    text: "24",
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orange,
                                ),
                                SizedBox(width: 4.w,),
                                CustomText(
                                    text: "°C",
                                  fontSize: 18.sp,
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                             Obx(() =>  selectWidget(
                                 title: AppStrings.hours,
                                 width: 34.w,
                                 isSelected: controller.isHour.value,
                                 onTap: (){
                                   if ( controller.isHour.value == false ) {
                                     controller.isHour.value = true;
                                     controller.isWeek.value = false;
                                     controller.isMonth.value = false;
                                   }
                                 }
                             ),),
                              SizedBox(width: 10.w,),
                              Obx(() => selectWidget(
                                  title: AppStrings.week,
                                  width: 46.w,
                                  isSelected: controller.isWeek.value,
                                  onTap: (){
                                    if ( controller.isWeek.value == false ) {
                                      controller.isHour.value = false;
                                      controller.isWeek.value = true;
                                      controller.isMonth.value = false;
                                    }
                                  }
                              ),),
                              SizedBox(width: 10.w,),
                              Obx(() => selectWidget(
                                  title: AppStrings.month,
                                  width: 50.w,
                                  isSelected: controller.isMonth.value,
                                  onTap: (){
                                    if ( controller.isMonth.value == false ) {
                                      controller.isHour.value = false;
                                      controller.isWeek.value = false;
                                      controller.isMonth.value = true;
                                    }
                                  }
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    SizedBox(
                      height: 150.h,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        primaryXAxis: NumericAxis(
                          interval: 2,
                          minimum: 0,
                          maximum: 25,
                          isVisible: true,
                          anchorRangeToVisiblePoints: true,
                          axisLine: const AxisLine(width: 0),
                           majorTickLines: const MajorTickLines(
                               color: Colors.transparent,width: 0),
                          title: AxisTitle(
                              text: "07.03.2021",
                            textStyle: TextStyle(
                              color: AppColors.subTitleColor,
                              fontSize: 12.sp,
                              fontFamily: "Poppins"
                            )
                          ),
                          majorGridLines: const MajorGridLines(
                              color: Colors.transparent,width: 0),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          )
                        ),
                        primaryYAxis: NumericAxis(
                          interval: 8,
                          axisLine: const AxisLine(width: 0, color: Colors.transparent),
                          isVisible: true,
                          minimum: 20,
                          maximum: 29,
                          anchorRangeToVisiblePoints: false
                        ),
                        series: controller.getSeries(),
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

