import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/calendar/view/calendar_screen.dart';
import 'package:scimetic/feature/chat/view/chat_screen.dart';
import 'package:scimetic/feature/co2_control/view/co2_control_screen.dart';
import 'package:scimetic/feature/dashboard/view/dashboard_screen.dart';
import 'package:scimetic/feature/device_settings/view/device_settings_screen.dart';
import 'package:scimetic/feature/energy_management/view/energy_management_screen.dart';
import 'package:scimetic/feature/fertigation_control/view/fertigation_control_screen.dart';
import 'package:scimetic/feature/growsheet/view/growsheets_screen.dart';
import 'package:scimetic/feature/humidity_control/view/humidity_control_screen.dart';
import 'package:scimetic/feature/irrigation_control/view/irrigation_control_screen.dart';
import 'package:scimetic/feature/lightning_control/view/lightning_control_screen.dart';
import 'package:scimetic/feature/temperature_control/view/temperature_controller_screen.dart';
import 'package:scimetic/feature/to_do/view/todo_screen.dart';

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
  RxBool isDeviceSetup = false.obs;
  RxBool isTemperatureControl = false.obs;
  RxBool isHumidityControl = false.obs;
  RxBool isCo2Control = false.obs;
  RxBool isLightingControl = false.obs;
  RxBool isEnergyManagement = false.obs;
  RxBool isIrrigation = false.obs;
  RxBool isFertigation = false.obs;
  RxBool isAccessSetting = false.obs;
  RxBool isOrganisationSettings = false.obs;
  RxBool isUserSetting = false.obs;
  RxBool isNotifications = false.obs;

  RxInt moduleIndex = 0.obs;

  void toggle() => isSetting.value = isSetting.value ? false : true;

  StoreData storeData = StoreData();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void changeModuleIndex(int index) {
    moduleIndex.value = index;
  }

  appbarTitle() {
    if (moduleIndex.value == 0 ) {
      return AppStrings.tOverview;
    } else if ( moduleIndex.value == 1 ) {
      return AppStrings.growSheets;
    } else if ( moduleIndex.value == 2 ) {
      return AppStrings.chat;
    } else if ( moduleIndex.value == 3 ) {
      return AppStrings.toDo;
    } else if ( moduleIndex.value == 4 ) {
      return AppStrings.calendar;
    } else if (moduleIndex.value == 5 ) {
      return AppStrings.deviceSettings;
    } else if (moduleIndex.value == 6 ) {
      return AppStrings.temperatureControl;
    } else if ( moduleIndex.value == 7 ) {
      return AppStrings.humidityControl;
    } else if ( moduleIndex.value == 8 ) {
      return AppStrings.co2Control;
    } else if ( moduleIndex.value == 9 ) {
      return AppStrings.lightingControl;
    } else if ( moduleIndex.value == 10 ) {
      return AppStrings.energyManagement;
    } else if ( moduleIndex.value == 11 ) {
      return AppStrings.irrigationControl;
    } else if ( moduleIndex.value == 12 ) {
      return AppStrings.fertigationControl;
    }
  }


  List<Widget> moduleList = [
     DashboardScreen(),
     GrowSheetsScreen(),
    ChatScreen(),
    TodoScreen(),
    CalendarScreen(),
    DeviceSettingsScreen(),
    TemperatureControllerScreen(),
    HumidityControlScreen(),
    Co2ControlScreen(),
    LightningControlScreen(),
    EnergyManagementScreen(),
    IrrigationControlScreen(),
    FertigationControlScreen()
  ];

}