import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_strings.dart';

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

  RxString roleValue = AppStrings.chooseRole.obs;

  RxBool isObscureText = false.obs;

  RxBool isPinShow = false.obs;

  List<String> chooseRoleList = [
    AppStrings.chooseRole
  ];

  List<String> roleList = [
    AppStrings.chooseRole
  ];

}