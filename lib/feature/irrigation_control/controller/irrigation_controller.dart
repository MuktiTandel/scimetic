import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class IrrigationController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController dayTimeOnHourController = TextEditingController();
  final TextEditingController dayTimeOnMinuteController = TextEditingController();

  final TextEditingController dayTimeOffHourController = TextEditingController();
  final TextEditingController dayTimeOffMinuteController = TextEditingController();

  final TextEditingController nightTimeOnHourController = TextEditingController();
  final TextEditingController nightTimeOnMinuteController = TextEditingController();

  final TextEditingController nightTimeOffHourController = TextEditingController();
  final TextEditingController nightTimeOffMinuteController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  RxBool isSelect = false.obs;

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];
}