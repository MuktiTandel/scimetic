import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:scimetic/feature/overview/element/hour_graph2.dart';
import 'package:scimetic/feature/overview/element/month_graph2.dart';
import 'package:scimetic/feature/overview/element/week_graph2.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class GraphController extends GetxController {

  RxBool isHour = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;

  RxBool isGermination = true.obs;
  RxBool isSeedling = false.obs;
  RxBool isVegetative = false.obs;
  RxBool isFlowering = false.obs;

  DateRangePickerController plantedDate = DateRangePickerController();
  DateRangePickerController harvestDate = DateRangePickerController();

  RxString plantedDateValue = "".obs;
  RxString harvestDateValue = "".obs;

  RxString selectStage = AppStrings.germination.obs;

  final controller = Get.put(OverviewController());

  List<HourGraph1> temperatureHourData = [
    HourGraph1(0, 24, 26),
    HourGraph1(2, 24, 26),
    HourGraph1(4, 24, 26),
    HourGraph1(6, 25, 28),
    HourGraph1(8, 25, 28),
    HourGraph1(10, 25, 28),
    HourGraph1(12, 26, 29),
    HourGraph1(14, 26, 29),
    HourGraph1(16, 26, 29),
    HourGraph1(18, 23, 25),
    HourGraph1(20, 23, 25),
    HourGraph1(22, 23, 25),
    HourGraph1(24, 23, 25),
    HourGraph1(25, 23, 25),
  ];

  List<WeekGraphModel> temperatureWeekData = [
    WeekGraphModel(AppStrings.monday, 24, 26),
    WeekGraphModel(AppStrings.tuesday, 22, 26),
    WeekGraphModel(AppStrings.wednesday, 23, 25),
    WeekGraphModel(AppStrings.thursday, 22, 26),
    WeekGraphModel(AppStrings.friday, 22, 25),
    WeekGraphModel(AppStrings.saturday, 24, 27),
    WeekGraphModel(AppStrings.sunday, 25, 27),
  ];

  List<MonthGraphModel> temperatureMonthData = [
    MonthGraphModel(0, 22, 24),
    MonthGraphModel(5, 22, 24),
    MonthGraphModel(10, 23, 25),
    MonthGraphModel(15, 23, 25),
    MonthGraphModel(20, 24, 26),
    MonthGraphModel(25, 25, 27),
    MonthGraphModel(31, 26, 28)
  ];

  List<HourGraph1> electricalLoadHourData = [
    HourGraph1(0, 85, 87),
    HourGraph1(2, 85, 87),
    HourGraph1(4, 85, 87),
    HourGraph1(6, 86, 88),
    HourGraph1(8, 86, 88),
    HourGraph1(10, 86, 88),
    HourGraph1(12, 87, 89),
    HourGraph1(14, 87, 89),
    HourGraph1(16, 87, 89),
    HourGraph1(18, 86, 88),
    HourGraph1(20, 86, 88),
    HourGraph1(22, 85, 87),
    HourGraph1(24, 85, 87),
    HourGraph1(25, 85, 87),
  ];

  List<WeekGraphModel> electricalLoadWeekData = [
    WeekGraphModel(AppStrings.monday, 85, 87),
    WeekGraphModel(AppStrings.tuesday, 85, 87),
    WeekGraphModel(AppStrings.wednesday, 86, 88),
    WeekGraphModel(AppStrings.thursday, 86, 88),
    WeekGraphModel(AppStrings.friday, 87, 89),
    WeekGraphModel(AppStrings.saturday, 87, 89),
    WeekGraphModel(AppStrings.sunday, 85, 87),
  ];

  List<MonthGraphModel> electricalLoadMonthData = [
    MonthGraphModel(0, 85, 87),
    MonthGraphModel(5, 85, 87),
    MonthGraphModel(10, 86, 88),
    MonthGraphModel(15, 86, 88),
    MonthGraphModel(20, 87, 89),
    MonthGraphModel(25, 87, 89),
    MonthGraphModel(31, 85, 87)
  ];

  List<HourGraph1> co2HourData = [
    HourGraph1(0, 710, 730),
    HourGraph1(2, 720, 740),
    HourGraph1(4, 730, 750),
    HourGraph1(6, 740, 760),
    HourGraph1(8, 750, 770),
    HourGraph1(10, 770, 790),
    HourGraph1(12, 750, 770),
    HourGraph1(14, 740, 760),
    HourGraph1(16, 730, 750),
    HourGraph1(18, 720, 740),
    HourGraph1(20, 740, 760),
    HourGraph1(22, 740, 760),
    HourGraph1(24, 740, 760),
    HourGraph1(25, 740, 760),
  ];

  List<WeekGraphModel> co2WeekData = [
    WeekGraphModel(AppStrings.monday, 720, 730),
    WeekGraphModel(AppStrings.tuesday, 730, 750),
    WeekGraphModel(AppStrings.wednesday, 740, 770),
    WeekGraphModel(AppStrings.thursday, 750, 790),
    WeekGraphModel(AppStrings.friday, 730, 750),
    WeekGraphModel(AppStrings.saturday, 720, 730),
    WeekGraphModel(AppStrings.sunday, 710, 720),
  ];

  List<MonthGraphModel> co2MonthData = [
    MonthGraphModel(0, 750, 770),
    MonthGraphModel(5, 760, 780),
    MonthGraphModel(10, 770, 790),
    MonthGraphModel(15, 780, 800),
    MonthGraphModel(20, 750, 770),
    MonthGraphModel(25, 760, 780),
    MonthGraphModel(31, 720, 750)
  ];

  List<HourGraph1> lightningHourData = [
    HourGraph1(0, 42, 45),
    HourGraph1(2, 42, 45),
    HourGraph1(4, 42, 45),
    HourGraph1(6, 41, 43),
    HourGraph1(8, 41, 43),
    HourGraph1(10, 42, 45),
    HourGraph1(12, 42, 45),
    HourGraph1(14, 42, 45),
    HourGraph1(16, 40, 42),
    HourGraph1(18, 40, 42),
    HourGraph1(20, 40, 42),
    HourGraph1(22, 37, 39),
    HourGraph1(24, 37, 39),
    HourGraph1(25, 37, 39),
  ];

  List<WeekGraphModel> lightningWeekData = [
    WeekGraphModel(AppStrings.monday, 37, 39),
    WeekGraphModel(AppStrings.tuesday, 38, 40),
    WeekGraphModel(AppStrings.wednesday, 39, 41),
    WeekGraphModel(AppStrings.thursday, 40, 42),
    WeekGraphModel(AppStrings.friday, 41, 43),
    WeekGraphModel(AppStrings.saturday, 42, 44),
    WeekGraphModel(AppStrings.sunday, 43, 45),
  ];

  List<MonthGraphModel> lightningMonthData = [
    MonthGraphModel(0, 44, 47),
    MonthGraphModel(5, 42, 46),
    MonthGraphModel(10, 40, 42),
    MonthGraphModel(15, 37, 39),
    MonthGraphModel(20, 38, 40),
    MonthGraphModel(25, 39, 41),
    MonthGraphModel(31, 40, 42)
  ];

  List<HourGraph1> vdpHourData = [
    HourGraph1(0, 0.89, 0.92),
    HourGraph1(2, 0.89, 0.92),
    HourGraph1(4, 0.89, 0.92),
    HourGraph1(6, 0.91, 0.93),
    HourGraph1(8, 0.91, 0.93),
    HourGraph1(10, 0.93, 0.96),
    HourGraph1(12, 0.93, 0.96),
    HourGraph1(14, 0.93, 0.96),
    HourGraph1(16, 0.96, 0.99),
    HourGraph1(18, 0.96, 0.99),
    HourGraph1(20, 0.96, 0.99),
    HourGraph1(22, 1, 1.02),
    HourGraph1(24, 1, 1.02),
    HourGraph1(25, 1, 1.02),
  ];

  List<WeekGraphModel> vdpWeekData = [
    WeekGraphModel(AppStrings.monday, 0.95, 0.99),
    WeekGraphModel(AppStrings.tuesday, 1.0, 1.05),
    WeekGraphModel(AppStrings.wednesday, 1.02, 1.05),
    WeekGraphModel(AppStrings.thursday, 0.88, 0.90),
    WeekGraphModel(AppStrings.friday, 0.90, 0.93),
    WeekGraphModel(AppStrings.saturday, 0.94, 0.96),
    WeekGraphModel(AppStrings.sunday, 0.96, 0.99),
  ];

  List<MonthGraphModel> vdpMonthData = [
    MonthGraphModel(0, 0.87, 0.89),
    MonthGraphModel(5, 0.88, 0.90),
    MonthGraphModel(10, 0.89, 0.91),
    MonthGraphModel(15, 0.90, 0.92),
    MonthGraphModel(20, 0.92, 0.94),
    MonthGraphModel(25, 0.94, 0.96),
    MonthGraphModel(31, 0.96, 0.98)
  ];

  @override
  void onClose() {

    if ( controller.isTemperature.value == true ) {
      controller.isTemperature.value = false;
    } else if ( controller.isElectricalLoad.value == true ) {
      controller.isElectricalLoad.value = false;
    } else if ( controller.isCo2.value == true ) {
      controller.isCo2.value = false;
    } else if ( controller.isLightning.value == true ) {
      controller.isLightning.value = false;
    } else if ( controller.isVdp.value == true ) {
      controller.isVdp.value = false;
    }

    super.onClose();

  }

  title() {

    if ( controller.isTemperature.value == true ) {
      return AppStrings.temperature;
    } else if ( controller.isElectricalLoad.value == true ) {
      return AppStrings.electricalLoad;
    } else if ( controller.isCo2.value == true ) {
      return AppStrings.cO2;
    } else if ( controller.isLightning.value == true ) {
      return AppStrings.lightning;
    } else if ( controller.isVdp.value == true ) {
      return AppStrings.vpd;
    }

  }

  image() {
    if ( controller.isTemperature.value == true ) {
      return AppImages.menu_;
    } else if ( controller.isElectricalLoad.value == true ) {
      return AppImages.fillSettings;
    } else if ( controller.isCo2.value == true ) {
      return AppImages.horizontalMenu;
    } else if ( controller.isLightning.value == true ) {
      return AppImages.menu_;
    } else if ( controller.isVdp.value == true ) {
      return AppImages.horizontalMenu;
    }
  }

  value() {
    if ( controller.isTemperature.value == true ) {
      return "24";
    } else if ( controller.isElectricalLoad.value == true ) {
      return "85";
    } else if ( controller.isCo2.value == true ) {
      return "750";
    } else if ( controller.isLightning.value == true ) {
      return "40";
    } else if ( controller.isVdp.value == true ) {
      return "0.95";
    }
  }

  value_() {
    if ( controller.isTemperature.value == true ) {
      return "°C";
    } else if ( controller.isElectricalLoad.value == true ) {
      return "%";
    } else if ( controller.isCo2.value == true ) {
      return "ppm";
    } else if ( controller.isLightning.value == true ) {
      return "mol/m2day";
    } else if ( controller.isVdp.value == true ) {
      return "kPa";
    }
  }

  color() {
    if ( controller.isTemperature.value == true ) {
      return AppColors.orange;
    } else if ( controller.isElectricalLoad.value == true ) {
      return AppColors.lightBlue;
    } else if ( controller.isCo2.value == true ) {
      return AppColors.lightGreen1;
    } else if ( controller.isLightning.value == true ) {
      return AppColors.pink;
    } else if ( controller.isVdp.value == true ) {
      return AppColors.darkBlue2;
    }
  }

  graph() {
    if ( controller.isTemperature.value == true ) {
      return HourGraph(
        minY: controller.minTemperatureY.value,
        maxY: controller.maxTemperatureY.value,
        dataList: controller.temperatureDataList,
        graphColor: AppColors.orange,
        format: "°C",
      );
    } else if ( controller.isElectricalLoad.value == true ) {
      return HourGraph(
        minY: controller.minHumidityY.value,
        maxY: controller.maxHumidityY.value,
        graphColor: AppColors.lightBlue,
        dataList: controller.humidityDataList,
        format: "kW",
      );
    } else if ( controller.isCo2.value == true ) {
      return HourGraph(
        minY: controller.minCo2Y.value,
        maxY: controller.maxCo2Y.value,
        graphColor: AppColors.lightGreen1,
        dataList: controller.co2DataList,
        format: " ppm",
      );
    } else if ( controller.isLightning.value == true ) {
      return HourGraph(
        minY: controller.minLightY.value,
        maxY: controller.maxLightY.value,
        dataList: controller.lightDataList,
        graphColor: AppColors.pink,
        format: " mol/m2day",
      );
    } else if ( controller.isVdp.value == true ) {
      HourGraph(
        minY: controller.minVpdY.value,
        maxY: controller.maxVpdY.value,
        graphColor: AppColors.lightBlue2,
        dataList: controller.vpdDataList,
        format: " kPa",
      );
    }
  }

}