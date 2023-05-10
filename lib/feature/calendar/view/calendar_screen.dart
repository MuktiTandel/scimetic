import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/select_widget.dart';
import 'package:scimetic/feature/calendar/controller/calendar_controller.dart';
import 'package:scimetic/feature/calendar/view/day_calendar.dart';
import 'package:scimetic/feature/calendar/view/week_calendar.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({Key? key}) : super(key: key);

   final controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isDay.value == false ) {
                          controller.isDay.value = true;
                          controller.isWeek.value = false;
                          controller.isMonth.value = false;
                          controller.isYear.value = false;
                        }
                      },
                      text: AppStrings.day,
                      isSelected: controller.isDay.value
                  ),)
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isWeek.value == false ) {
                          controller.isDay.value = false;
                          controller.isWeek.value = true;
                          controller.isMonth.value = false;
                          controller.isYear.value = false;
                        }
                      },
                      text: AppStrings.week,
                      isSelected: controller.isWeek.value
                  ),)
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isMonth.value == false ) {
                          controller.isDay.value = false;
                          controller.isWeek.value = false;
                          controller.isMonth.value = true;
                          controller.isYear.value = false;
                        }
                      },
                      text: AppStrings.month,
                      isSelected: controller.isMonth.value
                  ),)
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Obx(() => selectWidget(
                      onTap: (){
                        if ( controller.isYear.value == false ) {
                          controller.isDay.value = false;
                          controller.isWeek.value = false;
                          controller.isMonth.value = false;
                          controller.isYear.value = true;
                        }
                      },
                      text: AppStrings.year,
                      isSelected: controller.isYear.value
                  ),)
                ),
              ],
            ),
          ),
          Obx(() => controller.isDay.value == true ? DayCalendar() : WeekCalendar())
        ],
      ),
    );
  }
}
