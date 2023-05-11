import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCalendar extends StatefulWidget {
   const MonthCalendar({Key? key}) : super(key: key);

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {

  late _MeetingDataSource _events;

  @override
  void initState() {
    super.initState();
    _events = _MeetingDataSource(_getAppointments());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 537.h,
      child: SfCalendar(
        view: CalendarView.month,
        showNavigationArrow: true,
        cellBorderColor: Colors.transparent,
        todayHighlightColor: Colors.transparent,
        dataSource: _events,
        todayTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
            fontFamily: "Poppins"
        ),
        selectionDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.buttonColor,
          backgroundBlendMode: BlendMode.modulate
        ),
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
            color: AppColors.buttonColor,
            fontSize: 16.sp,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500
          ),
        ),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
            color: Get.isDarkMode ? AppColors.darkBlue3 : AppColors.lightIcon,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 13.sp
          )
        ),
        monthViewSettings: MonthViewSettings(
          agendaViewHeight: 320.h,
          showAgenda: true,
          numberOfWeeksInView: 6,
          agendaStyle: AgendaStyle(
            dayTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                fontFamily: "Poppins"
            ),
            dateTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.subTitleColor,
                fontFamily: "Poppins"
            ),
            appointmentTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: Colors.white,
              fontFamily: "Poppins"
          ),
          ),
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontFamily: "Poppins"
            ),
            leadingDatesTextStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
                fontFamily: "Poppins"
            ),
            trailingDatesTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
                color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
              fontFamily: "Poppins"
            )
          )
        ),
      ),
    );
  }

  /// Method that creates the collection the data source for calendar, with
  /// required information.
  List<_Meeting> _getAppointments() {

    final List<_Meeting> meetings = <_Meeting>[];

    meetings.add(_Meeting(
        AppStrings.taskDesc,
        '',
        '',
        null,
        DateTime(2023,05,11,12,30),
        DateTime(2023,05,11,1,30),
        AppColors.orange,
        false,
        '',
        '',
        ''));

    meetings.add(_Meeting(
        AppStrings.taskDesc,
        '',
        '',
        null,
        DateTime(2023,05,15,12,30),
        DateTime(2023,05,15,1,30),
        AppColors.orange,
        false,
        '',
        '',
        ''));

    meetings.add(_Meeting(
        AppStrings.taskDesc,
        '',
        '',
        null,
        DateTime(2023,05,15,2,30),
        DateTime(2023,05,15,3,30),
        AppColors.blue,
        false,
        '',
        '',
        ''));
    return meetings;
  }
}

/// An object to set the appointment collection data source to collection, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<_Meeting> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String? getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String? getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  String? getRecurrenceRule(int index) {
    return source[index].recurrenceRule;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class _Meeting {
  _Meeting(
      this.eventName,
      this.organizer,
      this.contactID,
      this.capacity,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.startTimeZone,
      this.endTimeZone,
      this.recurrenceRule);

  String eventName;
  String? organizer;
  String? contactID;
  int? capacity;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? startTimeZone;
  String? endTimeZone;
  String? recurrenceRule;
}
