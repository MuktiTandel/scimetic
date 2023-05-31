import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/elements/select_widget.dart';
import 'package:scimetic/feature/calendar/controller/calendar_controller.dart';
import 'package:scimetic/feature/calendar/view/day_calendar.dart';
import 'package:scimetic/feature/calendar/view/month_calendar.dart';
import 'package:scimetic/feature/calendar/view/week_calendar.dart';
import 'package:scimetic/feature/calendar/view/year_calendar.dart';

class CalendarScreen extends StatelessWidget {
   CalendarScreen({
     Key? key,
   }) : super(key: key);

   final controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Obx(() => controller.personalCalendar.value == false
          ? personalCalendar() : cropCalendar(),)
    );
  }

  Widget personalCalendar() {
    return Column(
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
        Obx(() => controller.isDay.value == true
            ? DayCalendar(
          dayEventList: controller.dayEventList,
        )
            : controller.isWeek.value == true
            ?  WeekCalendar(
          weekEventList: controller.dayEventList,
        )
            : controller.isMonth.value == true
            ?  MonthCalendar(
          eventList: controller.eventList,
        ) : YearCalendar())
      ],
    );
  }

  Widget cropCalendar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10.w),
          child: ScrollConfiguration(
            behavior: AppBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Obx(() => cropSelectWidget(
                      onTap: (){
                        if ( controller.isCropWeek.value == false ) {
                          controller.isCropWeek.value = true;
                          controller.isCropMonth.value = false;
                          controller.isMonth3.value = false;
                          controller.isMonth6.value = false;
                          controller.isCropYear.value = false;
                        }
                      },
                      text: AppStrings.week,
                      isSelected: controller.isCropWeek.value
                  ),),
                  SizedBox(width: 10.w,),
                  Obx(() => cropSelectWidget(
                      onTap: (){
                        if ( controller.isCropMonth.value == false ) {
                          controller.isCropWeek.value = false;
                          controller.isCropMonth.value = true;
                          controller.isMonth3.value = false;
                          controller.isMonth6.value = false;
                          controller.isCropYear.value = false;
                        }
                      },
                      text: AppStrings.month,
                      isSelected: controller.isCropMonth.value
                  ),),
                  SizedBox(width: 10.w,),
                  Obx(() => cropSelectWidget(
                      onTap: (){
                        if ( controller.isMonth3.value == false ) {
                          controller.isCropWeek.value = false;
                          controller.isCropMonth.value = false;
                          controller.isMonth3.value = true;
                          controller.isMonth6.value = false;
                          controller.isCropYear.value = false;
                        }
                      },
                      text: AppStrings.month3,
                      isSelected: controller.isMonth3.value
                  ),),
                  SizedBox(width: 10.w,),
                  Obx(() => cropSelectWidget(
                      onTap: (){
                        if ( controller.isMonth6.value == false ) {
                          controller.isCropWeek.value = false;
                          controller.isCropMonth.value = false;
                          controller.isMonth3.value = false;
                          controller.isMonth6.value = true;
                          controller.isCropYear.value = false;
                        }
                      },
                      text: AppStrings.month6,
                      isSelected: controller.isMonth6.value
                  ),),
                  SizedBox(width: 10.w,),
                  Obx(() => cropSelectWidget(
                      onTap: (){
                        if ( controller.isCropYear.value == false ) {
                          controller.isCropWeek.value = false;
                          controller.isCropMonth.value = false;
                          controller.isMonth3.value = false;
                          controller.isMonth6.value = false;
                          controller.isCropYear.value = true;
                        }
                      },
                      text: AppStrings.year,
                      isSelected: controller.isCropYear.value
                  ),),
                ],
              ),
            ),
          ),
        ),
        /*Obx(() => controller.isCropWeek.value == false
            ? CropWeek(getDay: controller.getIndex(),getDates
            : controller.getDateList(),) : SizedBox())*/
      ],
    );
  }

   Widget cropSelectWidget({ required VoidCallback onTap,
     required String text, required bool isSelected}) {
     return GestureDetector(
       onTap: (){
         onTap();
       },
       child: Container(
         height: 35.h,
         width: 80.w,
         decoration: BoxDecoration(
             color: isSelected == true
                 ? Get.isDarkMode ? AppColors.darkBlue : Colors.white
                 : Get.isDarkMode ? AppColors.darkTheme : AppColors.lightGray2,
             borderRadius: BorderRadius.circular(8)
         ),
         child: Center(
           child: CustomText(
             text: text,
             color: isSelected == true
                 ? Get.isDarkMode ? Colors.white : Colors.black
                 : Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
             fontSize: 15.sp,
             fontWeight: FontWeight.w500,
           ),
         ),
       ),
     );
   }
}
