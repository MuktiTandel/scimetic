import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/notification_setting/model/notification_setting_model.dart';

class NotificationSettingController extends GetxController {

  RxBool isEventNotifications = false.obs;
  RxBool isGroupMessage = false.obs;
  RxBool isDirectMessage = false.obs;
  RxBool isTodoEvent = false.obs;
  RxBool isCalendarEvent = false.obs;
  RxBool isGrowSpaceStatus = false.obs;
  RxBool isDeviceStatus = false.obs;
  RxBool isGrowSheetChanges = false.obs;
  RxBool isNotificationSetting = false.obs;
  RxBool isSmsNotification = false.obs;
  RxBool isEmailNotification = false.obs;
  RxBool isMobileNotification = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  NotificationSettings notificationSettings = NotificationSettings();

  NotificationSettingModel notificationSettingModel = NotificationSettingModel();

  Future getNotificationData() async {

    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {

      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.notificationSettings}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
        await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {

          notificationSettingModel = NotificationSettingModel.fromJson(data);

          notificationSettings = notificationSettingModel.notificationSettings ?? NotificationSettings();

          if ( notificationSettings.newGroupMessage == true ) {
            isGroupMessage.value = true;
          }

          if ( notificationSettings.newDirectMessage == true ) {
            isDirectMessage.value = true;
          }

          if ( notificationSettings.todoEvent == true ) {
            isTodoEvent.value = true;
          }

          if ( notificationSettings.calendarEvent == true ) {
            isCalendarEvent.value = true;
          }

          if ( notificationSettings.growspaceStatus == true ) {
            isGrowSpaceStatus.value = true;
          }

          if ( notificationSettings.deviceStatus == true ) {
            isDeviceStatus.value = true;
          }

          if ( notificationSettings.growsheetChanges == true ) {
            isGrowSheetChanges.value = true;
          }

          if ( isGroupMessage.value == true
              && isDirectMessage.value == true
              && isTodoEvent.value == true
              && isCalendarEvent.value == true
              && isGrowSpaceStatus.value == true
              && isDeviceStatus.value == true
              && isGrowSheetChanges.value == true
          ) {
            isEventNotifications.value = true;
          }

          if ( notificationSettings.sms == true ) {
            isSmsNotification.value = true;
          }

          if ( notificationSettings.email == true ) {
            isEmailNotification.value = true;
          }

          if (  notificationSettings.push == true ) {
            isMobileNotification.value = true;
          }

          if ( isSmsNotification.value == true
              && isEmailNotification.value == true
              && isMobileNotification.value == true ) {
            isNotificationSetting.value = true;
          }

          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }

  }

  Future updateNotificationData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      progressDialog(true, Get.context!);

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: "${ApiPath.baseUrl}${ApiPath.notificationSettings}",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: notificationSettings.toJson()
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if ( apiResponse!.statusCode == 200 ) {

          showSnack(
              width: 200.w,
              title: data["message"]
          );

          return true;
        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

}