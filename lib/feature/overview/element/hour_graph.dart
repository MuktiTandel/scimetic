import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HourGraph extends StatefulWidget {
  const HourGraph({
    Key? key,
    required this.minY,
    required this.maxY,
    required this.graphColor,
    required this.dataList,
    required this.format,
    this.data,
    this.dData,
    this.colors,
  }) : super(key: key);

  final double minY;
  final double maxY;
  final Color graphColor;
  final List<Map<String, dynamic>>? data;
  final List<String>? dData;
  final List<Color>? colors;
  final List<HourData> dataList;
  final String format;

  @override
  State<HourGraph> createState() => _HourGraphState();
}

class _HourGraphState extends State<HourGraph> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: Get.width,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0),
        plotAreaBorderColor: Colors.transparent,
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(
              width: 1.w,
              dashArray: const [7, 7],
              color: Get.isDarkMode
                  ? Colors.white38
                  : AppColors.subTitleColor.withOpacity(0.3)),
          axisLine: const AxisLine(color: Colors.transparent, width: 0),
          labelFormat: '{value}${widget.format}',
          labelPosition: ChartDataLabelPosition.inside,
          labelAlignment: LabelAlignment.end,
          plotOffset: 20,
          minimum: widget.minY,
          maximum: widget.maxY,
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
          axisLine: const AxisLine(width: 0),
          labelStyle: TextStyle(
              color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
              fontSize: 10.h,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),
          //  title: AxisTitle(
          //    text: "07.03.2021",
          //    textStyle:  TextStyle(
          //        color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          //        fontSize: 10.h,
          //      fontFamily: "Poppins"
          //    ),
          // )
        ),
        // series: _getDefaultAreaSeries(),
        series: <ChartSeries>[
          AreaSeries<Map<String, dynamic>, DateTime>(
            dataSource: widget.data ?? [],
            opacity: 0.7,
            borderColor: widget.colors![0],
            borderWidth: 0.5,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.colors![0].withOpacity(0.3),
                  widget.colors![0].withOpacity(0.3),
                ]),
            xValueMapper: (Map<String, dynamic> point, _) => point['x'],
            yValueMapper: (Map<String, dynamic> point, _) =>
                (widget.dData!.length == 0)
                    ? 0
                    : double.parse(point[widget.dData![0]] ?? 0.toString()),
            name: (widget.dData!.length == 0) ? "" : widget.dData![0],
          ),
          AreaSeries<Map<String, dynamic>, DateTime>(
            dataSource: widget.data ?? [],
            opacity: 0.7,
            borderColor: widget.colors![1],
            borderWidth: 0.5,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // widget.colors![1],
                  widget.colors![1].withOpacity(0.3),
                  widget.colors![1].withOpacity(0.3),
                ]),
            xValueMapper: (Map<String, dynamic> point, _) => point['x'],
            yValueMapper: (Map<String, dynamic> point, _) =>
                (widget.dData!.length == 0)
                    ? 0
                    : double.parse(point[widget.dData![1]] ?? 0.toString()),
            name: (widget.dData!.length == 0)
                ? ""
                : widget.dData![1], // Legend label
          ),
          //   AreaSeries<Map<String, dynamic>, DateTime>(
          //     dataSource: widget.data ?? [],
          //     opacity: 0.7,
          //     color: widget.colors![2],
          //     borderColor: widget.colors![0],
          //     xValueMapper: (Map<String, dynamic> point, _) => point['x'],
          //     yValueMapper: (Map<String, dynamic> point, _) =>
          //         double.parse(point[widget.dData![2]] ?? 0.toString()),
          //     name: widget.dData![2], // Legend label
          //   ),
        ],
      ),
    );
  }

  List<AreaSeries<HourData, DateTime>> _getDefaultAreaSeries() {
    return <AreaSeries<HourData, DateTime>>[
      AreaSeries<HourData, DateTime>(
        dataSource: widget.dataList,
        opacity: 0.7,
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [widget.graphColor, widget.graphColor.withOpacity(0.5)]),
        xValueMapper: (HourData sales, _) => sales.x as DateTime,
        yValueMapper: (HourData sales, _) => sales.y,
      ),
    ];
  }
}

class HourData {
  HourData(this.x, this.y);
  final DateTime x;
  final double y;
}

class HourData2 {
  HourData2(this.x, this.y);
  final DateTime x;
  final List y;
}
