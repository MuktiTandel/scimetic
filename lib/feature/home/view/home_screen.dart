import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/const/theme_service.dart';
import 'package:scimetic/core/elements/common_appbar.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/calendar/controller/calendar_controller.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/growsheet/controller/growsheets_controller.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';
import 'package:scimetic/feature/overview/view/overview_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final controller = Get.put(HomeController());

   final dashboardController = Get.put(DashboardController());

   final calendarController = Get.put(CalendarController());

   final growSheetController = Get.put(GrowSheetController());

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
            title: dashboardController.isOverView.value == false
                ?  controller.appbarTitle()
                : AppStrings.overview,
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
      body: Obx(() => dashboardController.isOverView.value == false ? IndexedStack(
        index: controller.moduleIndex.value,
        children: controller.moduleList,
      ) :  const OverviewScreen()),
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
                            Obx(() => drawerWidget(
                                onTap: (){
                                  if ( controller.isDashboard.value == false ) {
                                    controller.isDashboard.value = true;
                                    controller.isGrowSheet.value = false;
                                    controller.isChat.value = false;
                                    controller.isReport.value = false;
                                    controller.isTodo.value = false;
                                    controller.isCalender.value = false;
                                    controller.isSetting.value = false;
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
                                  }
                                  dashboardController.isOverView.value = false;
                                  controller.isCalender.value = false;
                                  controller.changeModuleIndex(0);
                                  dashboardController.getDataList();
                                  dashboardController.isSelect.value = false;
                                  Get.back();
                                },
                                image: AppImages.dashboard,
                                title: AppStrings.dashboard,
                                isSelect: controller.isDashboard.value,
                              isRightWidget: false
                            ),),
                            SizedBox(height: 5.h,),
                            Obx(() => dashboardController.isSelect.value == true
                                ? Column(
                              children: [
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( controller.isGrowSheet.value == false ) {
                                        controller.isDashboard.value = false;
                                        controller.isGrowSheet.value = true;
                                        controller.isChat.value = false;
                                        controller.isReport.value = false;
                                        controller.isTodo.value = false;
                                        controller.isCalender.value = false;
                                        controller.isSetting.value = false;
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
                                      }
                                      dashboardController.isOverView.value = false;
                                      controller.isCalender.value = false;
                                      controller.changeModuleIndex(1);
                                      int id = controller.storeData.getInt(StoreData.id)!;
                                      if ( id != 0) {
                                         growSheetController.getGrowSheetData(id: id);
                                      }
                                      Get.back();
                                    },
                                    image: AppImages.growSheets,
                                    title: AppStrings.growSheets,
                                    isSelect: controller.isGrowSheet.value,
                                    isRightWidget: false
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( controller.isChat.value == false ) {
                                        controller.isDashboard.value = false;
                                        controller.isGrowSheet.value = false;
                                        controller.isChat.value = true;
                                        controller.isReport.value = false;
                                        controller.isTodo.value = false;
                                        controller.isCalender.value = false;
                                        controller.isSetting.value = false;
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
                                      }
                                      dashboardController.isOverView.value = false;
                                      controller.isCalender.value = false;
                                      controller.changeModuleIndex(2);
                                      Get.back();
                                    },
                                    image: AppImages.chat,
                                    title: AppStrings.chat,
                                    isSelect: controller.isChat.value,
                                    isRightWidget: true,
                                    rightImage: AppImages.redRectangle,
                                    rightText: "8"
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( controller.isReport.value == false ) {
                                        controller.isDashboard.value = false;
                                        controller.isGrowSheet.value = false;
                                        controller.isChat.value = false;
                                        controller.isReport.value = true;
                                        controller.isTodo.value = false;
                                        controller.isCalender.value = false;
                                        controller.isSetting.value = false;
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
                                      }
                                      dashboardController.isOverView.value = false;
                                      controller.isCalender.value = false;
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
                                      if ( controller.isTodo.value == false ) {
                                        controller.isDashboard.value = false;
                                        controller.isGrowSheet.value = false;
                                        controller.isChat.value = false;
                                        controller.isReport.value = false;
                                        controller.isTodo.value = true;
                                        controller.isCalender.value = false;
                                        controller.isSetting.value = false;
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
                                      }
                                      controller.isCalender.value = false;
                                      dashboardController.isOverView.value = false;
                                      controller.changeModuleIndex(3);
                                      Get.back();
                                    },
                                    image: AppImages.toDo,
                                    title: AppStrings.toDo,
                                    isSelect: controller.isTodo.value,
                                    isRightWidget: true,
                                    rightImage: AppImages.orangeRectangle,
                                    rightText: "12",
                                    height: 20.h,
                                    width: 20.w
                                ),),
                                SizedBox(height: 5.h,),
                                Obx(() => drawerWidget(
                                    onTap: (){
                                      if ( controller.isCalender.value == false ) {
                                        controller.isDashboard.value = false;
                                        controller.isGrowSheet.value = false;
                                        controller.isChat.value = false;
                                        controller.isReport.value = false;
                                        controller.isTodo.value = false;
                                        controller.isCalender.value = true;
                                        controller.isSetting.value = false;
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
                                      }
                                      dashboardController.isOverView.value = false;
                                      calendarController.personalCalendar.value = false;
                                      calendarController.cropCalendar.value = true;
                                      controller.changeModuleIndex(4);
                                      Get.back();
                                    },
                                    image: AppImages.calender,
                                    title: AppStrings.calendar,
                                    isSelect: controller.isCalender.value,
                                    isRightWidget: true,
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
                                SizedBox(height: 40.h,)
                              ],
                            )
                                : const SizedBox.shrink()
                            )
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
            ? Get.isDarkMode ? AppColors.darkBlue : AppColors.lightAppbar : Colors.transparent,
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
              onTap: (){
                controller.isDeviceSetup.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
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
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(5);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isDeviceSetup
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.thermometer,
              title: AppStrings.temperatureControl,
              onTap: (){
                controller.isTemperatureControl.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isDeviceSetup.value = false;
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
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(6);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isTemperatureControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.humidity,
              title: AppStrings.humidityControl,
              onTap: (){
                controller.isHumidityControl.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isDeviceSetup.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(7);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isHumidityControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.cloud,
              title: AppStrings.co2Control,
              onTap: (){
                controller.isCo2Control.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isDeviceSetup.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(8);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isCo2Control
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.sun1,
              title: AppStrings.lightingControl,
              onTap: (){
                controller.isLightingControl.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isDeviceSetup.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(9);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isLightingControl
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.energy,
              title: AppStrings.energyManagement,
              onTap: (){
                controller.isEnergyManagement.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isDeviceSetup.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(10);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isEnergyManagement
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.wateringCan,
              title: AppStrings.irrigation,
              onTap: (){
                controller.isIrrigation.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isDeviceSetup.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(11);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isIrrigation
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.fertigation,
              title: AppStrings.fertigation,
              onTap: (){
                controller.isFertigation.value = true;
                controller.isDashboard.value = false;
                controller.isGrowSheet.value = false;
                controller.isChat.value = false;
                controller.isReport.value = false;
                controller.isTodo.value = false;
                controller.isCalender.value = false;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isDeviceSetup.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
                dashboardController.isOverView.value = false;
                controller.changeModuleIndex(12);
                controller.isCalender.value = false;
                Get.back();
              },
            isSelect: controller.isFertigation
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.lock,
              title: AppStrings.accessSettings,
              onTap: (){
                controller.isAccessSetting.value = true;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isDeviceSetup.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
              },
            isSelect: controller.isAccessSetting
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.briefcase,
              title: AppStrings.organisationSettings,
              onTap: (){
                controller.isOrganisationSettings.value = true;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isDeviceSetup.value = false;
                controller.isUserSetting.value = false;
                controller.isNotifications.value = false;
              },
            isSelect: controller.isOrganisationSettings
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.user,
              title: AppStrings.userSetting,
              onTap: (){
                controller.isUserSetting.value = true;
                controller.isTemperatureControl.value = false;
                controller.isHumidityControl.value = false;
                controller.isCo2Control.value = false;
                controller.isLightingControl.value = false;
                controller.isEnergyManagement.value = false;
                controller.isIrrigation.value = false;
                controller.isFertigation.value = false;
                controller.isAccessSetting.value = false;
                controller.isOrganisationSettings.value = false;
                controller.isDeviceSetup.value = false;
                controller.isNotifications.value = false;
              },
            isSelect: controller.isUserSetting
          ),
          SizedBox(height: 14.h,),
          settingCommonWidget(
              image: AppImages.notification,
              title: AppStrings.notifications,
              onTap: (){
                controller.isNotifications.value = true;
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
                controller.isDeviceSetup.value = false;
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
        color: isSelect.value == false ? Colors.transparent : Colors.white,
        child: Row(
          children: [
            SizedBox(width: 20.w,),
            Image.asset(
              image,
              height: 20.h,
              width: 20.w,
              color: Get.isDarkMode
                  ? AppColors.darkIcon
                  : isSelect.value == false
                  ? AppColors.lightGray1 : AppColors.buttonColor,
            ),
            SizedBox(width: 10.w,),
            CustomText(
              text: title,
              fontSize: 14.sp,
              color: Get.isDarkMode
                  ? AppColors.darkIcon
                  : isSelect.value == false
                  ? AppColors.lightGray1 : AppColors.buttonColor,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    ));
  }
}
