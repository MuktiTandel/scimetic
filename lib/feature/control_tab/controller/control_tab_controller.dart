import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/services/api_service.dart';

class ControlTabController extends GetxController {

  RxBool isBlackOutEnable = false.obs;
  RxBool isUvScreenEnable = false.obs;

  final TextEditingController blackOutScreenOpenController = TextEditingController();
  final TextEditingController blackOutScreenCloseController = TextEditingController();

  final TextEditingController timeOnHourController = TextEditingController();
  final TextEditingController timeOnMinuteController = TextEditingController();
  final TextEditingController timeOffHourController = TextEditingController();
  final TextEditingController timeOffMinuteController = TextEditingController();

  RxString blackOutSwitch = "".obs;

  List<String> switchList = [];

  RxString blackOutRelay = "".obs;

  List<String> blackOutRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4',
  ];

  final TextEditingController uVScreenOpenController = TextEditingController();
  final TextEditingController uVScreenCloseController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController deadBandController = TextEditingController();

  RxString uVScreenSwitch = "".obs;

  RxString uvScreenRelay = "".obs;

  List<String> uvScreenRelayList = [
    'Relay 1',
    'Relay 2',
    'Relay 3',
    'Relay 4',
  ];

  ApiService apiService = ApiService();

  Future getUvScreenData() async {

  }

}