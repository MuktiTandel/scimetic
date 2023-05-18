import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/growsheet/model/growsheet_model.dart';

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

  RxInt descriptionLength = 0.obs;

  RxString placeHolderValue = AppStrings.placeholder.obs;

  List<String> placeHolderList = [
    AppStrings.placeholder
  ];

  RxString strainValue = AppStrings.chooseStrain.obs;

  List<String> strainNameList = [
    AppStrings.chooseStrain
  ];

  RxString seedBankValue = AppStrings.chooseSeedBank.obs;

  List<String> seedBankList = [
    AppStrings.chooseSeedBank
  ];

  RxString tagValue = AppStrings.chooseTag.obs;

  List<String> tagList = [
    AppStrings.chooseTag
  ];

  RxString irrigationValue = AppStrings.chooseSchedule.obs;

  List<String> irrigationList = [
    AppStrings.chooseSchedule
  ];

  RxString fertigationValue1 = AppStrings.chooseSchedule.obs;

  List<String> fertigationList1 = [
    AppStrings.chooseSchedule
  ];

  RxString fertigationValue2 = AppStrings.chooseSchedule.obs;

  List<String> fertigationList2 = [
    AppStrings.chooseSchedule
  ];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  GrowSheetData growSheetData = GrowSheetData();

  List<GrowSheet> growSheetDataList = [];

  RxBool isGetData = false.obs;

  Future getGrowSheetData({required int id}) async {

    isGetData.value = false;

    growSheetDataList.clear();

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetGrowController}/$id',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          growSheetData = GrowSheetData.fromJson(data);

          if ( growSheetData.growsheets!.isNotEmpty ) {
            growSheetDataList.addAll(growSheetData.growsheets!);
            isGetData.value = true;
          }

          AppConst().debug('grow sheet data => ${growSheetData.growsheets}');

          return true;
        } else {

          if ( apiResponse!.statusCode == 403 ) {

            showSnack(
                width: 200.w,
                title: data["message"]
            );
          }

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

}