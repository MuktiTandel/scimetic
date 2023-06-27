import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:scimetic/core/elements/custom_text.dart';

class DonutChart extends StatefulWidget {
  final String plantedDate;
  final String harvestDate;
  final int id;

  const DonutChart({super.key, required this.plantedDate, required this.harvestDate, required this.id});

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  final double innerRadius = 75;
  final double cornerRadius = 2;
  final double padAngle = 0.02;
  final List<Color> colors = [Colors.blue, Colors.purple, Colors.green, Colors.orange];

  Map<String, num> data = {'germination': 0, 'seedling': 0, 'vegetative': 0, 'flowering': 0};
  int totalPeriod = 0;
  int currentDays = 0;

  @override
  void initState() {
    super.initState();
    renderDonut();
  }

  @override
  void didUpdateWidget(DonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.plantedDate != oldWidget.plantedDate || widget.harvestDate != oldWidget.harvestDate) {
      renderDonut();
    }
  }

   double width = 272;
   double height = 272;
   double margin = 40;
   double radius = 0.0;

  int percentGrowth = 0;

  List chartPaths = [];

  void renderDonut() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final plantedAt = dateFormat.parse(widget.plantedDate);
    final harvestAt = dateFormat.parse(widget.harvestDate);
    final now = DateTime.now();

    radius = math.min(width, height) / 2 - margin;

    final days = harvestAt.difference(plantedAt).inDays + 1;
    final currentDay = now.difference(plantedAt).inDays + 1;
    setState(() {
      totalPeriod = days;
      currentDays = currentDay;
    });

    final data = graphData();
    final angles = resolveAngles(data, totalPeriod);

    setState(() {
      this.data = data;
    });

    // Remove if existing svg
    // TODO: Remove existing SVG (if needed)

    final num totalSpent = data.values.reduce((prev, curr) => prev + curr);
    percentGrowth = ((totalSpent / totalPeriod) * 100).ceil().clamp(0, 100);

    chartPaths = data.entries.map((entry) {
      final key = entry.key;
      // final value = entry.value.toDouble();
      // final color = colors[data.keys.toList().indexOf(key) % colors.length];
      final startAngle = angles[key]!['startAngle']!;
      final endAngle = angles[key]!['endAngle']!;
      return Path()
        ..arcTo(
          Rect.fromCircle(center: Offset(width / 2, height / 2), radius: radius),
          startAngle,
          endAngle - startAngle,
          false,
        )
        ..relativeArcToPoint(
          const Offset(0, 0),
          radius: Radius.circular(innerRadius),
        )
        ..arcTo(
          Rect.fromCircle(center: Offset(width / 2, height / 2), radius: innerRadius),
          endAngle,
          startAngle - endAngle,
          false,
        )
        ..relativeArcToPoint(
          const Offset(0, 0),
          radius: Radius.circular(innerRadius),
        )
        ..close()
        ..fillType = PathFillType.nonZero
        ..shift(Offset(width / 2, height / 2))
        ..close();
    }).toList();

  }

  Map<String, num> graphData() {
    final Map<String, num> dataClone = Map.from(data);
    final Map<String, double> weightages = {
      'germination': (1 / 16) * totalPeriod,
      'seedling': (2 / 16) * totalPeriod,
      'vegetative': (4 / 16) * totalPeriod,
      'flowering': (9 / 16) * totalPeriod,
    };

    int remainingDays = currentDays;
    weightages.forEach((key, value) {
      if (remainingDays > 0) {
        dataClone[key] = (value - remainingDays) > 0 ? remainingDays : value;
        remainingDays = remainingDays - value.toInt();
      }
    });

    return dataClone;
  }

  Map<String, Map<String, double>> resolveAngles(Map<String, num> data, int totalPeriod) {
    final List<String> keys = data.keys.toList();
    final Map<String, Map<String, double>> angles = {};

    double startAngle = 0;
    double endAngle = 0;
    for (var key in keys) {
      startAngle = angles.isEmpty ? 0 : startAngle + (data[keys[keys.indexOf(key) - 1]]! / totalPeriod) * 2 * math.pi;
      endAngle = endAngle + (data[key]! / totalPeriod) * 2 * math.pi;
      angles[key] = {'startAngle': startAngle, 'endAngle': endAngle};
    }

    return angles;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 200.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: CustomText(
             text: '$percentGrowth%',
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'progress',
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.grey[700]),
            ),
          ),
          ...chartPaths.map((path) => CustomPaint(
            painter: ChartPainter(path: path, color: Colors.white),
          )),
          ...chartPaths.asMap().entries.map((entry) {
            final index = entry.key;
            final path = entry.value;
            final color = colors[index % colors.length];
            return CustomPaint(
              painter: ChartPainter(path: path, color: color),
            );
          }).toList(),
        ],
      ), // TODO: Replace with the chartWidget
    );
  }
}

class ChartPainter extends CustomPainter {
  final Path path;
  final Color color;

  ChartPainter({required this.path, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ChartPainter oldDelegate) => true;
}