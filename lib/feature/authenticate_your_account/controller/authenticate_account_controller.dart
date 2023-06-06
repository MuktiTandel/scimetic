
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:http/http.dart' as http;

class AuthenticateAccountController extends GetxController {

  String email = "";

  http.Response? apiResponse;

  RxInt code = 0.obs;

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments["email"];

    AppConst().debug('email => $email');

  }

  getEmail() {

    if ( email.isNotEmpty ) {

      String first = email
          .split("@")
          .first;
      String last = email
          .split("@")
          .last;

      String firstLatter = first.substring(0, 2);
      String lastLatter = first.substring(first.length - 2, first.length);

      String middleLatter = first.substring(2, first.length - 2);

      String middle = middleLatter.replaceRange(
          0, middleLatter.length, "*" * middleLatter.length);

      String email_ = "$firstLatter$middle$lastLatter@$last";

      return email_;

    } else {
      return "sh**********ab@gmail.com";
    }

  }

  Future sendVerificationCode() async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
        url: ApiPath.baseUrl + ApiPath.verificationCode,
        requestType: HTTPRequestType.POST,
        headers: {
          "Content-Type" : "application/json"
        },
        parameter: {
          "email" : email,
        },
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      dynamic data = jsonDecode(apiResponse!.body);

      AppConst().debug("Api response => ${apiResponse!.body}");

      if ( apiResponse!.statusCode == 200 ) {

        showSnack(
            width: 300.w,
            title: data["message"]
        );

        return true;

      } else {

        showSnack(
            width: 200.w,
            title: data["message"]
        );

        return false;

      }

    } catch (e) {

      AppConst().debug(e.toString());

    }

  }

  Future verifyAccount() async {

    progressDialog(true, Get.context!);

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
        url: ApiPath.baseUrl + ApiPath.verifyAccount,
        requestType: HTTPRequestType.POST,
        headers: {
          "Content-Type" : "application/json"
        },
        parameter: {
          "email" : email,
          "code" : code.value
        },
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.body}");

      dynamic data = jsonDecode(apiResponse!.body);

      progressDialog(false, Get.context!);

      if ( apiResponse!.statusCode == 200 ) {

        showSnack(
            width: 200.w,
            title: data["message"]
        );

        Get.offAllNamed(AppPages.LOGIN);

        return true;

      } else {

        showSnack(
            width: 200.w,
            title: data["message"]
        );

        return false;
      }

    } catch (e) {

      AppConst().debug(e.toString());

    }
  }
}