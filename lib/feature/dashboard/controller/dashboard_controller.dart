import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

class DashboardController extends GetxController {

  RxBool isOverView = false.obs;

  RxBool isDark = Get.isDarkMode.obs;

  RxInt descriptionLength = 0.obs;

  final TextEditingController growspaceNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  http.Response? apiResponse;

  GrowModel growModel = GrowModel();

  String token = "";

  StoreData storeData = StoreData();

  List<GrowController> dataList = [];

  RxBool isGetData = false.obs;

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

          AppConst().debug("data => ${growModel.growControllers}");

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

  @override
  void onInit() {
    getDataList();
  }
}