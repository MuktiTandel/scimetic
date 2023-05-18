import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';
import 'package:scimetic/feature/dashboard/model/growSpace_model.dart';

class DashboardController extends GetxController {

  RxBool isOverView = false.obs;

  RxBool isDark = Get.isDarkMode.obs;

  RxInt descriptionLength = 0.obs;

  RxBool isNotEmpty = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isEdit = false.obs;

  final TextEditingController growspaceNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dayHourController = TextEditingController();
  final TextEditingController dayMinuteController = TextEditingController();
  final TextEditingController nightHourController = TextEditingController();
  final TextEditingController nightMinuteController = TextEditingController();

  http.Response? apiResponse;

  GrowModel growModel = GrowModel();

  String token = "";

  StoreData storeData = StoreData();

  List<GrowController> dataList = [];

  RxBool isGetData = false.obs;

  RxBool isSelect = false.obs;

  Future getDataList() async {

    isGetData.value = false;

    dataList.clear();

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.growController,
            requestType: HTTPRequestType.GET,
          headers: {
            "Authorization" : 'Bearer $token',
          }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          growModel = GrowModel.fromJson(data);

          if ( growModel.growControllers!.isNotEmpty ) {
            dataList.addAll(growModel.growControllers!);
            isGetData.value = true;
          }

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

  Future createGrowSpace({required GrowspaceModel growspaceModel}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.growController,
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: {
              "name": growspaceModel.name,
              "identifier": growspaceModel.identifier,
              "location": growspaceModel.location,
              "description": growspaceModel.description,
              "dayStart": growspaceModel.dayStart,
              "nightStart": growspaceModel.nightStart
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {
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

  Future updateGrowSpace({required }) async {

  }

  Future onSave() async {

    isValid.value = true;

    final bool locationValidation = locationController.text.contains(",");

    if ( growspaceNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( locationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( serialNumberController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( descriptionController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( locationValidation == false ) {

      isValid.value = false;
      errorMessage.value = AppStrings.locationErrorMessage;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        GrowspaceModel growspaceModel = GrowspaceModel();

        growspaceModel.name = growspaceNameController.text;
        growspaceModel.identifier = serialNumberController.text;
        growspaceModel.description = descriptionController.text;
        growspaceModel.location = locationController.text;
        growspaceModel.dayStart = dayHourController.text.isNotEmpty ?
        "${dayHourController.text}"
            ":${dayMinuteController.text}" : "";
        growspaceModel.nightStart = nightHourController.text.isNotEmpty ?
        "${nightHourController.text}"
            ":${nightMinuteController.text}" : "";

        await createGrowSpace(growspaceModel: growspaceModel).whenComplete(() {
          Get.back();
          getDataList();
        });

        growspaceNameController.clear();
        serialNumberController.clear();
        descriptionController.clear();
        locationController.clear();
        dayHourController.clear();
        dayMinuteController.clear();
        nightHourController.clear();
        nightMinuteController.clear();

      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }

    }

  }

  @override
  void onInit() {
    super.onInit();
    getDataList();
  }
}