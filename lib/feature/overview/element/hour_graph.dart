import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HourGraph extends StatelessWidget {
  const HourGraph({
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
  final List<HourData> dataList;
  final String format;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 150.h,
      width: Get.width,
      child: SfCartesianChart(
        margin:const EdgeInsets.all(0),
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
            maximumLabels: 1,
          labelStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              fontSize: 10.h,
              fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(
            width: 0,
          ),
          majorTickLines: const MajorTickLines(width: 0),
          axisLine: const AxisLine(
              width: 0
          ),
          minimum: 0,
          maximum: 25,
          interval: 2,
          labelStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              fontSize: 10.h,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"
          ),
          title: AxisTitle(
            text: "07.03.2021",
            textStyle:  TextStyle(
                color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                fontSize: 10.h,
              fontFamily: "Poppins"
            ),
        )
        ),
        series: <ChartSeries>[
          SplineAreaSeries<HourData, double>(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor, graphColor.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (HourData data, _) => data.x,
              yValueMapper: (HourData data,_) => data.y
          )
        ],
      ),
    );
  }
}

class HourData {
  HourData(this.x, this.y);
  final double x;
  final double y;
}
