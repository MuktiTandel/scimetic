import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HumidityController extends GetxController {

  RxBool isOn = false.obs;

  final TextEditingController dayHumidityTarget = TextEditingController();
  final TextEditingController dayHumidityDeadband = TextEditingController();

}