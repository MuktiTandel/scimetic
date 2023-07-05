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
      startDate: DateTime.now(), //required
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
      weekHeaderBuilder: (context, date) {
        return Text(date.toString());
      },
      dayHeaderHeight: 50.h,
      holidayColor: Colors.white,
      events: [
        //event relative to startDate
        GanttRelativeEvent(
          relativeToStart: const Duration(days: 0),
          duration: const Duration(days: 5),
          displayName: 'Do a very helpful task',
        ),
        //event with absolute start and end
        GanttAbsoluteEvent(
          startDate: DateTime(2022, 6, 10),
          endDate: DateTime(2022, 6, 16),
          displayName: 'Another task',
        ),
      ],
    );
  }
}

