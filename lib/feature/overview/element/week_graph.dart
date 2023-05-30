import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeekGraph extends StatelessWidget {
  const WeekGraph({
    Key? key,
    required this.minY,
    required this.maxY,
    required this.graphColor,
    required this.dataList,
    required this.format,
    required this.graphColor1,
  }) : super(key: key);

  final double minY;
  final double maxY;
  final Color graphColor;
  final List<WeekData> dataList;
  final String format;
  final Color graphColor1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: Get.width,
      child: SfCartesianChart(
         margin: EdgeInsets.only(right: 10.w),
        plotAreaBorderColor: Colors.transparent,
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(
              width: 0
          ),
          majorGridLines:  MajorGridLines(
              width: 1.w,
              dashArray: const [7,7],
              color: Get.isDarkMode ? Colors.white38 : AppColors.subTitleColor.withOpacity(0.3)
          ),
          axisLine: const AxisLine(
              color: Colors.transparent,
              width: 0
          ),
          labelFormat: '{value}$format',
          labelPosition: ChartDataLabelPosition.inside,
          labelAlignment: LabelAlignment.end,
          plotOffset: 20,
          minimum: minY,
          maximum: maxY,
          maximumLabels: 2,
          labelStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            fontSize: 10.h,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        primaryXAxis: DateTimeAxis(
            // intervalType: DateTimeIntervalType.hours,
            dateFormat: DateFormat("HH:mm"),
            maximumLabels: 5,
            majorGridLines: const MajorGridLines(
              width: 0,
            ),
            majorTickLines: const MajorTickLines(width: 0),
            axisLine: const AxisLine(
                width: 0
            ),
            labelStyle: TextStyle(
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontSize: 10.h,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins"
            ),
            // title: AxisTitle(
            //   text: "01.03 - 07.03",
            //   textStyle:  TextStyle(
            //       color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            //       fontSize: 10.h,
            //       fontFamily: "Poppins"
            //   ),
            // )
        ),
        series: <ChartSeries>[
          SplineAreaSeries<WeekData, DateTime>(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor, graphColor.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (WeekData data, _) => data.x,
              yValueMapper: (WeekData data,_) => data.y
          ),
          // SplineAreaSeries<WeekData, String>(
          //      gradient: LinearGradient(
          //          begin: Alignment.topCenter,
          //          end: Alignment.bottomCenter,
          //          colors: [graphColor1, graphColor1.withOpacity(0)]
          //      ),
          //      dataSource: dataList,
          //      xValueMapper: (WeekData data, _) => data.x,
          //      yValueMapper: (WeekData data,_) => data.y
          //  ),
        ],
      ),
    );
  }
}

class WeekData {
  WeekData(
      this.x,
      this.y,);
  final DateTime x;
  final double y;
}
