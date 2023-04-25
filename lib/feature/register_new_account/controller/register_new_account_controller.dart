import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterNewAccountController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController rPasswordController = TextEditingController();

  RxBool isCPassword = false.obs;
  RxBool isRPassword = false.obs;


}