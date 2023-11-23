import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:path/path.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/profile_setting/model/user_profile.dart';

class ProfileSettingController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationKeyController =
      TextEditingController();
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

    if (name.value.isNotEmpty) {
      String firstName = "";
      String lastName = "";

      if (name.value.contains(' ')) {
        var name1 = name.value.split(" ");

        firstName = name1[0];
        lastName = name.value.contains(" ") ? name1[1] : "";

        firstNameController.text = firstName;
        lastNameController.text = lastName;
      }
    }

    if (email.value.isNotEmpty) {
      emailController.text = email.value;
    }
  }

  /// Get from gallery
  getFromGallery() async {
    try {
      isPick.value = false;

      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
      );

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
              "recoveryEmail": recoveryEmailController.text
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        progressDialog(false, Get.context!);
        storeData.setData(StoreData.userImage, data["user"]["imageURL"]);
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

  UserProfileModel userProfileModel = UserProfileModel();

  /// upload image
  Future uploadImage() async {
    token = storeData.getString(StoreData.accessToken)!;

    userId.value = storeData.getInt(StoreData.companyId) ?? 0;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {
        APIRequestInfo requestInfo = APIRequestInfo(
          url:
              "${ApiPath.baseUrl}${ApiPath.user}/${storeData.getData(StoreData.userId).toString()}/upload",
          requestType: HTTPRequestType.POST,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          parameter: {
            "fileName": basename(imageFile!.path),
          },
        );

        final apiResponse =
            await ApiCall.instance.callService(requestInfo: requestInfo);
        final signedUrlData = jsonDecode(apiResponse.body);
        final signedUrl = signedUrlData['url'];
        if (signedUrl != "") {
          APIRequestInfo requestInfo1 = APIRequestInfo(
              url: signedUrl,
              requestType: HTTPRequestType.PUT,
              // docList: [
              //   UploadDocument(docKey: "file", docPathList: [imageFile!.path])
              // ],
              headers: {
                'Content-Type': 'image/jpeg',
              },
              parameter: await imageFile!.readAsBytes());
          final apiResponse1 =
              await ApiCall.instance.callService(requestInfo: requestInfo1);
          if (apiResponse1.statusCode == 200) {
            APIRequestInfo getImage = APIRequestInfo(
              url:
                  "${ApiPath.baseUrl}${ApiPath.user}/${storeData.getData(StoreData.userId).toString()}/getURL",
              requestType: HTTPRequestType.GET,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
              // parameter: {
              //   imageFile,
              // },
            );
            final apiResponse2 =
                await ApiCall.instance.callService(requestInfo: getImage);
            var data = json.decode(apiResponse.body);
            print(apiResponse2.body);
            if (apiResponse2.statusCode == 200) {
              userProfileModel = userProfileModelFromJson(apiResponse2.body);
              imageUrl.value = userProfileModel.url.toString();
              print("userProfileModel.url.toString()");
              print(userProfileModel.url.toString());
              storeData.setData(StoreData.userImage, userProfileModel.url);
              update();
              showSnack(width: 200.w, title: data["message"]);
              progressDialog(false, Get.context!);
              return true;
            } else {
              showSnack(width: 200.w, title: data["message"]);
              progressDialog(false, Get.context!);

              return false;
            }
          }
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }
}
// var request = http.MultipartRequest(
        //   'PUT',
        //   Uri.parse("${ApiPath.baseUrl}${ApiPath.user}/${userId.value}/upload"),
        // );

        // Map<String, String> headers = {
        //   "Authorization": "Bearer $token",
        //   "Content-type": "multipart/form-data"
        // };

        // request.files.add(
        //   http.MultipartFile(
        //     'image',
        //     imageFile!.readAsBytes().asStream(),
        //     imageFile!.lengthSync(),
        //     filename: 'filename',
        //   ),
        // );
        // request.headers.addAll(headers);

        // AppConst().debug("url => ${request.url}");

        // var res = await request.send();
        // var response = await http.Response.fromStream(res);