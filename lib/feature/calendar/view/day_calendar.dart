import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DayCalendar extends StatelessWidget {
  const DayCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 537.h,
      child: SfCalendar(
        headerDateFormat: "dd EEEE",
        backgroundColor: Get.isDarkMode
            ? AppColors.darkTheme : Colors.white,
        specialRegions: _getTimeRegions(),
        timeRegionBuilder: (BuildContext context, TimeRegionDetails timeRegionDetails ) {
          return Padding(
            padding:  EdgeInsets.only(left: 5.w, top: 5.w, bottom: 5.w),
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
                ),
                color: timeRegionDetails.region.color
              ),
              child: Text(
                timeRegionDetails.region.text!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: timeRegionDetails.region.textStyle
              )
            ),
          );
        },
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: AppColors.buttonColor,
            fontFamily: "Poppins"
          )
        ),
        todayHighlightColor: Colors.transparent,
        cellBorderColor: Get.isDarkMode
            ? AppColors.darkText : AppColors.lightGray3,
        viewHeaderHeight: 0,
        timeSlotViewSettings: TimeSlotViewSettings(
          timeTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Get.isDarkMode
                ? AppColors.darkText : AppColors.lightIcon,
          ),
          timeFormat: "HH:mm",
          timeIntervalHeight: 50.h,
          dayFormat: "",
          dateFormat: "",
          timeRulerSize: 55.w
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
              fontSize: 11.sp,
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
          fontSize: 11.sp,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.black
      ),
    ),);

    return regions;
  }

}
