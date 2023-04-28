import 'package:get/get.dart';
import 'package:scimetic/core/elements/hour_graph.dart';

class OverviewController extends GetxController {

  RxBool isTemHour = true.obs;
  RxBool isTemWeek = false.obs;
  RxBool isTemMonth = false.obs;

  RxBool isLightHour = true.obs;
  RxBool isLightWeek = false.obs;
  RxBool isLightMonth = false.obs;

  RxBool isElectricHour = true.obs;
  RxBool isElectricWeek = false.obs;
  RxBool isElectricMonth = false.obs;

  RxBool isCo2Hour = true.obs;
  RxBool isCo2Week = false.obs;
  RxBool isCo2Month = false.obs;

  List<ChartData> temperatureDataList = [
    ChartData(0, 22.5),
    ChartData(1, 22.5),
    ChartData(2, 22.5),
    ChartData(3, 23),
    ChartData(4, 23),
    ChartData(5, 23),
    ChartData(6, 23),
    ChartData(7, 23),
    ChartData(8, 23.5),
    ChartData(9, 23.5),
    ChartData(10, 23.5),
    ChartData(11, 23.5),
    ChartData(12, 23.5),
    ChartData(13, 24),
    ChartData(14, 24),
    ChartData(15, 24),
    ChartData(16, 24),
    ChartData(17, 23.5),
    ChartData(18, 23.5),
    ChartData(19, 23.5),
    ChartData(20, 23.5),
    ChartData(21, 23.5),
    ChartData(22, 23),
    ChartData(23, 23),
    ChartData(24, 23),
    ChartData(24.5, 23),
    ChartData(24.5, 23),
  ];

  List<ChartData> lightningDataList = [
    ChartData(0, 40),
    ChartData(1, 40),
    ChartData(2, 40),
    ChartData(3, 40),
    ChartData(4, 40),
    ChartData(5, 40),
    ChartData(6, 41.5),
    ChartData(7, 41.5),
    ChartData(8, 41.5),
    ChartData(9, 41.5),
    ChartData(10, 41.5),
    ChartData(11, 41),
    ChartData(12, 41),
    ChartData(13, 41),
    ChartData(14, 41),
    ChartData(15, 41),
    ChartData(16, 41),
    ChartData(17, 41),
    ChartData(18, 40),
    ChartData(19, 40),
    ChartData(20, 40),
    ChartData(21, 40),
    ChartData(22, 40),
    ChartData(23, 42),
    ChartData(24, 42),
    ChartData(24.5, 42),
    ChartData(24.5, 42),
  ];

  List<ChartData> electricalDataList = [
    ChartData(0, 83),
    ChartData(2, 83),
    ChartData(4, 83),
    ChartData(6, 83),
    ChartData(8, 84),
    ChartData(10, 84),
    ChartData(12, 84),
    ChartData(14, 83),
    ChartData(16, 83),
    ChartData(18, 83),
    ChartData(20, 84),
    ChartData(22, 84),
    ChartData(24, 84),
    ChartData(24.5, 84),
  ];

  List<ChartData> co2DataList = [
    ChartData(0, 750),
    ChartData(2, 750),
    ChartData(4, 750),
    ChartData(6, 740),
    ChartData(8, 740),
    ChartData(10, 740),
    ChartData(12, 740),
    ChartData(14, 760),
    ChartData(16, 760),
    ChartData(18, 760),
    ChartData(20, 760),
    ChartData(22, 750),
    ChartData(24, 750),
    ChartData(24.5, 750),
  ];

}

class ChartSampleData {

  double x;
  double y;

  ChartSampleData({
    required this.x,
    required this.y
  });
}