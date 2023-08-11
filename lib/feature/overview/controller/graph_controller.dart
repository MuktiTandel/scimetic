import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';

class GraphController extends GetxController {

  final controller = Get.put(OverviewController());

  @override
  void onClose() {

    // if ( controller.isTemperature.value == true ) {
    //   controller.isTemperature.value = false;
    // } else if ( controller.isElectricalLoad.value == true ) {
    //   controller.isElectricalLoad.value = false;
    // } else if ( controller.isCo2.value == true ) {
    //   controller.isCo2.value = false;
    // } else if ( controller.isLightning.value == true ) {
    //   controller.isLightning.value = false;
    // } else if ( controller.isVdp.value == true ) {
    //   controller.isVdp.value = false;
    // }

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