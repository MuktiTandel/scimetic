import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/fertigation_control/model/fertigation_control_model.dart';
import 'package:scimetic/feature/fertigation_control/model/fertigation_model.dart';

class FertigationController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  RxString placeHolderValue = AppStrings.placeholder.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController dayIngredientController = TextEditingController();
  final TextEditingController dayQuantityController = TextEditingController();

  final TextEditingController nightIngredientController =
      TextEditingController();
  final TextEditingController nightQuantityController = TextEditingController();

  RxInt descriptionLength = 0.obs;

  RxBool isSelect = false.obs;

  RxBool isApply = false.obs;

  RxBool isEdit = false.obs;

  RxBool isCheckAll = false.obs;

  List<RxBool> showList = [];

  List<RxBool> selectList = [];

  List<TextEditingController> dayIngredientList = [TextEditingController()];

  List<TextEditingController> dayQuantityList = [TextEditingController()];

  List<TextEditingController> nightIngredientList = [TextEditingController()];

  List<TextEditingController> nightQuantityList = [TextEditingController()];

  RxDouble listHeight = 90.0.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  RxBool isGetData = false.obs;

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxList fertigationList = [].obs;

  List<FertigationControl> mainList = [];

  FertigationModel fertigationModel = FertigationModel();

  List<int> fertigationControlIds = [];

  RxBool dayIngredient = false.obs;

  RxBool dayQuantity = false.obs;

  RxBool nightIngredient = false.obs;

  RxBool nightQuantity = false.obs;

  List<Formula1> formulaList = [];

  List<RxBool> appliedList = [];

  RxInt fertigationId = 0.obs;

  List<bool> checkList = [];

  Future getFertigationControlData() async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      fertigationList.clear();

      mainList.clear();

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.fertigationControl}/${id.value}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

        if (apiResponse!.statusCode == 200) {
          fertigationModel = FertigationModel.fromJson(data);

          if (fertigationModel.fertigationControls!.isNotEmpty) {
            fertigationList.addAll(fertigationModel.fertigationControls!);
            mainList.addAll(fertigationModel.fertigationControls!);
          }

          if (fertigationList.isNotEmpty) {
            showList =
                List.generate(fertigationList.length, (index) => false.obs);

            selectList =
                List.generate(fertigationList.length, (index) => false.obs);

            appliedList =
                List.generate(fertigationList.length, (index) => false.obs);
          }

          if (appliedList.isNotEmpty) {
            for (int i = 0; i < fertigationList.length; i++) {
              FertigationControl data = fertigationList[i];

              if (data.applied == true) {
                appliedList[i].value = true;
              }
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

  Future addFertigationControlData(
      {required FertigationControlModel fertigationControlModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    id.value = storeData.getInt(StoreData.id)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.fertigationControl}/${id.value}',
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: fertigationControlModel.toJson());

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

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

  Future deleteFertigationControl() async {
    bool isConnected = await checkNetConnectivity();

    if (isConnected == true) {
      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: "${ApiPath.baseUrl}${ApiPath.fertigationControl}",
              requestType: HTTPRequestType.DELETE,
              headers: {
                "Authorization": 'Bearer $token',
                "Content-Type": "application/json"
              },
              parameter: {
                "fertigationControlIds": fertigationControlIds
              });

          apiResponse =
              await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

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
    } else {
      showSnack(title: AppStrings.noInternetConnection, width: 200.w);
    }
  }

  Future toggleApply({required bool applied, required int id}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                "${ApiPath.baseUrl}${ApiPath.fertigationControl}/$id/toggle_apply",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: {
              "applied": applied
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
          if (apiResponse!.statusCode == 403) {
            showSnack(width: 200.w, title: data["message"]);
          }

          return false;
        }
      } catch (e) {
        AppConst().debug(e.toString());
      }
    }
  }

  Future updateFertigationControl(
      {required FertigationControlModel fertigationControlModel}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      isGetData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                '${ApiPath.baseUrl}${ApiPath.fertigationControl}/${fertigationId.value}',
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: fertigationControlModel.toJson());

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        isGetData.value = true;

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

  void onSave() async {
    isValid.value = true;

    dayIngredient.value = false;

    dayQuantity.value = false;

    nightQuantity.value = false;

    nightIngredient.value = false;

    for (var element in dayIngredientList) {
      if (element.text.isEmpty) {
        dayIngredient.value = true;
      }
    }

    for (var element in dayQuantityList) {
      if (element.text.isEmpty) {
        dayQuantity.value = true;
      }
    }

    for (var element in nightIngredientList) {
      if (element.text.isEmpty) {
        nightIngredient.value = true;
      }
    }

    for (var element in nightQuantityList) {
      if (element.text.isEmpty) {
        nightQuantity.value = true;
      }
    }

    if (dayIngredient.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (dayQuantity.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightIngredient.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nightQuantity.value == true) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (nameController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (tagController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (descriptionController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else {
      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        FertigationControlModel fertigationControlModel =
            FertigationControlModel();

        fertigationControlModel.name = nameController.text;
        fertigationControlModel.description = descriptionController.text;
        fertigationControlModel.tag = tagController.text;

        Formula1 formula1 = Formula1();

        for (int i = 0; i < dayIngredientList.length; i++) {
          formula1.dayIngredient = dayIngredientList[i].text;
          formula1.dayQuantity = int.parse(dayQuantityList[i].text);
          formula1.nightIngredient = nightIngredientList[i].text;
          formula1.nightQuantity = nightQuantityList[i].text;

          formulaList.add(formula1);
        }

        fertigationControlModel.formulas = formulaList;

        if (isEdit.value == false) {
          await addFertigationControlData(
                  fertigationControlModel: fertigationControlModel)
              .whenComplete(() async {
            Get.back();
            await getFertigationControlData();
          });
        } else {
          await updateFertigationControl(
                  fertigationControlModel: fertigationControlModel)
              .whenComplete(() async {
                isEdit.value = false;
                Get.back();
                await getFertigationControlData();
          });
        }

        nameController.clear();
        tagController.clear();
        descriptionController.clear();
        for (var element in dayIngredientList) {
          element.clear();
        }
        for (var element in dayQuantityList) {
          element.clear();
        }
        for (var element in nightIngredientList) {
          element.clear();
        }
        for (var element in nightQuantityList) {
          element.clear();
        }
      } else {
        showSnack(title: AppStrings.noInternetConnection, width: 200.w);
      }
    }
  }
}
