import 'dart:ui';

import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';

class GraphController extends GetxController {
  final controller = Get.put(OverviewController());

  title() {
    if (controller.isTemperature.value == true) {
      return AppStrings.temperature;
    } else if (controller.isElectricalLoad.value == true) {
      return AppStrings.humidity;
    } else if (controller.isCo2.value == true) {
      return AppStrings.cO2;
    } else if (controller.isLightning.value == true) {
      return AppStrings.lightning;
    } else if (controller.isVdp.value == true) {
      return AppStrings.vpd;
    }
  }

  image() {
    if (controller.isTemperature.value == true) {
      return AppImages.menu_;
    } else if (controller.isElectricalLoad.value == true) {
      return AppImages.fillSettings;
    } else if (controller.isCo2.value == true) {
      return AppImages.horizontalMenu;
    } else if (controller.isLightning.value == true) {
      return AppImages.menu_;
    } else if (controller.isVdp.value == true) {
      return AppImages.horizontalMenu;
    }
  }

  value() {
    if (controller.isTemperature.value == true) {
      return controller.temperatureValue.value.toStringAsFixed(2).toString();
    } else if (controller.isElectricalLoad.value == true) {
      return controller.humidityValue.value.toStringAsFixed(2).toString();
    } else if (controller.isCo2.value == true) {
      return controller.co2Value.value.toString();
    } else if (controller.isLightning.value == true) {
      return controller.lightningValue.value.toString();
    } else if (controller.isVdp.value == true) {
      return controller.vpdValue.value.toString();
    }
  }

  value_() {
    if (controller.isTemperature.value == true) {
      return "°C";
    } else if (controller.isElectricalLoad.value == true) {
      return "%";
    } else if (controller.isCo2.value == true) {
      return "ppm";
    } else if (controller.isLightning.value == true) {
      return "mol/m2day";
    } else if (controller.isVdp.value == true) {
      return "kPa";
    }
  }

  color() {
    if (controller.isTemperature.value == true) {
      return AppColors.orange;
    } else if (controller.isElectricalLoad.value == true) {
      return AppColors.lightBlue;
    } else if (controller.isCo2.value == true) {
      return AppColors.lightGreen1;
    } else if (controller.isLightning.value == true) {
      return AppColors.pink;
    } else if (controller.isVdp.value == true) {
      return AppColors.darkBlue2;
    }
  }

  graph() {
    if (controller.isTemperature.value == true) {
      return HourGraph(
        colors: [
          Color(0xffffae50),
          Color(0xffFF00FF),
          Color(0xff7DF9FF),
        ],
        dData: controller.tDevice,
        data: controller.temperature,
        minY: controller.minTemperatureY.value,
        maxY: controller.maxTemperatureY.value,
        dataList: controller.temperatureDataList,
        graphColor: AppColors.orange,
        format: "°C",
      );
    } else if (controller.isElectricalLoad.value == true) {
      return HourGraph(
        colors: [
          Color(0xff56ccf2),
          Color(0xffFF4500),
          Color(0xffFFA500),
        ],
        dData: controller.hDevice,
        data: controller.humidity,
        minY: controller.minHumidityY.value,
        maxY: controller.maxHumidityY.value,
        graphColor: AppColors.lightBlue,
        dataList: controller.humidityDataList,
        format: "kW",
      );
    } else if (controller.isCo2.value == true) {
      return HourGraph(
        colors: [
          Color(0xff3ce2c4),
          Color(0xffFF1493),
          Color(0xffBF00FF),
        ],
        dData: controller.cDevice,
        data: controller.co2,
        minY: controller.minCo2Y.value,
        maxY: controller.maxCo2Y.value,
        graphColor: AppColors.lightGreen1,
        dataList: controller.co2DataList,
        format: " ppm",
      );
    } else if (controller.isLightning.value == true) {
      return HourGraph(
        colors: [
          Color(0xfffb37a0),
          Color(0xffFF6F61),
          Color(0xffFF00FF),
        ],
        dData: controller.mDevice,
        data: controller.umol,
        minY: controller.minLightY.value,
        maxY: controller.maxLightY.value,
        dataList: controller.lightDataList,
        graphColor: AppColors.pink,
        format: " mol/m2day",
      );
    } else if (controller.isVdp.value == true) {
      return HourGraph(
        colors: [
          Color(0xff56a7f2),
          Color(0xff4169E1),
          Color(0xff6A0DAD),
        ],
        dData: controller.vDevice,
        data: controller.vpd,
        minY: controller.minVpdY.value,
        maxY: controller.maxVpdY.value,
        graphColor: AppColors.lightBlue2,
        dataList: controller.vpdDataList,
        format: " kPa",
      );
    }
  }
}
