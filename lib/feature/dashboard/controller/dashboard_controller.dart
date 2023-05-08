import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  RxBool isOverView = false.obs;

  RxBool isDark = Get.isDarkMode.obs;

  RxInt descriptionLength = 0.obs;

  final TextEditingController growspaceNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

}