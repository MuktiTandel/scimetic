import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/to_do/model/company_user_model.dart';
import 'package:scimetic/feature/to_do/model/todo_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class TodoController extends GetxController {

  final dashBoardController = Get.put(DashboardController());

  RxBool isTodo = true.obs;
  RxBool isProgress = false.obs;
  RxBool isCompleted = false.obs;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  DateRangePickerController date = DateRangePickerController();

  RxInt descriptionLength = 0.obs;

  RxString selectValue = AppStrings.selectAssignName.obs;

  List<String> userNameList = [
    AppStrings.selectAssignName,
  ];

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  List<Todo> todoList = [];
  List<Todo> inProgressList = [];
  List<Todo> completedList = [];

  List<String> todoIdentifierList = [];
  List<String> inProgressIdentifierList = [];
  List<String> completedIdentifierList = [];

  TodoModel todoModel = TodoModel();

  CompanyUserModel companyUserModel = CompanyUserModel();

  Future getTodoList() async {

    isGetData.value = false;

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.todo,
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          todoModel = TodoModel.fromJson(data);

          if ( todoModel.todos!.toDo!.isNotEmpty ) {
            todoList.clear();
            todoList.addAll(todoModel.todos!.toDo!);
          }

          if ( todoModel.todos!.inProgress!.isNotEmpty ) {
            inProgressList.clear();
            inProgressList.addAll(todoModel.todos!.inProgress!);
          }

          if ( todoModel.todos!.completed!.isNotEmpty ) {
            completedList.clear();
            completedList.addAll(todoModel.todos!.completed!);
          }

          AppConst().debug("to do list length => ${todoList.length}");
          AppConst().debug("inProgress list length => ${inProgressList.length}");
          AppConst().debug("completed list length => ${completedList.length}");

          if ( todoList.isNotEmpty ) {
            for (var element in todoList) {
              for (var element1 in dashBoardController.dataList) {
                if ( element1.id == element.growspaceId ) {
                  todoIdentifierList.add(element1.identifier!);
                }
              }
            }
          }

          if ( inProgressList.isNotEmpty ) {
            for (var element in inProgressList) {
              for (var element1 in dashBoardController.dataList) {
                if ( element1.id == element.growspaceId ) {
                  inProgressIdentifierList.add(element1.identifier!);
                }
              }
            }
          }

          if ( completedList.isNotEmpty ) {
            for (var element in completedList) {
              for (var element1 in dashBoardController.dataList) {
                if ( element1.id == element.growspaceId ) {
                  completedIdentifierList.add(element1.identifier!);
                }
              }
            }
          }

          AppConst().debug("to do identifier list length => ${todoIdentifierList.length}");
          AppConst().debug("inProgress identifier list length => ${inProgressIdentifierList.length}");
          AppConst().debug("completed identifier list length => ${completedIdentifierList.length}");

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

  Future getCompanyUser() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.companyUsers,
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

         companyUserModel = CompanyUserModel.fromJson(data);

         if ( companyUserModel.users!.isNotEmpty ) {

           userNameList.clear();

           for (var element in companyUserModel.users!) {
             userNameList.add(element.name!);
           }

           AppConst().debug('user list length => ${userNameList.length}');

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

}