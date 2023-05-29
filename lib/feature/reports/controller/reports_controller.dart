import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController batchIdController = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  DateRangePickerController startDateController = DateRangePickerController();
  DateRangePickerController endDateController = DateRangePickerController();

  RxString chooseSensor = AppStrings.temperature.obs;

  List<String> sensorList = [
    AppStrings.temperature,
    AppStrings.cO2,
    AppStrings.humidity,
    AppStrings.vpd
  ];

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxString identifier = "".obs;

  Future getReportData() async {

    isGetData.value = false;

    token =  storeData.getString(StoreData.accessToken)!;

    identifier.value = storeData.getString(StoreData.identifier)!;

    if ( token.isNotEmpty ) {

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.report}/${identifier.value}'
                '/live?sensor=$chooseSensor&start=${startDate.text}T00:00'
                ':00%2B05:30&end=${endDate.text}T23:59:59%2B05:30',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          isGetData.value = true;

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

  void onGenerate() async {

    isValid.value = true;

    if ( nameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( companyNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( batchIdController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( startDate.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( endDate.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        await getReportData();

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }

    }
  }

}