import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthGraph extends StatelessWidget {
  const MonthGraph({
    Key? key,
    required this.minY,
    required this.maxY,
    required this.graphColor,
    required this.dataList,
    required this.format
  }) : super(key: key);

  final double minY;
  final double maxY;
  final Color graphColor;
  final List<MonthData> dataList;
  final String format;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: Get.width,
      child: SfCartesianChart(
        margin: EdgeInsets.only(right: 8.w),
        plotAreaBorderColor: Colors.transparent,
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(
              width: 0
          ),
          majorGridLines:  MajorGridLines(
              width: 1.w,
              dashArray: const [7,7],
              color: Get.isDarkMode
                  ? Colors.white38 : AppColors.subTitleColor.withOpacity(0.3)
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
          maximumLabels: 5,
          dateFormat: DateFormat("HH:mm"),
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
          //  title: AxisTitle(
          //    text: "07.03.2021",
          //    textStyle:  TextStyle(
          //        color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          //        fontSize: 10.h,
          //      fontFamily: "Poppins"
          //    ),
          // )
        ),
        series: <ChartSeries>[
          SplineAreaSeries<MonthData, DateTime>(
            borderWidth: 3.w,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor, graphColor.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (MonthData data, _) => data.x,
              yValueMapper: (MonthData data,_) => data.y,
            borderColor: graphColor,
          )
        ],
      ),
    );
  }
}

class MonthData {
  MonthData(this.x, this.y);
  final DateTime x;
  final double y;
}
