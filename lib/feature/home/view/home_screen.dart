import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/theme_service.dart';
import 'package:scimetic/core/elements/common_appbar.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/access_setting/controller/access_setting_controller.dart';
import 'package:scimetic/feature/calendar/controller/calendar_controller.dart';
import 'package:scimetic/feature/circulation_control/controller/circulation_control_controller.dart';
import 'package:scimetic/feature/co2_control/controller/co2_controller.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/dashboard/view/dashboard_screen.dart';
import 'package:scimetic/feature/device_settings/controller/device_settings_controller.dart';
import 'package:scimetic/feature/growsheet/controller/growsheets_controller.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';
import 'package:scimetic/feature/humidity_control/controller/humidity_controller.dart';
import 'package:scimetic/feature/irrigation_control/controller/irrigation_controller.dart';
import 'package:scimetic/feature/lightning_control/controller/lightning_controller.dart';
import 'package:scimetic/feature/notification_setting/controller/notification_setting_controller.dart';
import 'package:scimetic/feature/organization_settings/controller/organization_setting_controller.dart';
import 'package:scimetic/feature/organizations/controller/organization_controller.dart';
import 'package:scimetic/feature/organizations/view/organization_screen.dart';
import 'package:scimetic/feature/overview/controller/overview_controller.dart';
import 'package:scimetic/feature/overview/view/overview_screen.dart';
import 'package:scimetic/feature/temperature_control/controller/temperature_controller.dart';
import 'package:scimetic/feature/to_do/controller/todo_controller.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final controller = Get.put(HomeController());

   final dashboardController = Get.put(DashboardController());

   final calendarController = Get.put(CalendarController());

   final growSheetController = Get.put(GrowSheetController());

   final organizationController = Get.put(OrganizationController());

   final overviewController = Get.put(OverviewController());

   final todoController = Get.put(TodoController());

   final deviceController = Get.put(DeviceSettingsController());

   final temperatureController = Get.put(TemperatureController());

   final circulationController = Get.put(CirculationControlController());

   final humidityController = Get.put(HumidityController());

   final co2Controller = Get.put(Co2Controller());

   final lightningController = Get.put(LightningController());

   final accessSettingController = Get.put(AccessSettingController());

   final organizationSettingController = Get.put(OrganizationSettingController());

   final notificationSettingController = Get.put(NotificationSettingController());

   final irrigationController = Get.put(IrrigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 45.h),
        child: Obx(() => CommonAppbar(
            drawerTap: (){
              controller.openDrawer();
            },
            title: dashboardController.isOverViewTitle.value == false
                ? controller.appbarTitle() : AppStrings.overview,
            notificationTap: (){
              Get.toNamed(AppPages.NOTIFICATION);
            },
            profileTap: (){},
          leadingIcon: AppImages.drawer,
          isCalendar: controller.isCalender.value,
          isCrop: calendarController.personalCalendar,
          isPersonal: calendarController.cropCalendar,
        )),
      ),
      body: Obx(() => controller.roleId.value == 1 ? (organizationController.isSelect.value == false
          ? OrganizationScreen()
          : dashboardController.isOverView.value == false
          ? const DashboardScreen()
          : controller.isModuleView.value == false
          ? const OverviewScreen()
          : IndexedStack(
        index: controller.moduleIndex.value,
        children: controller.moduleList,
      )) : (dashboardController.isOverView.value == false
          ? const DashboardScreen()
          : controller.isModuleView.value == false
          ? const OverviewScreen()
          : IndexedStack(
        index: controller.moduleIndex.value,
        children: controller.moduleList,
      ))
      ),
      drawer: Drawer(
        width: 230.w,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)),
        ),
        child: Container(
          padding: EdgeInsets.only(right: 2.w),
          decoration: const BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)
            )
          ) ,
          child: Container(
            decoration:  BoxDecoration(
                color: Get.isDarkMode ? AppColors.darkAppbar : Colors.white,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ) ,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      Get.isDarkMode ? AppImages.darkLogo : AppImages.lightLogo,
                      height: 35.h,
                      width: 35.w,
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                Divider(
                  color: AppColors.buttonColor,
                  thickness: 2.w,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: AppBehavior(),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Obx(() => controller.roleId.value == 1 ? drawerWidget(
                                onTap: (){
                                  controller.isOrganization.value = true;
                                  organizationController.isSelect.value = false;
                                  controller.isDashboard.value = false;
                                  dashboardController.isSelect.value = false;
                                  dashboardController.isOverView.value = false;
                                  dashboardController.isOverViewTitle.value = false;
                                  controller.isModuleView.value = false;
                                  controller.unSelectSettingValue();
                                  controller.unSelectModule();
                                  overviewController.isGraphScreen.value = false;
                                  Get.back();
                                },
                                image: AppImages.dashboard,
                                title: AppStrings.organizations,
                                isSelect: controller.isOrganization.value,
                                isRightWidget: false
                            ) : const SizedBox.shrink()),
                            Obx(() => controller.roleId.value == 0 ? SizedBox(height: 5.h,) : const SizedBox.shrink() ),
                            Obx(() => organizationController.isSelect.value == true ? drawerWidget(
                                onTap: (){
                                   dashboardController.isOverView.value = false;
                                  dashboardController.isSelect.value = false;
                                  controller.isDashboard.value = true;
                                  controller.isModuleView.value = false;
                                  dashboardController.isOverViewTitle.value = false;
                                  controller.unSelectSettingValue();
                                  controller.unSelectModule();
                                   overviewController.isGraphScreen.value = false;
                                  Get.back();
                                  dashboardController.getDataList();
                                },
                                image: AppImages.dashboard,
                                title: AppStrings.dashboard,
                                isSelect: controller.isDashboard.value,
                              isRightWidget: false
                            ) : const SizedBox.shrink(),),
                            SizedBox(height: 5.h,),
                            Obx(() => dashboardController.isSelect.value == true
                                ? Column(
                              children: [
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( dashboardController.isOverView.value == true ) {
                                        controller.isModuleView.value = true;
                                      }
                                      controller.isOrganization.value = false;
                                      controller.isDashboard.value = false;
                                      controller.isGrowSheet.value = true;
                                      controller.isReport.value = false;
                                      controller.isTodo.value = false;
                                      controller.isCalender.value = false;
                                      controller.isSetting.value = false;
                                      dashboardController.isOverViewTitle.value = false;
                                      overviewController.isGraphScreen.value = false;
                                      controller.unSelectSettingValue();
                                      controller.changeModuleIndex(0);
                                      Get.back();
                                      int id = controller.storeData.getInt(StoreData.id)!;
                                      if ( id != 0) {
                                         growSheetController.getGrowSheetData();
                                      }
                                    },
                                    image: AppImages.growSheets,
                                    title: AppStrings.growSheets,
                                    isSelect: controller.isGrowSheet.value,
                                    isRightWidget: false
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( dashboardController.isOverView.value == true ) {
                                        controller.isModuleView.value = true;
                                      }
                                      controller.isOrganization.value = false;
                                      controller.isDashboard.value = false;
                                      controller.isGrowSheet.value = false;
                                      controller.isReport.value = true;
                                      controller.isTodo.value = false;
                                      controller.isCalender.value = false;
                                      controller.isSetting.value = false;
                                      dashboardController.isOverViewTitle.value = false;
                                      overviewController.isGraphScreen.value = false;
                                      controller.unSelectSettingValue();
                                      controller.changeModuleIndex(1);
                                      Get.back();
                                    },
                                    image: AppImages.reports,
                                    title: AppStrings.reports,
                                    isSelect: controller.isReport.value,
                                    isRightWidget: false
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( dashboardController.isOverView.value == true ) {
                                        controller.isModuleView.value = true;
                                      }
                                      controller.isOrganization.value = false;
                                      controller.isDashboard.value = false;
                                      controller.isGrowSheet.value = false;
                                      controller.isReport.value = false;
                                      controller.isTodo.value = true;
                                      controller.isCalender.value = false;
                                      controller.isSetting.value = false;
                                      dashboardController.isOverViewTitle.value = false;
                                      overviewController.isGraphScreen.value = false;
                                      controller.unSelectSettingValue();
                                      controller.changeModuleIndex(2);
                                      todoController.isTodo.value = true;
                                      Get.back();
                                      todoController.getTodoList().whenComplete(() async {
                                        await todoController.getCompanyUser();
                                      });
                                    },
                                    image: AppImages.toDo,
                                    title: AppStrings.toDo,
                                    isSelect: controller.isTodo.value,
                                    isRightWidget: false,
                                    rightImage: AppImages.orangeRectangle,
                                    rightText: "12",
                                    height: 20.h,
                                    width: 20.w
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: () async {
                                      if ( dashboardController.isOverView.value == true ) {
                                        controller.isModuleView.value = true;
                                      }
                                      controller.isOrganization.value = false;
                                      controller.isDashboard.value = false;
                                      controller.isGrowSheet.value = false;
                                      controller.isReport.value = false;
                                      controller.isTodo.value = false;
                                      controller.isCalender.value = true;
                                      controller.isSetting.value = false;
                                      overviewController.isGraphScreen.value = false;
                                      controller.unSelectSettingValue();
                                      controller.changeModuleIndex(3);
                                      calendarController.personalCalendar.value = false;
                                      calendarController.cropCalendar.value = true;
                                      dashboardController.isOverViewTitle.value = false;
                                      Get.back();
                                      await calendarController.getEventList();
                                    },
                                    image: AppImages.calender,
                                    title: AppStrings.calendar,
                                    isSelect: controller.isCalender.value,
                                    isRightWidget: false,
                                    rightImage: AppImages.greenRectangle,
                                    rightText: "3"
                                ),),
                                SizedBox(height: 10.h,),
                                SizedBox(
                                  height: 45.h,
                                  width: 226.w,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 15.w,),
                                      Image.asset(
                                        AppImages.settings,
                                        height: 20.h,
                                        width: 20.w,
                                        color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      CustomText(
                                        text: AppStrings.settings,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                      ),
                                      Expanded(child: SizedBox(width: 10.w,)),
                                      Obx(() => GestureDetector(
                                        onTap: (){
                                          controller.toggle();
                                          controller.isGrowSheet.value = false;
                                          controller.isReport.value = false;
                                          controller.isTodo.value = false;
                                          controller.isCalender.value = false;
                                          overviewController.isGraphScreen.value = false;
                                          controller.unSelectSettingValue();
                                          controller.isDashboard.value == false;
                                          controller.isOrganization.value = false;
                                          dashboardController.isOverViewTitle.value = false;
                                        },
                                        child: SizedBox(
                                          child: Image.asset(
                                            controller.isSetting.value == false ? AppImages.downArrow : AppImages.upArrow,
                                            height: 25.h,
                                            width: 25.w,
                                            fit: BoxFit.cover,
                                            color: Get.isDarkMode ? AppColors.white1 : Colors.black,
                                          ),
                                        ),
                                      ),),
                                      SizedBox(width: 10.w,)
                                    ],
                                  ),
                                ),
                                Obx(() => controller.isSetting.value == true
                                    ? settingWidget() : const SizedBox.shrink()),
                                SizedBox(height: 5.h,),
                              ],
                            )
                                : const SizedBox.shrink()
                            ),
                            SizedBox(
                              height: 45.h,
                              width: 226.w,
                              child: Row(
                                children: [
                                  SizedBox(width: 15.w,),
                                  Image.asset(
                                    AppImages.sun,
                                    height: 20.h,
                                    width: 20.w,
                                    color: Get.isDarkMode ? AppColors.darkText : AppColors.lightBorder,
                                  ),
                                  SizedBox(
                                    width: Get.isDarkMode ? 10.w : 5.w,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      ThemeService().switchTheme();
                                      Get.back();
                                    },
                                    child: SizedBox(
                                      height: 28.h,
                                      width: 36.w,
                                      child: SvgPicture.asset(
                                        Get.isDarkMode
                                            ? AppImages.lightSelectSwitch
                                            : AppImages.lightUnselectSwitch,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.isDarkMode ? 5.w : 10.w,
                                  ),
                                  Image.asset(
                                    AppImages.theme,
                                    height: 20.h,
                                    width: 20.w,
                                    color: Get.isDarkMode ? AppColors.buttonColor :  AppColors.lightBorder,
                                  ),
                                ],
                              ),
                            ),
                            drawerWidget(
                                onTap: (){
                                  Get.offAllNamed(AppPages.LOGIN);
                                  GetStorage().remove(StoreData.email);
                                },
                                image: AppImages.logout,
                                title: AppStrings.logOut,
                                isSelect: controller.isLogOut.value,
                                isRightWidget: false
                            ),
                            SizedBox(height: 40.h,)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerWidget ({ required VoidCallback onTap,
    required String image,
    required String title,
    required bool isSelect,
    required bool isRightWidget,
    String? rightImage,
    String? rightText,
    double? height,
    double? width
  }) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        color: isSelect == true
            ? Get.isDarkMode ? AppColors.darkBlue
            : AppColors.lightAppbar : Colors.transparent,
        height: 45.h,
        width: 226.w,
        child: Row(
          children: [
            SizedBox(width: 15.w,),
            Image.asset(
              image,
              height: 20.h,
              width: 20.w,
              color: isSelect == false
                  ? Get.isDarkMode ? AppColors.white1 : Colors.black : AppColors.buttonColor,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
              text: title,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isSelect == false
                  ? Get.isDarkMode ? AppColors.white1 : Colors.black : AppColors.buttonColor,
            ),
            Expanded(child: SizedBox(width: 10.w,)),
            isRightWidget == true ? Container(
              height: height ?? 16.h,
              width: width ?? 16.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(rightImage ?? AppImages.redRectangle)
                )
              ),
              child: Center(
                child: CustomText(
                    text: rightText ?? "1",
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ) : const SizedBox.shrink(),
            SizedBox(width: 10.w,)
          ],
        ),
      ),
    );
  }

  Widget settingWidget() {
    return Padding(
      padding:  EdgeInsets.all(12.w),
      child: Column(
        children: [
          settingCommonWidget(
              image: AppImages.deviceSetup,
              title: AppStrings.deviceSetup,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = true;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(4);
                Get.back();
                await deviceController.getDeviceData();
              },
            isSelect: controller.isDeviceSetup
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.thermometer,
              title: AppStrings.temperatureControl,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = true;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(5);
                Get.back();
                await temperatureController.getTemperatureControllerData();
              },
            isSelect: controller.isTemperatureControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.circulation,
              title: AppStrings.circulationControl,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = true;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(16);
                Get.back();
                await circulationController.getCirculationControlData();
              },
              isSelect: controller.isCirculationControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.controlTab,
              title: AppStrings.controlTab,
              onTap: (){
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = true;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(17);
                Get.back();
              },
              isSelect: controller.isControlTab
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.humidity,
              title: AppStrings.humidityControl,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = true;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(6);
                Get.back();
                await humidityController.getHumidityControllerData();
              },
            isSelect: controller.isHumidityControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.cloud,
              title: AppStrings.co2Control,
              onTap: (){
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = true;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(7);
                Get.back();
                co2Controller.getCo2ControllerData();
              },
            isSelect: controller.isCo2Control
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.sun1,
              title: AppStrings.lightingControl,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = true;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(8);
                Get.back();
                await lightningController.getLightningData();
              },
            isSelect: controller.isLightingControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.energy,
              title: AppStrings.energyManagement,
              onTap: (){
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = true;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(9);
                Get.back();
              },
            isSelect: controller.isEnergyManagement
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.wateringCan,
              title: AppStrings.irrigation,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = true;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(10);
                irrigationController.listHeight.value = 80.0;
                irrigationController.dayMinuteList.clear();
                irrigationController.dayMinuteList.add(TextEditingController());
                irrigationController.dayHourList.clear();
                irrigationController.dayHourList.add(TextEditingController());
                irrigationController.nightMinuteList.clear();
                irrigationController.nightMinuteList.add(TextEditingController());
                irrigationController.nightHourList.clear();
                irrigationController.nightHourList.add(TextEditingController());
                Get.back();
                await irrigationController.getIrrigationControlData();
              },
            isSelect: controller.isIrrigation
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.fertigation,
              title: AppStrings.fertigation,
              onTap: (){
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = true;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(11);
                Get.back();
              },
            isSelect: controller.isFertigation
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.lock,
              title: AppStrings.accessSettings,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = true;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(12);
                Get.back();
                await accessSettingController.getUserList();
                accessSettingController.roleValue.value = "";
              },
            isSelect: controller.isAccessSetting
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.briefcase,
              title: AppStrings.organisationSettings,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = true;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(13);
                Get.back();
                await organizationSettingController.getCompanyDetails();
              },
            isSelect: controller.isOrganisationSettings
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.user,
              title: AppStrings.userSetting,
              onTap: (){
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = true;
                controller.isNotifications.value = false;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(14);
                Get.back();
              },
            isSelect: controller.isUserSetting
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.notification,
              title: AppStrings.notifications,
              onTap: () async {
                if ( dashboardController.isOverView.value == true ) {
                  controller.isModuleView.value = true;
                }
                controller.isOrganization.value = false;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = true;
                controller.isControlTab.value = false;
                controller.isCirculationControl.value = false;
                dashboardController.isOverViewTitle.value = false;
                overviewController.isGraphScreen.value = false;
                controller.changeModuleIndex(15);
                Get.back();
                await notificationSettingController.getNotificationData();
              },
            isSelect: controller.isNotifications
          ),
        ],
      ),
    );
  }

  Widget settingCommonWidget ({
    required String image,
    required String title,
    required VoidCallback onTap,
    required RxBool isSelect
  }) {
    return Obx(() => GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        color: Get.isDarkMode
            ? isSelect.value == true
            ? Colors.transparent : Colors.transparent
            : isSelect.value == false ? Colors.transparent : Colors.white,
        child: Row(
          children: [
            SizedBox(width: 20.w,),
            Image.asset(
              image,
              height: 20.h,
              width: 20.w,
              color: Get.isDarkMode
                  ? isSelect.value == true ? AppColors.buttonColor
                  : AppColors.darkIcon
                  : isSelect.value == false
                  ? AppColors.lightGray1 : AppColors.buttonColor,
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 14.sp,
                color: Get.isDarkMode
                    ? isSelect.value == true
                    ? AppColors.buttonColor : AppColors.darkIcon
                    : isSelect.value == false
                    ? AppColors.lightGray1 : AppColors.buttonColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
