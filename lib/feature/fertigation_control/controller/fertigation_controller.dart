import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class FertigationController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  RxString placeHolderValue = AppStrings.placeholder.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dayIngredientController = TextEditingController();
  final TextEditingController dayQuantityController = TextEditingController();

  final TextEditingController nightIngredientController = TextEditingController();
  final TextEditingController nightQuantityController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxBool isSelect = false.obs;

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];

}