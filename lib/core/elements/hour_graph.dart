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
    required this.dataList
  }) : super(key: key);

  final double minY;
  final double maxY;
  final Color graphColor;
  final List<ChartData> dataList;

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
            majorGridLines: const MajorGridLines(
                width: 1,
                dashArray: [10,10]
            ),
            axisLine: const AxisLine(
                color: Colors.transparent,
                width: 0
            ),
            labelPosition: ChartDataLabelPosition.inside,
            labelAlignment: LabelAlignment.end,
             plotOffset: 20,
            minimum: minY,
            maximum: maxY,
            maximumLabels: 1,
          labelStyle: TextStyle(
              color: AppColors.subTitleColor,
              fontSize: 10.h,
              fontWeight: FontWeight.w500
          ),
          // axisLabelFormatter: ( AxisLabelRenderDetails axisLabelRenderDetails){
          //     return ChartAxisLabel("21°C", TextStyle(
          //         color: AppColors.subTitleColor,
          //         fontSize: 10.h,
          //       fontWeight: FontWeight.w500
          //     ),);
          // }
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
              color: AppColors.subTitleColor,
              fontSize: 10.h,
            fontWeight: FontWeight.w500
          ),
          title: AxisTitle(
            text: "07.03.2021",
            textStyle:  TextStyle(
                color: AppColors.subTitleColor,
                fontSize: 10.h
            ),
        )
        ),
        series: <ChartSeries>[
          SplineAreaSeries<ChartData, double>(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [graphColor, graphColor.withOpacity(0)]
              ),
              dataSource: dataList,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data,_) => data.y
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
