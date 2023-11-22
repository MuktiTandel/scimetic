import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/notification/model/message_model.dart';

class NotificationController extends GetxController {
  StoreData storeData = StoreData();

  MessageDataModel messageDataModel = MessageDataModel();
  Future<bool> getNotificationMsg() async {
    progressDialog(true, Get.context!);
    try {
      APIRequestInfo apiRequestInfo = APIRequestInfo(
          url: '${ApiPath.baseUrl}${ApiPath.getNotifications}',
          requestType: HTTPRequestType.POST,
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                'Bearer ${storeData.getString(StoreData.accessToken)}',
          },
          parameter: {
            "xGcId": "BAE01CC0",
            "customerSlug": "staging"
          });

      final apiResponse =
          await ApiCall.instance.callService(requestInfo: apiRequestInfo);
      dynamic data = jsonDecode(apiResponse.body);
      if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
        messageDataModel = messageDataModelFromJson(apiResponse.body);
        update();
      } else {
        showSnack(width: 200.w, title: data["message"] ?? "");
      }
      progressDialog(false, Get.context!);
      return true;
    } catch (e) {
      print(e);
      progressDialog(false, Get.context!);
      return false;
    }
  }
}
