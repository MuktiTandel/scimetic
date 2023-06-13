import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_text.dart';
import 'package:scimetic/core/elements/scroll_behavior.dart';
import 'package:scimetic/feature/notification_setting/controller/notification_setting_controller.dart';

class NotificationSettingScreen extends StatelessWidget {
   NotificationSettingScreen({Key? key}) : super(key: key);

   final controller = Get.put(NotificationSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: ScrollConfiguration(
        behavior: AppBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15.w),
                color: context.theme.cardColor,
                child: Column(
                  children: [
                    commonTitleWidget(
                        image: AppImages.notification,
                        title: AppStrings.eventNotifications,
                        isSelect: controller.isEventNotifications,
                      onTap: () async {
                          if ( controller.isEventNotifications.value == true ) {
                            controller.isGroupMessage.value = true;
                            controller.notificationSettings.newGroupMessage = true;
                            controller.isDirectMessage.value = true;
                            controller.notificationSettings.newDirectMessage = true;
                            controller.isTodoEvent.value = true;
                            controller.notificationSettings.todoEvent = true;
                            controller.isCalendarEvent.value = true;
                            controller.notificationSettings.calendarEvent = true;
                            controller.isGrowSpaceStatus.value = true;
                            controller.notificationSettings.growspaceStatus = true;
                            controller.isDeviceStatus.value = true;
                            controller.notificationSettings.deviceStatus = true;
                            controller.isGrowSheetChanges.value = true;
                            controller.notificationSettings.growsheetChanges = true;
                          } else {
                            controller.isGroupMessage.value = false;
                            controller.notificationSettings.newGroupMessage = false;
                            controller.isDirectMessage.value = false;
                            controller.notificationSettings.newDirectMessage = false;
                            controller.isTodoEvent.value = false;
                            controller.notificationSettings.todoEvent = false;
                            controller.isCalendarEvent.value = false;
                            controller.notificationSettings.calendarEvent = false;
                            controller.isGrowSpaceStatus.value = false;
                            controller.notificationSettings.growspaceStatus = false;
                            controller.isDeviceStatus.value = false;
                            controller.notificationSettings.deviceStatus = false;
                            controller.isGrowSheetChanges.value = false;
                            controller.notificationSettings.growsheetChanges = false;
                          }
                          await controller.updateNotificationData();
                      }
                    ),
                    SizedBox(height: 15.h,),
                    commonWidget(
                        title: AppStrings.newGroupMessage,
                        isSelect: controller.isGroupMessage,
                        onTap: () async {
                          if ( controller.isGroupMessage.value == true ) {
                            controller.notificationSettings.newGroupMessage = true;
                          } else {
                            controller.notificationSettings.newGroupMessage = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.newDirectMessage,
                        isSelect: controller.isDirectMessage,
                        onTap: () async {
                          if ( controller.isDirectMessage.value == true ) {
                            controller.notificationSettings.newDirectMessage = true;
                          } else {
                            controller.notificationSettings.newDirectMessage = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.toDoEvents,
                        isSelect: controller.isTodoEvent,
                        onTap: () async {
                          if ( controller.isTodoEvent.value == true ) {
                            controller.notificationSettings.todoEvent = true;
                          } else {
                            controller.notificationSettings.todoEvent = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.calendarEvents,
                        isSelect: controller.isCalendarEvent,
                        onTap: () async {
                          if ( controller.isCalendarEvent.value == true ) {
                            controller.notificationSettings.calendarEvent = true;
                          } else {
                            controller.notificationSettings.calendarEvent = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.growspasesStatus,
                        isSelect: controller.isGrowSpaceStatus,
                        onTap: () async {
                          if ( controller.isGrowSpaceStatus.value == true ) {
                            controller.notificationSettings.growspaceStatus = true;
                          } else {
                            controller.notificationSettings.growspaceStatus = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.devicesStatus,
                        isSelect: controller.isDeviceStatus,
                        onTap: () async {
                          if ( controller.isDeviceStatus.value == true ) {
                            controller.notificationSettings.deviceStatus = true;
                          } else {
                            controller.notificationSettings.deviceStatus = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.growsheetChanges,
                        isSelect: controller.isGrowSheetChanges,
                        onTap: () async {
                          if ( controller.isGrowSheetChanges.value == true ) {
                            controller.notificationSettings.growsheetChanges = true;
                          } else {
                            controller.notificationSettings.growsheetChanges = false;
                          }
                          if ( controller.isGroupMessage.value == true
                              && controller.isDirectMessage.value == true
                              && controller.isTodoEvent.value == true
                              && controller.isCalendarEvent.value == true
                              && controller.isGrowSpaceStatus.value == true
                              && controller.isDeviceStatus.value == true
                              && controller.isGrowSheetChanges.value == true
                          ) {
                            controller.isEventNotifications.value = true;
                          } else {
                            controller.isEventNotifications.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              Container(
                padding: EdgeInsets.all(15.w),
                color: context.theme.cardColor,
                child: Column(
                  children: [
                    commonTitleWidget(
                        image: AppImages.settings,
                        title: AppStrings.notificationsSettings,
                        isSelect: controller.isNotificationSetting,
                      onTap: () async {
                          if ( controller.isNotificationSetting.value == true ) {
                            controller.isSmsNotification.value = true;
                            controller.notificationSettings.sms = true;
                            controller.isEmailNotification.value = true;
                            controller.notificationSettings.email = true;
                            controller.isMobileNotification.value = true;
                            controller.notificationSettings.push = true;
                          } else {
                            controller.isSmsNotification.value = false;
                            controller.notificationSettings.sms = false;
                            controller.isEmailNotification.value = false;
                            controller.notificationSettings.email = false;
                            controller.isMobileNotification.value = false;
                            controller.notificationSettings.push = false;
                          }

                          await controller.updateNotificationData();

                      }
                    ),
                    SizedBox(height: 15.h,),
                    commonWidget(
                        title: AppStrings.sMSNotifications,
                        isSelect: controller.isSmsNotification,
                        onTap: () async {
                          if ( controller.isSmsNotification.value == true ) {
                            controller.notificationSettings.sms = true;
                          } else {
                            controller.notificationSettings.sms = false;
                          }
                          if ( controller.isSmsNotification.value == true
                              && controller.isEmailNotification.value == true
                              && controller.isMobileNotification.value == true ) {
                            controller.isNotificationSetting.value = true;
                          } else {
                            controller.isNotificationSetting.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.emailNotifications,
                        isSelect: controller.isEmailNotification,
                        onTap: () async {
                          if ( controller.isEmailNotification.value == true ) {
                            controller.notificationSettings.email = true;
                          } else {
                            controller.notificationSettings.email = false;
                          }
                          if ( controller.isSmsNotification.value == true
                              && controller.isEmailNotification.value == true
                              && controller.isMobileNotification.value == true ) {
                            controller.isNotificationSetting.value = true;
                          } else {
                            controller.isNotificationSetting.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.mobileAppPushNotifications,
                        isSelect: controller.isMobileNotification,
                        onTap: () async {
                          if ( controller.isMobileNotification.value == true ) {
                            controller.notificationSettings.push = true;
                          } else {
                            controller.notificationSettings.push = false;
                          }
                          if ( controller.isSmsNotification.value == true
                              && controller.isEmailNotification.value == true
                              && controller.isMobileNotification.value == true ) {
                            controller.isNotificationSetting.value = true;
                          } else {
                            controller.isNotificationSetting.value = false;
                          }
                          await controller.updateNotificationData();
                        }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }

  Widget commonWidget({
    required String title,
    required RxBool isSelect,
    required VoidCallback onTap
  }
      ) {
    return Row(
      children: [
        CustomText(
          text: title,
          color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() => GestureDetector(
          onTap: (){
            isSelect.value = !isSelect.value;
            onTap();
          },
          child: Image.asset(
            isSelect.value == false
                ? Get.isDarkMode ? AppImages.darkUnselectToggle : AppImages.lightUnselectToggle
                : Get.isDarkMode ? AppImages.darkSelectedToggle : AppImages.lightSelectToggle,
            height: 35.h,
            width: 35.w,
          ),
        )),
        SizedBox(width: 5.w,),
        Obx(() => CustomText(
          text: isSelect.value == false
              ? AppStrings.off : AppStrings.on,
          color: isSelect.value
              ? Get.isDarkMode ? AppColors.darkText : AppColors.lightText
              : Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        )
        )
      ],
    );
  }

  Widget commonTitleWidget({
    required String image,
    required String title,
    required RxBool isSelect,
    required VoidCallback onTap
  }) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 18.h,
          width: 18.w,
          color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
        ),
        SizedBox(width: 10.w,),
        CustomText(
          text: title,
          color: Get.isDarkMode ? Colors.white : AppColors.subTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() => CustomText(
          text: isSelect.value == false ? AppStrings.allTurnOff : AppStrings.allTurnOn,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),),
        SizedBox(width: 5.w,),
        Obx(() => GestureDetector(
          onTap: (){
            isSelect.value = !isSelect.value;
            onTap();
          },
          child: Image.asset(
            isSelect.value == false
                ? Get.isDarkMode ? AppImages.darkUnselectToggle : AppImages.lightUnselectToggle
                : Get.isDarkMode ? AppImages.darkSelectedToggle : AppImages.lightSelectToggle,
            height: 35.h,
            width: 35.w,
          ),
        ))
      ],
    );
  }
}
