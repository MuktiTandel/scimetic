import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthGraph2 extends StatelessWidget {
  const MonthGraph2({
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
  final List<MonthGraphModel> dataList;
  final String format;
  final Color graphColor1;

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
          maximumLabels: 1,
          labelStyle: TextStyle(
            color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
            fontSize: 10.h,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
        primaryXAxis: NumericAxis(
          // visibleMinimum: 1,
          //  visibleMaximum: 26.6.w,
            minimum: 1,
            maximum: 31,
            interval: 2,
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
            isVisible: true,
            title: AxisTitle(
              text: "March",
              textStyle:  TextStyle(
                  color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
                  fontSize: 10.h,
                  fontFamily: "Poppins"
              ),
            )
        ),
        series: <ChartSeries>[
          SplineAreaSeries<MonthGraphModel, double>(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor, graphColor.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (MonthGraphModel data, _) => data.x,
              yValueMapper: (MonthGraphModel data,_) => data.y1
          ),
          SplineAreaSeries<MonthGraphModel, double>(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor1, graphColor1.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (MonthGraphModel data, _) => data.x,
              yValueMapper: (MonthGraphModel data,_) => data.y
          ),
        ],
        tooltipBehavior: TooltipBehavior(
            enable: true,
            color: Colors.white,
            canShowMarker: true,
            elevation: 15,
            shadowColor: Colors.black,
            builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex ) {
              return Container(
                width: 82.w,
                height: 21.h,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:  [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1.0,
                          blurRadius: 5,
                          offset: const Offset(1.0, 1.0)
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset:  Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    CustomText(
                      text: data.x.toString(),
                      fontSize: 12.sp,
                    ),
                    VerticalDivider(thickness: 1.w, color: AppColors.gray, ),
                    CustomText(
                      text: data.y.toString(),
                      fontSize: 12.sp,
                      color: graphColor1,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}

class MonthGraphModel {

  final double x;
  final double y;
  final double y1;

  MonthGraphModel(
      this.x,
      this.y,
      this.y1);
}
