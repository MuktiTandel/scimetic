import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:scimetic/feature/overview/element/month_graph.dart';
import 'package:scimetic/feature/overview/element/week_graph.dart';

class OverviewController extends GetxController {

  RxBool isTemperature = false.obs;
  RxBool isElectricalLoad = false.obs;
  RxBool isCo2 = false.obs;
  RxBool isLightning = false.obs;
  RxBool isVdp = false.obs;

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

  RxBool isVdpHour = true.obs;
  RxBool isVdpWeek = false.obs;
  RxBool isVdpMonth = false.obs;

  List<HourData> temperatureHourDataList = [
    HourData(0, 22.5),
    HourData(1, 22.5),
    HourData(2, 22.5),
    HourData(3, 23),
    HourData(4, 23),
    HourData(5, 23),
    HourData(6, 23),
    HourData(7, 23),
    HourData(8, 23.5),
    HourData(9, 23.5),
    HourData(10, 23.5),
    HourData(11, 23.5),
    HourData(12, 23.5),
    HourData(13, 24),
    HourData(14, 24),
    HourData(15, 24),
    HourData(16, 24),
    HourData(17, 23.5),
    HourData(18, 23.5),
    HourData(19, 23.5),
    HourData(20, 23.5),
    HourData(21, 23.5),
    HourData(22, 23),
    HourData(23, 23),
    HourData(24, 23),
    HourData(24.5, 23),
    HourData(24.5, 23),
  ];

  List<WeekData> temperatureWeekDataList = [
    WeekData(AppStrings.monday, 24, 26),
    WeekData(AppStrings.tuesday, 22, 26),
    WeekData(AppStrings.wednesday, 23, 25),
    WeekData(AppStrings.thursday, 22, 26),
    WeekData(AppStrings.friday, 22, 25),
    WeekData(AppStrings.saturday, 24, 27),
    WeekData(AppStrings.sunday, 25, 27),
  ];

  List<MonthData> temperatureMonthDataList = [
    MonthData(0, 22),
    MonthData(5, 24),
    MonthData(10, 24),
    MonthData(15, 25),
    MonthData(20, 25),
    MonthData(25, 24),
    MonthData(30, 24),
    MonthData(31, 24),
  ];

  List<WeekData> electricalWeekDataList = [
    WeekData(AppStrings.monday, 85, 86),
    WeekData(AppStrings.tuesday, 84, 86),
    WeekData(AppStrings.wednesday, 85, 87),
    WeekData(AppStrings.thursday, 84, 86),
    WeekData(AppStrings.friday, 83, 87),
    WeekData(AppStrings.saturday, 84, 89),
    WeekData(AppStrings.sunday, 85, 88),
  ];

  List<MonthData> electricalMonthDataList = [
    MonthData(0, 84),
    MonthData(5, 84),
    MonthData(10, 85),
    MonthData(15, 85),
    MonthData(20, 86),
    MonthData(25, 86),
    MonthData(30, 84),
    MonthData(31, 84),
  ];

  List<HourData> electricalDataList = [
    HourData(0, 83),
    HourData(2, 83),
    HourData(4, 83),
    HourData(6, 83),
    HourData(8, 84),
    HourData(10, 84),
    HourData(12, 84),
    HourData(14, 83),
    HourData(16, 83),
    HourData(18, 83),
    HourData(20, 84),
    HourData(22, 84),
    HourData(24, 84),
    HourData(24.5, 84),
  ];

  List<HourData> co2DataList = [
    HourData(0, 750),
    HourData(2, 750),
    HourData(4, 750),
    HourData(6, 740),
    HourData(8, 740),
    HourData(10, 740),
    HourData(12, 740),
    HourData(14, 760),
    HourData(16, 760),
    HourData(18, 760),
    HourData(20, 760),
    HourData(22, 750),
    HourData(24, 750),
    HourData(24.5, 750),
  ];

  List<WeekData> co2WeekDataList = [
    WeekData(AppStrings.monday, 750, 770),
    WeekData(AppStrings.tuesday, 760, 780),
    WeekData(AppStrings.wednesday, 750, 770),
    WeekData(AppStrings.thursday, 740, 760),
    WeekData(AppStrings.friday, 730, 750),
    WeekData(AppStrings.saturday, 740, 760),
    WeekData(AppStrings.sunday, 740, 765),
  ];

  List<MonthData> co2MonthDataList = [
    MonthData(0, 750),
    MonthData(5, 750),
    MonthData(10, 760),
    MonthData(15, 760),
    MonthData(20, 780),
    MonthData(25, 780),
    MonthData(30, 760),
    MonthData(31, 760),
  ];

  List<HourData> lightningDataList = [
    HourData(0, 40),
    HourData(1, 40),
    HourData(2, 40),
    HourData(3, 40),
    HourData(4, 40),
    HourData(5, 40),
    HourData(6, 41.5),
    HourData(7, 41.5),
    HourData(8, 41.5),
    HourData(9, 41.5),
    HourData(10, 41.5),
    HourData(11, 41),
    HourData(12, 41),
    HourData(13, 41),
    HourData(14, 41),
    HourData(15, 41),
    HourData(16, 41),
    HourData(17, 41),
    HourData(18, 40),
    HourData(19, 40),
    HourData(20, 40),
    HourData(21, 40),
    HourData(22, 40),
    HourData(23, 42),
    HourData(24, 42),
    HourData(24.5, 42),
    HourData(24.5, 42),
  ];

  List<WeekData> lightningWeekDataList = [
    WeekData(AppStrings.monday, 40, 42),
    WeekData(AppStrings.tuesday, 41, 43),
    WeekData(AppStrings.wednesday, 42, 44),
    WeekData(AppStrings.thursday, 43, 46),
    WeekData(AppStrings.friday, 44, 48),
    WeekData(AppStrings.saturday, 42, 44),
    WeekData(AppStrings.sunday, 41, 42),
  ];

  List<MonthData> lightningMonthDataList = [
    MonthData(0, 42),
    MonthData(5, 43),
    MonthData(10, 44),
    MonthData(15, 45),
    MonthData(20, 46),
    MonthData(25, 42),
    MonthData(30, 41),
    MonthData(31, 40),
  ];

  List<HourData> vdpDataList = [
    HourData(0, 0.95),
    HourData(2, 0.95),
    HourData(4, 0.95),
    HourData(6, 0.95),
    HourData(8, 0.98),
    HourData(10, 0.98),
    HourData(12, 0.98),
    HourData(14, 0.95),
    HourData(16, 0.95),
    HourData(18, 0.9),
    HourData(20, 0.9),
    HourData(22, 0.9),
    HourData(24, 0.9)
  ];

  List<WeekData> vdpWeekDataList = [
    WeekData(AppStrings.monday, 0.94, 0.96),
    WeekData(AppStrings.tuesday, 0.94, 0.96),
    WeekData(AppStrings.wednesday, 0.86, 0.95),
    WeekData(AppStrings.thursday, 0.86, 0.98),
    WeekData(AppStrings.friday, 0.86, 0.98),
    WeekData(AppStrings.saturday, 0.86, 0.9),
    WeekData(AppStrings.sunday, 0.86, 0.9),
  ];

  List<MonthData> vdpMonthDataList = [
    MonthData(0, 0.95),
    MonthData(5, 0.96),
    MonthData(10, 0.97),
    MonthData(15, 0.98),
    MonthData(20, 0.99),
    MonthData(25, 0.96),
    MonthData(30, 0.94),
    MonthData(31, 0.93),
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