import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/services/api_service.dart';

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

}