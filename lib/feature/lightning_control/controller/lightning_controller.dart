import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LightningController extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController dayLightOnHour = TextEditingController();
  final TextEditingController dayLightOnMinute = TextEditingController();

  final TextEditingController dayLightOffHour = TextEditingController();
  final TextEditingController dayLightOffMinute = TextEditingController();

  final TextEditingController nightLightOnHour = TextEditingController();
  final TextEditingController nightLightOnMinute = TextEditingController();

  final TextEditingController nightLightOffHour = TextEditingController();
  final TextEditingController nightLightOffMinute = TextEditingController();

  RxDouble dayLightOutput = 45.0.obs;

  RxDouble nightLightOutput = 45.0.obs;

}