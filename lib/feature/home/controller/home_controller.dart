import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/feature/dashboard/view/dashboard_screen.dart';
import 'package:scimetic/feature/growsheet/view/growsheets_screen.dart';
import 'package:scimetic/feature/overview/view/overview_screen.dart';

class HomeController extends GetxController {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  RxBool isDashboard = true.obs;
  RxBool isGrowSheet = false.obs;
  RxBool isChat = false.obs;
  RxBool isReport = false.obs;
  RxBool isTodo = false.obs;
  RxBool isCalender = false.obs;
  RxBool isSetting = false.obs;
  RxBool isOverview = false.obs;

  RxInt moduleIndex = 0.obs;

  void toggle() => isSetting.value = isSetting.value ? false : true;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void changeModuleIndex(int index) {
    moduleIndex.value = index;
  }

  List<Widget> moduleList = [
     DashboardScreen(),
      GrowSheetsScreen()
  ];

}