import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class HumidityController extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController dayHumidityTarget = TextEditingController();
  final TextEditingController dayHumidityDeadband = TextEditingController();

  final TextEditingController nightHumidityTarget = TextEditingController();
  final TextEditingController nightHumidityDeadband = TextEditingController();

  final TextEditingController dayDehumidificationTarget = TextEditingController();
  final TextEditingController dayDehumidificationDeadband = TextEditingController();

  final TextEditingController nightDehumidificationTarget = TextEditingController();
  final TextEditingController nightDehumidificationDeadband = TextEditingController();

  RxString dayHumidityValue = AppStrings.switchSelection.obs;

  RxString nightHumidityValue = AppStrings.switchSelection.obs;

  RxString dayDehumidificationValue = AppStrings.switchSelection.obs;

  RxString nightDehumidificationValue = AppStrings.switchSelection.obs;

  List<String> dayHumidityList = [
    AppStrings.switchSelection
  ];

  List<String> nightHumidityList = [
    AppStrings.switchSelection
  ];

  List<String> dayDehumidificationList = [
    AppStrings.switchSelection
  ];

  List<String> nightDehumidificationList = [
    AppStrings.switchSelection
  ];

}