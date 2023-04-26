import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isDashboard = true.obs;
  RxBool isGrowSheet = false.obs;
  RxBool isChat = false.obs;
  RxBool isReport = false.obs;
  RxBool isTodo = false.obs;
  RxBool isCalender = false.obs;
  RxBool isSetting = false.obs;

  void toggle() => isSetting.value = isSetting.value ? false : true;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

}