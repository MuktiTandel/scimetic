import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/organizations/model/company_model.dart';

class OrganizationSettingController extends GetxController {

  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController registrationNoController =
      TextEditingController();
  final TextEditingController licenseNoController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  RxString imageUrl = "".obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt companyId = 0.obs;

  File? imageFile;

  final ImagePicker picker = ImagePicker();

  RxBool isPick = false.obs;

  Company companyData = Company();

  CompanyResponseModel companyResponseModel = CompanyResponseModel();

  /// get company details
  Future getCompanyDetails() async {
    token = storeData.getString(StoreData.accessToken)!;

    companyId.value = storeData.getInt(StoreData.companyId) ?? 0;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.company}/${companyId.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
          if (data["company"] != null) {
            companyData = Company.fromJson(data["company"]);

            if (companyData.name != null) {
              organizationNameController.text = companyData.name ?? "";
              addressController.text = companyData.address ?? "";
              registrationNoController.text =
                  companyData.registrationNumber ?? "";
              licenseNoController.text = companyData.licenseNumber ?? "";
              mobileNoController.text = companyData.mobileNumber ?? "";
              emailController.text = companyData.email ?? "";
              websiteController.text = companyData.website ?? "";
              imageUrl.value = companyData.logo ?? "";
            }
          }

          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  /// update company details
  Future updateCompanyDetails() async {
    token = storeData.getString(StoreData.accessToken)!;

    companyId.value = storeData.getInt(StoreData.companyId) ?? 0;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.company}/${companyId.value}',
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: {
              "name" : organizationNameController.text,
              "address" : addressController.text,
              "email" : emailController.text,
              "licenseNumber" : licenseNoController.text,
              "mobileNumber" : mobileNoController.text,
              "registrationNumber" : registrationNoController.text,
              "website" : websiteController.text
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
          if (data["company"] != null) {
            companyData = Company.fromJson(data["company"]);
          }

          showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  /// upload image
  Future uploadImage() async {

    token = storeData.getString(StoreData.accessToken)!;

    companyId.value = storeData.getInt(StoreData.companyId) ?? 0;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {

        var request = http.MultipartRequest(
          'PUT', Uri.parse("${ApiPath.baseUrl}${ApiPath.company}/${companyId.value}/upload"),
        );

        Map<String,String> headers={
          "Authorization":"Bearer $token",
          "Content-type": "multipart/form-data"
        };

        request.files.add(
          http.MultipartFile(
            'image',
            imageFile!.readAsBytes().asStream(),
            imageFile!.lengthSync(),
            filename: 'filename',
          ),
        );
        request.headers.addAll(headers);

        print("request: "+request.toString());
        var res = await request.send();
        var response = await http.Response.fromStream(res);
        print("This is response:"+ "${response.body}");

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {

          // showSnack(width: 200.w, title: data["message"]);

          return true;
        } else {
          // showSnack(width: 200.w, title: data["message"]);

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }

  }

  /// Get from gallery
  getFromGallery() async {
    isPick.value = false;

    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      isPick.value = true;

      imageFile = File(image.path);
    }
  }

  /// Get from camera
  getFromCamera() async {
    isPick.value = false;

    XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      isPick.value = true;
      imageFile = File(photo.path);
    }
  }
}
