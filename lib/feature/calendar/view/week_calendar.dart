import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 537.h,
      child: SfCalendar(
        view: CalendarView.week,
        backgroundColor: Get.isDarkMode
            ? AppColors.darkTheme : Colors.white,
        todayHighlightColor: Colors.transparent,
        cellBorderColor: Get.isDarkMode
            ? AppColors.darkText : AppColors.lightGray3,
        specialRegions: _getTimeRegions(),
        timeRegionBuilder: (BuildContext context, TimeRegionDetails timeRegionDetails ) {
          return Padding(
            padding:  EdgeInsets.all(5.w),
            child: Container(
                padding: EdgeInsets.all(7.w),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: timeRegionDetails.region.color
                ),
                child: Text(
                  timeRegionDetails.region.text!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: timeRegionDetails.region.textStyle
                )
            ),
          );
        },
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
            color: AppColors.buttonColor,
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          )
        ),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
            color: Get.isDarkMode ? AppColors.darkText : AppColors.lightIcon,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp
          ),
          dateTextStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp
          ),
        ),
        timeSlotViewSettings: TimeSlotViewSettings(
            timeTextStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Get.isDarkMode
                  ? AppColors.darkText : AppColors.lightIcon,
            ),
            timeFormat: "HH:mm",
            timeIntervalHeight: 40.h,
            timeIntervalWidth: 50.w,
            timeRulerSize: 55.w,
          dayFormat: "E",
        ),
        todayTextStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp
        ),
      ),
    );
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(
      TimeRegion(
          startTime: DateTime(2023,05,10,10),
          endTime: DateTime(2023,05,10,11),
          enablePointerInteraction: false,
          color: AppColors.blue,
          text: AppStrings.taskDesc,
        textStyle: TextStyle(
            fontSize: 13.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      ),
    );

    regions.add(TimeRegion(
        startTime: DateTime(2023,05,10,14),
        endTime: DateTime(2023,05,10,15),
        enablePointerInteraction: false,
        color: AppColors.orange,
        text: AppStrings.taskDesc,
      textStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.black,
      ),
    ),);

    regions.add(TimeRegion(
        startTime: DateTime(2023,05,07,06),
        endTime: DateTime(2023,05,07,07),
        enablePointerInteraction: false,
        color: AppColors.orange,
        text: AppStrings.taskDesc,
      textStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.black
      ),
    ),);

    regions.add(TimeRegion(
        startTime: DateTime(2023,05,08,07),
        endTime: DateTime(2023,05,08,08),
        enablePointerInteraction: false,
        color: AppColors.blue,
        text: AppStrings.taskDesc,
      textStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.white
      ),
    ),);

    regions.add(
      TimeRegion(
          startTime: DateTime(2023,05,10,07),
          endTime: DateTime(2023,05,10,08),
          enablePointerInteraction: false,
          color: AppColors.blue,
          text: AppStrings.taskDesc,
        textStyle: TextStyle(
            fontSize: 13.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
      ),
    );

    regions.add(
      TimeRegion(
          startTime: DateTime(2023,05,13,08),
          endTime: DateTime(2023,05,13,09),
          enablePointerInteraction: false,
          color: AppColors.orange,
          text: AppStrings.taskDesc,
        textStyle: TextStyle(
            fontSize: 13.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: Colors.black
        ),
      ),
    );

    return regions;
  }
}
