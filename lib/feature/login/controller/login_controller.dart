import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/routes/app_pages.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/login/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/login/model/login_response_model.dart';

class LoginController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isValid = true.obs;

  RxBool isObscure = false.obs;

  RxString errorMessage = "".obs;

  http.Response? apiResponse;

  LoginResponseModel loginResponseModel = LoginResponseModel();

  StoreData storeData = StoreData();

  Future loginUser(LoginModel loginModel) async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
        url: ApiPath.baseUrl + ApiPath.login,
        requestType: HTTPRequestType.POST,
        headers: {
          "Content-Type" : "application/json"
        },
        parameter: {
          "username": loginModel.username,
          "password" : loginModel.password
        },
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.statusCode}");

      dynamic data = jsonDecode(apiResponse!.body);

      if ( apiResponse!.statusCode == 200 ) {

        loginResponseModel = LoginResponseModel.fromJson(data);

        AppConst().debug("accessToken => ${loginResponseModel.accessToken}");

        storeData.setData(StoreData.accessToken, loginResponseModel.accessToken);

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

  Future userLogin() async {

    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA"
    r"-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    final bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*'
    r'?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(passwordController.text);

    if ( emailController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( passwordController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( emailValid == false) {

        isValid.value = false;
        errorMessage.value = AppStrings.invalidEmail;

    } else if ( passwordValid == false ) {

        isValid.value = false;
        errorMessage.value = AppStrings.invalidPassword;

    } else {

      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        progressDialog(true, Get.context!);

        isValid.value = true;

        LoginModel loginModel = LoginModel(
            username: emailController.text,
            password: passwordController.text
        );

        bool isCall = await loginUser(loginModel).whenComplete(() {
          progressDialog(false, Get.context!);
        });

        if (isCall) {
          Get.offAllNamed(AppPages.HOME);
        }
      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }

    }

  }

}