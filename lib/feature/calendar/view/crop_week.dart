import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/feature/calendar/element/event.dart';
import 'package:scimetic/feature/calendar/element/gantt_view.dart';
import 'package:scimetic/feature/calendar/element/week_day.dart';

class CropWeek extends StatelessWidget {
  const CropWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GanttChartView(
      maxDuration: const Duration(days: 40 * 2), //optional, set to null for infinite horizontal scroll
      startDate: DateTime.now().subtract(Duration(days: 7)), //required
      dayWidth: 51.3.w, //column width for each day
      eventHeight: 50.h, //row height for events
      stickyAreaWidth: 200, //sticky area width
      showStickyArea: false, //show sticky area or not
      showDays: true, //show days or not
      startOfTheWeek: WeekDay.sunday, //custom start of the week
      // weekEnds: const {WeekDay.friday, WeekDay.saturday}, //custom weekends
      isExtraHoliday: (context, day) {
        //define custom holiday logic for each day
        return DateUtils.isSameDay(DateTime(2022, 7, 1), day);
      },
      dayHeaderHeight: 50.h,
      holidayColor: Colors.white,
      events: [
        GanttAbsoluteEvent(
          startDate: DateTime(2023, 6, 4),
          endDate: DateTime(2023, 6, 28),
          displayName: 'Another task',
        ),
        GanttAbsoluteEvent(
          startDate: DateTime(2023, 7, 4),
          endDate: DateTime(2023, 7, 16),
          displayName: 'Another task',
        ),
      ],
    );
  }
}

