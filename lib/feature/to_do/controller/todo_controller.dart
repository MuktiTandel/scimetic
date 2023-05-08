import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

class TodoController extends GetxController {

  RxBool isTodo = true.obs;
  RxBool isProgress = false.obs;
  RxBool isCompleted = false.obs;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxString selectValue = AppStrings.selectAssignName.obs;

  List<String> userNameList = [
    AppStrings.selectAssignName,
  ];

}