import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:week_of_year/week_of_year.dart';

class GanttChartDefaultWeekHeader extends StatelessWidget {
  static const defaultColor = Colors.white;
  static final defaultBackgroundColor = Colors.blue.shade900;

  final Color? color;
  final Color? backgroundColor;
  final BoxBorder? border;
  final WidgetBuilder? widgetBuilder;

  const GanttChartDefaultWeekHeader({
    Key? key,
    required this.weekDate,
    this.color,
    this.backgroundColor,
    this.border,
    this.widgetBuilder,
  }) : super(key: key);
  final DateTime weekDate;

  int get weekNumberWithinThisYear => weekDate.weekOfYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      // padding: const EdgeInsetsDirectional.only(start: 8, top: 1, bottom: 1),
      // decoration: BoxDecoration(
      //   color: backgroundColor ?? defaultBackgroundColor,
      //   border: border ?? _defaultBorder,
      // ),
      child: widgetBuilder?.call(context) ?? _defaultChild(context),
    );
  }

  BoxBorder get _defaultBorder => const BorderDirectional(
        start: BorderSide(),
        bottom: BorderSide(),
      );

  Widget _defaultChild(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      String txt;
      if (constraints.maxWidth < 50) {
        txt = weekDate.month.toString();
      } else if (constraints.maxWidth < 7 * 20) {
        txt = '${weekDate.month}-${weekDate.year % 100}';
      } else {
        txt = DateFormat("MMMM, y").format(weekDate);
      }

      return CustomText(
          text: txt,
        color: AppColors.buttonColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );
    },
  );
}
