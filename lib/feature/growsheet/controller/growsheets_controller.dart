import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scimetic/core/const/app_strings.dart';

class GrowSheetController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController dayTemperatureController = TextEditingController();
  final TextEditingController dayRhController = TextEditingController();
  final TextEditingController dayCo2Controller = TextEditingController();
  final TextEditingController dayLightOnHourController = TextEditingController();
  final TextEditingController dayLightOnMinuteController = TextEditingController();
  final TextEditingController dayLightOffHourController = TextEditingController();
  final TextEditingController dayLightOffMinuteController = TextEditingController();

  final TextEditingController nightTemperatureController = TextEditingController();
  final TextEditingController nightRhController = TextEditingController();
  final TextEditingController nightCo2Controller = TextEditingController();
  final TextEditingController nightLightOnHourController = TextEditingController();
  final TextEditingController nightLightOnMinuteController = TextEditingController();
  final TextEditingController nightLightOffHourController = TextEditingController();
  final TextEditingController nightLightOffMinuteController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];

  RxString strainValue = AppStrings.chooseStrain.obs;

  List<String> strainNameList = [
    AppStrings.chooseStrain
  ];

  RxString seedBankValue = AppStrings.chooseSeedBank.obs;

  List<String> seedBankList = [
    AppStrings.chooseSeedBank
  ];

  RxString tagValue = AppStrings.chooseTag.obs;

  List<String> tagList = [
    AppStrings.chooseTag
  ];

  RxString irrigationValue = AppStrings.chooseSchedule.obs;

  List<String> irrigationList = [
    AppStrings.chooseSchedule
  ];

  RxString fertigationValue1 = AppStrings.chooseSchedule.obs;

  List<String> fertigationList1 = [
    AppStrings.chooseSchedule
  ];

  RxString fertigationValue2 = AppStrings.chooseSchedule.obs;

  List<String> fertigationList2 = [
    AppStrings.chooseSchedule
  ];

}