import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TodoController extends GetxController {

  RxBool isTodo = true.obs;
  RxBool isProgress = false.obs;
  RxBool isCompleted = false.obs;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  DateRangePickerController date = DateRangePickerController();

  RxInt descriptionLength = 0.obs;

  RxString selectValue = AppStrings.selectAssignName.obs;

  List<String> userNameList = [
    AppStrings.selectAssignName,
  ];

}