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
                color: Colors.white,
                child: Column(
                  children: [
                    commonTitleWidget(
                        image: AppImages.notification,
                        title: AppStrings.eventNotifications,
                        isSelect: controller.isEventNotifications
                    ),
                    SizedBox(height: 15.h,),
                    commonWidget(
                        title: AppStrings.newGroupMessage,
                        isSelect: controller.isGroupMessage
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.newDirectMessage,
                        isSelect: controller.isDirectMessage
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.toDoEvents,
                        isSelect: controller.isTodoEvent
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.calendarEvents,
                        isSelect: controller.isCalendarEvent
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.growspasesStatus,
                        isSelect: controller.isGrowSpaceStatus
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.devicesStatus,
                        isSelect: controller.isDeviceStatus
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.growsheetChanges,
                        isSelect: controller.isGrowSheetChanges
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              Container(
                padding: EdgeInsets.all(15.w),
                color: Colors.white,
                child: Column(
                  children: [
                    commonTitleWidget(
                        image: AppImages.settings,
                        title: AppStrings.notificationsSettings,
                        isSelect: controller.isNotificationSetting
                    ),
                    SizedBox(height: 15.h,),
                    commonWidget(
                        title: AppStrings.sMSNotifications,
                        isSelect: controller.isSmsNotification
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.emailNotifications,
                        isSelect: controller.isEmailNotification
                    ),
                    SizedBox(height: 10.h,),
                    commonWidget(
                        title: AppStrings.mobileAppPushNotifications,
                        isSelect: controller.isMobileNotification
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
    required RxBool isSelect}
      ) {
    return Row(
      children: [
        CustomText(
          text: title,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 13.sp,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() => GestureDetector(
          onTap: (){
            isSelect.value = !isSelect.value;
          },
          child: Image.asset(
            isSelect.value ? AppImages.lightUnselectToggle : AppImages.lightSelectToggle,
            height: 35.h,
            width: 35.w,
          ),
        )),
        SizedBox(width: 5.w,),
        Obx(() => CustomText(
          text: isSelect.value
              ? AppStrings.off : AppStrings.on,
          color: isSelect.value ? AppColors.lightText : AppColors.subTitleColor,
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
    required RxBool isSelect
  }) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 18.h,
          width: 18.w,
          color: AppColors.subTitleColor,
        ),
        SizedBox(width: 10.w,),
        CustomText(
          text: title,
          color: AppColors.subTitleColor,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        Expanded(child: SizedBox(width: 10.w,)),
        Obx(() => CustomText(
          text: isSelect.value ? AppStrings.allTurnOff : AppStrings.allTurnOn,
          color: AppColors.lightText,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),),
        SizedBox(width: 5.w,),
        Obx(() => GestureDetector(
          onTap: (){
            isSelect.value = !isSelect.value;
          },
          child: Image.asset(
            isSelect.value ? AppImages.lightUnselectToggle : AppImages.lightSelectToggle,
            height: 35.h,
            width: 35.w,
          ),
        ))
      ],
    );
  }
}
