
import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/services/api_service.dart';
import 'package:scimetic/core/utils/store_data.dart';

class HumidityController extends GetxController {

  RxString dayHumiditySwitch = "".obs;
  RxString dayHumidityRelay = "".obs;

  RxString nightHumiditySwitch = "".obs;
  RxString nightHumidityRelay = "".obs;

  RxString dayDehumidificationSwitch = "".obs;
  RxString dayDehumidificationRelay = "".obs;

  RxString nightDehumidificationSwitch = "".obs;
  RxString nightDehumidificationRelay = "".obs;

  List<String> switchList = [];

  List<String> dayHumidityRelayList = [];

  List<String> nightHumidityRelayList = [];

  List<String> dayDehumidificationRelayList = [];

  List<String> nightDehumidificationRelayList = [];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  ApiService apiService = ApiService();

  Future getHumidityControllerData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if ( token.isNotEmpty ) {

      isGetData.value = false;

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.humidityControl}/${id.value}',
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
            switchList.addAll(apiService.switchList);
          }
          AppConst().debug('switch list length => ${switchList.length}');
          isGetData.value = true;
        });

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