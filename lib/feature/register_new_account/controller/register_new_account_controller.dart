import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/services/api_service.dart';
import 'package:scimetic/feature/register_new_account/model/create_user_model.dart';

class RegisterNewAccountController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController rPasswordController = TextEditingController();

  RxBool isCPassword = false.obs;
  RxBool isRPassword = false.obs;

  RxBool isValid = false.obs;

  ApiService apiService = ApiService();

  String? emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? userNameValidator(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Password must be at least 4 characters long.';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    return null;
  }

  void trySubmit() {

    if (nameController.text.isEmpty) {
      isValid.value = false;
    }

    // if (!isValid) {
    //   // formKey.currentState!.save();
    //
    //   CreateUserModel userModel = CreateUserModel(
    //       firstName: nameController.text,
    //       lastName: nameController.text,
    //       email: emailController.text,
    //       password: cPasswordController.text,
    //       connection: "Username-Password-Authentication"
    //   );
    //
    //   AppConst().debug("name => ${userModel.firstName}");
    //   AppConst().debug("email => ${userModel.email}");
    //   AppConst().debug("password => ${userModel.password}");
    //
    //   apiService.createUser(userModel).whenComplete(() {
    //     /* Get.offAllNamed(AppPages.AUTHENTICATEACOOUNT,
    //           arguments: {"email" : controller.emailController.value.text});*/
    //   });
    //
    // }
  }
}