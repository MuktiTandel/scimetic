import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GrowSheetController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  final TextEditingController dayTemperatureController = TextEditingController();
  final TextEditingController dayRhController = TextEditingController();
  final TextEditingController dayCo2Controller = TextEditingController();
  final TextEditingController dayLightOnHourController = TextEditingController();
  final TextEditingController dayLightOnMinuteController = TextEditingController();
  final TextEditingController dayLightOffHourController = TextEditingController();
  final TextEditingController dayLightOffMinuteController = TextEditingController();

  final TextEditingController nightTemperatureController = TextEditingController();
  final TextEditingController nightRhController = TextEditingController();
  final TextEditingController nightCo2Controller = TextEditingController();
  final TextEditingController nightLightOnHourController = TextEditingController();
  final TextEditingController nightLightOnMinuteController = TextEditingController();
  final TextEditingController nightLightOffHourController = TextEditingController();
  final TextEditingController nightLightOffMinuteController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

}