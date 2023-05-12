import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class TemperatureController extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController dayCoolingTemperature = TextEditingController();
  final TextEditingController dayCoolingDeadband = TextEditingController();

  final TextEditingController nightCoolingTemperature = TextEditingController();
  final TextEditingController nightCoolingDeadband = TextEditingController();

  final TextEditingController dayHeatingTemperature = TextEditingController();
  final TextEditingController dayHeatingDeadband = TextEditingController();

  final TextEditingController nightHeatingTemperature = TextEditingController();
  final TextEditingController nightHeatingDeadband = TextEditingController();

  final TextEditingController circulationTemperature = TextEditingController();
  final TextEditingController circulationDeadband = TextEditingController();
  final TextEditingController circulationHumidityTemperature = TextEditingController();
  final TextEditingController circulationHumidityDeadband = TextEditingController();

  final TextEditingController extractorTemperature = TextEditingController();
  final TextEditingController extractorTemperatureOOF = TextEditingController();

  final TextEditingController wetWallTemperature = TextEditingController();
  final TextEditingController wetWallDeadband = TextEditingController();

  final TextEditingController timeOnHour = TextEditingController();
  final TextEditingController timeOnMinute = TextEditingController();
  final TextEditingController timeOffHour = TextEditingController();
  final TextEditingController timeOffMinute = TextEditingController();

  RxString dayCoolingValue = AppStrings.chooseSwitch.obs;

  RxString nightCoolingValue = AppStrings.chooseSwitch.obs;

  RxString dayHeatingValue = AppStrings.chooseSwitch.obs;

  RxString nightHeatingValue = AppStrings.chooseSwitch.obs;

  List<String> dayCoolingItems = [
    AppStrings.chooseSwitch
  ];

  List<String> nightCoolingItems = [
    AppStrings.chooseSwitch
  ];

  List<String> dayHeatingItems = [
    AppStrings.chooseSwitch
  ];

  List<String> nightHeatingItems = [
    AppStrings.chooseSwitch
  ];

}