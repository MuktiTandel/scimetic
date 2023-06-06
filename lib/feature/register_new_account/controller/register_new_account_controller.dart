import 'dart:convert';

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
import 'package:scimetic/core/services/api_service.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/feature/register_new_account/model/create_user_model.dart';
import 'package:http/http.dart' as http;

class RegisterNewAccountController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController rPasswordController = TextEditingController();

  RxBool isCPassword = false.obs;
  RxBool isRPassword = false.obs;

  RxBool isValid = true.obs;

  RxBool isSuccess = false.obs;

  RxString errorMessage = "".obs;

  ApiService apiService = ApiService();

  http.Response? apiResponse;

  Future createUser(CreateUserModel userModel) async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
          url: ApiPath.baseUrl + ApiPath.register,
          requestType: HTTPRequestType.POST,
          headers: {
            "Content-Type" : "application/json"
          },
          parameter: userModel.toJson()
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      dynamic data = jsonDecode(apiResponse!.body);

      if ( apiResponse!.statusCode == 200 ) {

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

  void onRegister() async {

    isValid.value = true;

    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA"
    r"-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    final bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*'
    r'?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(cPasswordController.text);

    if ( nameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( emailController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( cPasswordController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( rPasswordController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( nameController.text.length < 4 ) {

      isValid.value = false;
      errorMessage.value = AppStrings.invalidFullName;

    } else if ( emailValid == false ) {

      isValid.value = false;
      errorMessage.value = AppStrings.invalidEmail;

    } else if ( passwordValid == false ) {

      isValid.value = false;
      errorMessage.value = AppStrings.invalidPassword;

    } else if ( !cPasswordController.text.contains(rPasswordController.text) ) {

      isValid.value = false;
      errorMessage.value = AppStrings.passwordNotMatch;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        progressDialog(true, Get.context!);

        String? firstName;
        String? lastName;

        if ( nameController.text.contains(' ')) {

          var name = nameController.text.split(" ");

          firstName = name[0];
          lastName = name[1];

        }

        AppConst().debug('first Name => $firstName');
        AppConst().debug('last Name => $lastName');
        AppConst().debug('email => ${emailController.text}');
        AppConst().debug('password => ${cPasswordController.text}');

        CreateUserModel userModel = CreateUserModel(
            firstName: firstName ?? nameController.text,
            lastName: lastName ?? "",
            email: emailController.text,
            password: cPasswordController.text
        );

         isSuccess.value = await createUser(userModel).whenComplete(() {
          progressDialog(false, Get.context!);
        });

         // if ( isSuccess.value == true ) {
         //   Get.offAllNamed(AppPages.AUTHENTICATEACOOUNT, arguments: { "email" : emailController.text });
         // }

        Get.offAllNamed(AppPages.AUTHENTICATEACOOUNT, arguments: { "email" : emailController.text });

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }

    }
  }

}