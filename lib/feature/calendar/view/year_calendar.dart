import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class YearCalendar extends StatelessWidget {
  const YearCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
