import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class IrrigationController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController dayHourController = TextEditingController();
  final TextEditingController dayMinuteController = TextEditingController();

  final TextEditingController nightHourController = TextEditingController();
  final TextEditingController nightMinuteController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  RxBool isSelect = false.obs;

  RxBool isApply = false.obs;

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];
}