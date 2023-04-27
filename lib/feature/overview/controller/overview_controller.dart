import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OverviewController extends GetxController {

  RxBool isHour = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;

  List<ChartSampleData> data = [
    ChartSampleData(x: 0, y: 22.5),
    ChartSampleData(x: 1, y: 22.5),
    ChartSampleData(x: 2, y: 22.5),
    ChartSampleData(x: 3, y: 22.5),
    ChartSampleData(x: 4, y: 24.5),
    ChartSampleData(x: 5, y: 24.5),
    ChartSampleData(x: 6, y: 23.5),
    ChartSampleData(x: 7, y: 23.5),
    ChartSampleData(x: 8, y: 22.5),
    ChartSampleData(x: 10, y: 22.5),
    ChartSampleData(x: 12, y: 22.5),
    ChartSampleData(x: 16, y: 24.5),
    ChartSampleData(x: 18, y: 24.5),
    ChartSampleData(x: 20, y: 22.5),
    ChartSampleData(x: 22, y: 20.5),
    ChartSampleData(x: 24, y: 22.5),
    ChartSampleData(x: 25, y: 22.5),
  ];

  List<ChartSeries<ChartSampleData, double>> getSeries() {
    return <ChartSeries<ChartSampleData, double>>[
      SplineAreaSeries<ChartSampleData, double>(
        dataSource: data,
        borderWidth: 2,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.orange, AppColors.orange.withOpacity(0)]
        ),
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.outer),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
    ];
  }

}

class ChartSampleData {

  double x;
  double y;

  ChartSampleData({
    required this.x,
    required this.y
  });
}