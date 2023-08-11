import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scimetic/feature/calendar/controller/calendar_controller.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class YearCalendar extends StatelessWidget {
  YearCalendar({Key? key}) : super(key: key);

  final controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return /*Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              CustomText(
                  text: "${DateTime.now().year}",
                color: AppColors.buttonColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              Expanded(child: SizedBox(width: 10.w,)),
              GestureDetector(
                onTap: (){},
                child: Image.asset(
                    AppImages.calendarLeftArrow,
                  height: 15.h,
                  width: 15.w,
                ),
              ),
              SizedBox(width: 15.w,),
              GestureDetector(
                onTap: (){},
                child: Image.asset(
                    AppImages.calendarRightArrow,
                  height: 15.h,
                  width: 15.w,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h,),
        SfCalendar(
          view: CalendarView.month,
          allowViewNavigation: false,
        )
      ],
    )*/Expanded(
      child: ScrollableCleanCalendar(
        calendarController: controller.calendarController,
        layout: Layout.BEAUTY,
        calendarCrossAxisSpacing: 0,
        dayTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp),
        showWeekdays: true,
        monthTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.buttonColor),
        weekdayTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15.sp,
            color: Get.isDarkMode ? AppColors.darkBlue3 : AppColors.lightIcon,
            fontWeight: FontWeight.w500),
        dayDisableColor: Get.isDarkMode
            ? Colors.white.withOpacity(0.5)
            : AppColors.lightText,
      ),
    );
  }
}
