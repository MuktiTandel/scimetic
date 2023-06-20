import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/organizations/model/company_model.dart';

class OrganizationController extends GetxController {

  RxBool isSelect = false.obs;

  final TextEditingController searchController = TextEditingController();

  final TextEditingController organizationNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  http.Response? apiResponse;

  String token = "";

  StoreData storeData = StoreData();

  CompanyResponseModel companyResponseModel = CompanyResponseModel();

  RxList dataList = [].obs;

  List<Company> mainList = [];

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxInt roleId = 0.obs;

  RxBool isGrowSpaces = false.obs;

  RxBool isUser = false.obs;

  Future getDataList() async {

    bool isConnected = await checkNetConnectivity();

    if ( isConnected == true ) {

      isGetData.value = false;

      dataList.clear();

      mainList.clear();

      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: ApiPath.baseUrl + ApiPath.company,
              requestType: HTTPRequestType.GET,
              headers: {
                "Authorization": 'Bearer $token',
              }
          );

          apiResponse =
          await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

          if (apiResponse!.statusCode == 200) {

            companyResponseModel = CompanyResponseModel.fromJson(data);

            AppConst().debug('companies => ${companyResponseModel.companies!.length}');

            if (companyResponseModel.companies!.isNotEmpty) {
              mainList.addAll(companyResponseModel.companies!);
              dataList.addAll(companyResponseModel.companies!);
              isGetData.value = true;
            }

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
    } else {
      showSnack(
          title: AppStrings.noInternetConnection,
          width: 200.w
      );
    }
  }

  Future addOrganization({required Company company}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.company,
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: {
              "name": company.name,
              "address": company.address,
              "contactNumber": company.mobileNumber,
              "email": company.email,
              "website": company.website,
              "registrationNumber": company.registrationNumber,
              "licenseNumber": company.licenseNumber
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

  void onSave() async {

    isValid.value = true;

    if ( organizationNameController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( addressController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( mobileNumberController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( emailController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( websiteController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( registrationController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( licenseNumberController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {

      bool isConnected = await checkNetConnectivity();

      if ( isConnected == true ) {

        Company company = Company();

        company.name = organizationNameController.text;
        company.address = addressController.text;
        company.mobileNumber = mobileNumberController.text;
        company.email = emailController.text;
        company.website = websiteController.text;
        company.registrationNumber = registrationController.text;
        company.licenseNumber = licenseNumberController.text;

        await addOrganization(company: company).whenComplete(() async {

          organizationNameController.clear();
          addressController.clear();
          mobileNumberController.clear();
          emailController.clear();
          websiteController.clear();
          registrationController.clear();
          licenseNumberController.clear();

          Get.back();
          await getDataList();
        });


      } else {

        showSnack(
            title: AppStrings.noInternetConnection,
            width: 200.w
        );

      }
    }

  }

  Future deleteOrganization({required int id}) async {

    bool isConnected = await checkNetConnectivity();

    if ( isConnected == true ) {

      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: "${ApiPath.baseUrl}${ApiPath.company}/$id",
              requestType: HTTPRequestType.DELETE,
              headers: {
                "Authorization": 'Bearer $token',
              }
          );

          apiResponse =
          await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

          if (apiResponse!.statusCode == 200) {

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
    } else {
      showSnack(
          title: AppStrings.noInternetConnection,
          width: 200.w
      );
    }

  }

  @override
  void onInit() {
    super.onInit();

    roleId.value = storeData.getInt(StoreData.roleId)!;

    if ( roleId.value == 1 ) {
      getDataList();
    }
  }
}