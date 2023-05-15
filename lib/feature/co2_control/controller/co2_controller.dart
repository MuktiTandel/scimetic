import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class Co2Controller extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController dayTarget = TextEditingController();
  final TextEditingController dayMinimumTarget = TextEditingController();
  final TextEditingController dayMaximumTarget = TextEditingController();
  final TextEditingController dayHighProtection = TextEditingController();

  final TextEditingController nightTarget = TextEditingController();
  final TextEditingController nightMinimumTarget = TextEditingController();
  final TextEditingController nightMaximumTarget = TextEditingController();
  final TextEditingController nightHighProtection = TextEditingController();

  RxString dayLightningValue = AppStrings.chooseSwitch.obs;

  RxString nightLightningValue = AppStrings.chooseSwitch.obs;

  List<String> dayLightningList = [
    AppStrings.chooseSwitch
  ];

  List<String> nightLightningList = [
    AppStrings.chooseSwitch
  ];
}