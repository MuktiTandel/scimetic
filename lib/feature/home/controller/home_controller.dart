import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/access_setting/view/access_setting_screen.dart';
import 'package:scimetic/feature/calendar/view/calendar_screen.dart';
import 'package:scimetic/feature/circulation_control/view/circulation_control_screen.dart';
import 'package:scimetic/feature/co2_control/view/co2_control_screen.dart';
import 'package:scimetic/feature/control_tab/view/control_tab_screen.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/device_settings/view/device_settings_screen.dart';
import 'package:scimetic/feature/energy_management/view/energy_management_screen.dart';
import 'package:scimetic/feature/extractor_control/view/extractor_control_screen.dart';
import 'package:scimetic/feature/fertigation_control/view/fertigation_control_screen.dart';
import 'package:scimetic/feature/growsheet/view/growsheets_screen.dart';
import 'package:scimetic/feature/humidity_control/view/humidity_control_screen.dart';
import 'package:scimetic/feature/irrigation_control/view/irrigation_control_screen.dart';
import 'package:scimetic/feature/lightning_control/view/lightning_control_screen.dart';
import 'package:scimetic/feature/notification_setting/view/notification_setting_screen.dart';
import 'package:scimetic/feature/organization_settings/view/organization_setting_screen.dart';
import 'package:scimetic/feature/organizations/controller/organization_controller.dart';
import 'package:scimetic/feature/profile_setting/view/profile_setting_screen.dart';
import 'package:scimetic/feature/reports/view/report_screen.dart';
import 'package:scimetic/feature/temperature_control/view/temperature_controller_screen.dart';
import 'package:scimetic/feature/to_do/view/todo_screen.dart';
import 'package:scimetic/feature/wet_wall_control/view/wet_wall_control_screen.dart';

class HomeController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final organizationController = Get.put(OrganizationController());

  final dashBoardController = Get.put(DashboardController());

  RxBool isModuleView = false.obs;

  RxBool isOrganization = true.obs;
  RxBool isDashboard = false.obs;
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
  RxBool isCirculationControl = false.obs;
  RxBool isControlTab = false.obs;
  RxBool isWetWallControl = false.obs;
  RxBool isExtractorControl = false.obs;

  RxBool isLogOut = false.obs;

  RxInt moduleIndex = 0.obs;

  void toggle() => isSetting.value = isSetting.value ? false : true;

  StoreData storeData = StoreData();

  RxInt roleId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    roleId.value = storeData.getInt(StoreData.roleId)!;
    AppConst().debug("role id => ${roleId.value}");
    if (roleId.value != 1) {
      organizationController.isSelect.value = true;
      dashBoardController.getDataList();
    }
  }

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
    if (isModuleView.value == false) {
      if (organizationController.isSelect.value == false) {
        if (organizationController.isGrowSpaces.value == true &&
            organizationController.isUser.value == false) {
          return AppStrings.growspaces;
        } else if (organizationController.isGrowSpaces.value == true &&
            organizationController.isUser.value == true) {
          return AppStrings.accessSetting;
        } else {
          return AppStrings.organizations;
        }
      } else if (organizationController.isSelect.value == true) {
        if ( dashBoardController.isUser.value == true ) {
          return AppStrings.accessSetting;
        } else {
          return dashBoardController.companyName.value;
        }
      }
    } else {
      if (moduleIndex.value == 0) {
        return AppStrings.growSheets;
      } else if (moduleIndex.value == 1) {
        return AppStrings.reports;
      } else if (moduleIndex.value == 2) {
        return AppStrings.toDo;
      } else if (moduleIndex.value == 3) {
        return AppStrings.calendar;
      } else if (moduleIndex.value == 4) {
        return AppStrings.deviceSettings;
      } else if (moduleIndex.value == 5) {
        return AppStrings.temperatureControl;
      } else if (moduleIndex.value == 6) {
        return AppStrings.humidityControl;
      } else if (moduleIndex.value == 7) {
        return AppStrings.co2Control;
      } else if (moduleIndex.value == 8) {
        return AppStrings.lightingControl;
      } else if (moduleIndex.value == 9) {
        return AppStrings.energyManagement;
      } else if (moduleIndex.value == 10) {
        return AppStrings.irrigationControl;
      } else if (moduleIndex.value == 11) {
        return AppStrings.fertigationControl;
      } else if (moduleIndex.value == 12) {
        return AppStrings.accessSetting;
      } else if (moduleIndex.value == 13) {
        return AppStrings.organisationSettings;
      } else if (moduleIndex.value == 14) {
        return AppStrings.profileSettings;
      } else if (moduleIndex.value == 15) {
        return AppStrings.notificationsSettings;
      } else if (moduleIndex.value == 16) {
        return AppStrings.circulationControl;
      } else if (moduleIndex.value == 17) {
        return AppStrings.screenControl;
      } else if (moduleIndex.value == 18) {
        return AppStrings.wetWallControl;
      } else if (moduleIndex.value == 19) {
        return AppStrings.extractorFanControl;
      }
    }
  }

  void unSelectSettingValue() {
    isDeviceSetup.value = false;
    isTemperatureControl.value = false;
    isHumidityControl.value = false;
    isCo2Control.value = false;
    isLightingControl.value = false;
    isEnergyManagement.value = false;
    isIrrigation.value = false;
    isFertigation.value = false;
    isAccessSetting.value = false;
    isOrganisationSettings.value = false;
    isUserSetting.value = false;
    isNotifications.value = false;
    isCirculationControl.value = false;
    isControlTab.value = false;
    isWetWallControl.value = false;
    isExtractorControl.value = false;
  }

  void unSelectModule() {
    isGrowSheet.value = false;
    isReport.value = false;
    isTodo.value = false;
    isCalender.value = false;
    isSetting.value = false;
  }

  List<Widget> moduleList = [
    GrowSheetsScreen(),
    ReportScreen(),
    TodoScreen(),
    CalendarScreen(),
    DeviceSettingsScreen(),
    TemperatureControllerScreen(),
    HumidityControlScreen(),
    Co2ControlScreen(),
    LightningControlScreen(),
    EnergyManagementScreen(),
    IrrigationControlScreen(),
    FertigationControlScreen(),
    AccessSettingScreen(),
    OrganizationSettingScreen(),
    ProfileSettingScreen(),
    NotificationSettingScreen(),
    CirculationControlScreen(),
    ControlTabScreen(),
    WetWallControlScreen(),
    ExtractorControlScreen()
  ];
}
