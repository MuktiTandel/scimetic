import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';

import 'week_day.dart';

class GanttChartDefaultDayHeader extends StatelessWidget {
  static const defaultColor = Colors.black;
  static const defaultBackgroundColor = Colors.white;
  static const defaultHolidayColor = Colors.white;
  static final defaultHolidayBackgroundColor = Colors.grey.shade800;

  final Color? color;
  final Color? backgroundColor;
  final BoxBorder? border;
  final WidgetBuilder? widgetBuilder;

  const GanttChartDefaultDayHeader({
    Key? key,
    required this.date,
    required this.isHoliday,
    this.color,
    this.backgroundColor,
    this.border,
    this.widgetBuilder,
  }) : super(key: key);

  final DateTime date;
  final bool isHoliday;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widgetBuilder?.call(context) ?? _defaultChild(context),
    );
  }

  // Color _defaultColor(bool isHoliday) =>
  //     isHoliday ? defaultHolidayColor : defaultColor;
  //
  // Color _defaultBackgroundColor(bool isHoliday) => defaultBackgroundColor;
  //
  // BoxBorder get _defaultBorder => const BorderDirectional(
  //       bottom: BorderSide(),
        // start: BorderSide(),
      // );

  Widget _defaultChild(BuildContext context) => Center(
        child: Column(
          children: [
            CustomText(
                text: WeekDay.fromIntWeekday(date.weekday).symbol,
              color: AppColors.lightIcon,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            CustomText(
                text: '${date.day}',
              color: AppColors.subTitleColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        )/*Text(
          '${WeekDay.fromIntWeekday(date.weekday).symbol}\n${date.day}',
          style: TextStyle(color: color),
        )*/,
      );
}
