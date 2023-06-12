import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/access_setting/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;

class AccessSettingController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController keyController = TextEditingController(
    text: "235647"
  );

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  RxString chooseRoleValue = AppStrings.chooseRole.obs;

  RxString roleValue = "".obs;

  RxBool isObscureText = false.obs;

  RxBool isPinShow = false.obs;

  RxBool isEdit = false.obs;

  RxBool isCheckAll = false.obs;

  RxBool isSelect = false.obs;

  List<RxBool> selectList = [];

  List<RxBool> showList = [];

  RxList userList = [].obs;

  List<User> mainList = [];

  List<String> chooseRoleList = [
    AppStrings.superAdmin,
    AppStrings.companyOwner,
    AppStrings.companyAdmin,
    AppStrings.cropTechnician
  ];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  String decrypt(String encrypted) {
    final key = encrypt.Key.fromUtf8("1245714587458888"); //hardcode combination of 16 character
    final iv = encrypt.IV.fromUtf8("e16ce888a20dadb8"); //hardcode combination of 16 character

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    encrypt.Encrypted enBase64 = encrypt.Encrypted.from64(encrypted);
    final decrypted = encrypter.decrypt(enBase64, iv: iv);
    return decrypted;
  }

  Future getUserList() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      userList.clear();

      mainList.clear();

      isGetData.value = false;

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
                  url: '${ApiPath.baseUrl}${ApiPath.user}',
                  requestType: HTTPRequestType.GET,
                  headers: {
                    "Authorization" : 'Bearer $token',
                  }
              );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if ( apiResponse!.statusCode == 200 ) {

          UserModel userModel = UserModel.fromJson(data);

          if ( userModel.users!.isNotEmpty ) {

            userList.addAll(userModel.users!);

            mainList.addAll(userModel.users!);

            if ( userList.isNotEmpty ) {
              selectList = List.generate(userList.length, (index) => false.obs);
              showList = List.generate(userList.length, (index) => true.obs);
            }

          }

          showSnack(
              width: 200.w,
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

  }

  void onSave() async {

    isValid.value = true;

    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA"
    r"-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);

    final bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*'
    r'?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(pinController.text);

    if ( firstNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( lastNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( emailController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( roleValue.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( pinController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( emailValid == false ) {

      isValid.value = false;
      errorMessage.value = AppStrings.invalidEmail;

    } else if ( passwordValid == false ) {

      isValid.value = false;
      errorMessage.value = AppStrings.invalidPassword;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        Get.back();

        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        roleValue.value = "";
        pinController.clear();

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }
    }
  }

}