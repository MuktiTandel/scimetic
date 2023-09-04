import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:http/http.dart' as http;

class ProfileSettingController extends GetxController {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController organizationNameController = TextEditingController();
  final TextEditingController organizationKeyController = TextEditingController();
  final TextEditingController recoveryEmailController = TextEditingController();

  StoreData storeData = StoreData();

  RxString name = "".obs;
  RxString email = "".obs;

  File? imageFile;

  final ImagePicker picker = ImagePicker();

  RxBool isPick = false.obs;

  RxInt userId = 0.obs;

  String token = "";

  http.Response? apiResponse;

  RxString imageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();

    name.value = storeData.getString(StoreData.userName) ?? "";
    email.value = storeData.getString(StoreData.userEmail) ?? "";

    AppConst().debug('name ==> ${name.value}');

    if ( name.value.isNotEmpty ) {

      String firstName = "";
      String lastName = "";

      if ( name.value.contains(' ')) {

        var name1 = name.value.split("  ");

        firstName = name1[0];
        lastName = name1[1];

        firstNameController.text = firstName;
        lastNameController.text = lastName;

      }

    }

    if ( email.value.isNotEmpty ) {

      emailController.text = email.value;

    }

  }

  /// Get from gallery
  getFromGallery() async {

    try {
      isPick.value = false;

      XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {

            isPick.value = true;

            imageFile = File(image.path);
          }
    } catch (e) {
      AppConst().debug('$e');
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

  /// Update profile api call
  Future updateProfile() async {

    token = storeData.getString(StoreData.accessToken)!;

    userId.value = storeData.getInt(StoreData.userId)!;

    if (token.isNotEmpty) {

      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.user}/${userId.value}',
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: {
              "email": emailController.text,
              "mobile": mobileNumberController.text,
              "name": "${firstNameController.text} ${lastNameController.text}",
              "recoveryEmail" : recoveryEmailController.text
            });

        apiResponse =
        await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);

        if (apiResponse!.statusCode == 200) {
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

    userId.value = storeData.getInt(StoreData.companyId) ?? 0;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {

        var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${ApiPath.baseUrl}${ApiPath.user}/${userId.value}/upload"),
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

        AppConst().debug("url => ${request.url}");

        var res = await request.send();
        var response = await http.Response.fromStream(res);
        AppConst().debug("This is response:${response.body}");
        AppConst().debug("This is response status code :${response.statusCode}");

        var data = json.decode(response.body);

        progressDialog(false, Get.context!);

        if (response.statusCode == 200) {

          imageUrl.value = data["image"];

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

}