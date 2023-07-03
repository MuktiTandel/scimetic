import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/utils/store_data.dart';

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

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  Future getUvScreenData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      progressDialog(true, Get.context!);

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.blackoutScreen}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        await apiService.getSwitchData().whenComplete(() {
          if ( apiService.switchList.isNotEmpty ) {
            switchList.clear();
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');
        });

        progressDialog(false, Get.context!);

        isGetData.value = true;

        if ( apiResponse!.statusCode == 200 ) {

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

}