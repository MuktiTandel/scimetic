import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/energy_management/element/energy_month_graph.dart';
import 'package:scimetic/feature/energy_management/element/energy_week_graph.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';

class EnergyManagementController extends GetxController {

  RxBool isTemHour = true.obs;
  RxBool isTemWeek = false.obs;
  RxBool isTemMonth = false.obs;

  RxBool isElectricalHour = true.obs;
  RxBool isElectricalWeek = false.obs;
  RxBool isElectricalMonth = false.obs;

  RxBool isVoltageHour = true.obs;
  RxBool isVoltageWeek = false.obs;
  RxBool isVoltageMonth = false.obs;

  RxDouble currentRunTime = 60.0.obs;
  RxDouble serviceRunTime = 30.0.obs;
  RxDouble totalRunTime = 70.0.obs;

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
    WeekData(AppStrings.monday, 24, 26, 28),
    WeekData(AppStrings.tuesday, 22, 26, 28),
    WeekData(AppStrings.wednesday, 23, 25, 27),
    WeekData(AppStrings.thursday, 22, 26, 27),
    WeekData(AppStrings.friday, 22, 25, 27),
    WeekData(AppStrings.saturday, 24, 27, 29),
    WeekData(AppStrings.sunday, 25, 27, 29),
  ];

  List<MonthGraphModel> temperatureMonthData = [
    MonthGraphModel(0, 22, 24, 26),
    MonthGraphModel(5, 22, 24, 26),
    MonthGraphModel(10, 23, 25, 27),
    MonthGraphModel(15, 23, 25,27),
    MonthGraphModel(20, 24, 26, 28),
    MonthGraphModel(25, 25, 27, 28),
    MonthGraphModel(31, 26, 28, 30)
  ];

  List<HourData> electricalLoadHourData = [
    HourData(0, 85),
    HourData(2, 85),
    HourData(4, 85),
    HourData(6, 86),
    HourData(8, 86),
    HourData(10, 86),
    HourData(12, 87),
    HourData(14, 87),
    HourData(16, 86),
    HourData(18, 86),
    HourData(20, 86),
    HourData(22, 85),
    HourData(24, 85)
  ];

  List<WeekData> electricalLoadWeekData = [
    WeekData(AppStrings.monday, 82, 84, 86),
    WeekData(AppStrings.tuesday, 82, 84, 86),
    WeekData(AppStrings.wednesday, 83, 85, 87),
    WeekData(AppStrings.thursday, 83, 85, 87),
    WeekData(AppStrings.friday, 84, 86, 88),
    WeekData(AppStrings.saturday, 83, 85, 87),
    WeekData(AppStrings.sunday, 82, 84, 86),
  ];

  List<MonthGraphModel> electricalLoadMonthData = [
    MonthGraphModel(0, 82, 84, 86),
    MonthGraphModel(5, 83, 85, 86),
    MonthGraphModel(10, 84, 86, 87),
    MonthGraphModel(15, 85, 87,88),
    MonthGraphModel(20, 86, 88, 89),
    MonthGraphModel(25, 84, 86, 87),
    MonthGraphModel(31, 82, 84, 85)
  ];

  List<HourData> voltageHourData = [
    HourData(0, 710),
    HourData(2, 720),
    HourData(4, 730),
    HourData(6, 740),
    HourData(8, 750),
    HourData(10, 760),
    HourData(12, 750),
    HourData(14, 740),
    HourData(16, 730),
    HourData(18, 720),
    HourData(20, 710),
    HourData(22, 720),
    HourData(24, 730)
  ];

  List<WeekData> voltageWeekData = [
    WeekData(AppStrings.monday, 710, 740, 760),
    WeekData(AppStrings.tuesday, 720, 730, 740),
    WeekData(AppStrings.wednesday, 730, 740, 750),
    WeekData(AppStrings.thursday, 740, 750, 760),
    WeekData(AppStrings.friday, 730, 760, 780),
    WeekData(AppStrings.saturday, 720, 770, 790),
    WeekData(AppStrings.sunday, 710, 780, 800),
  ];

  List<MonthGraphModel> voltageMonthData = [
    MonthGraphModel(0, 710, 740, 760),
    MonthGraphModel(5, 720, 730, 740),
    MonthGraphModel(10, 730, 740, 750),
    MonthGraphModel(15, 740, 750,760),
    MonthGraphModel(20, 730, 760, 780),
    MonthGraphModel(25, 720, 770, 790),
    MonthGraphModel(31, 710, 780, 800)
  ];

}