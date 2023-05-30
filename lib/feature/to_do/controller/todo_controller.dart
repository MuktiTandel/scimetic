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
import 'package:scimetic/feature/dashboard/controller/dashboard_controller.dart';
import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';
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

  User selectValue = User();

  List<User> userNameList = [];

  List<GrowController> growSpaceList = [];

  GrowController selectGrowSpace = GrowController();

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt assignedTo = 0.obs;

  RxInt growSpaceId = 0.obs;

  List<Todo> todoList = [];
  List<Todo> inProgressList = [];
  List<Todo> completedList = [];

  List<String> todoIdentifierList = [];
  List<String> inProgressIdentifierList = [];
  List<String> completedIdentifierList = [];

  TodoModel todoModel = TodoModel();

  CompanyUserModel companyUserModel = CompanyUserModel();

  RxBool isEdit = false.obs;
  
  Todo editTodo = Todo();

  Future getTodoList() async {

    growSpaceList.clear();

    growSpaceList.addAll(dashBoardController.dataList);

    if ( growSpaceList.isNotEmpty ) {
      growSpaceId.value = growSpaceList.first.id!;
    }

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
            todoIdentifierList.clear();
            for (var element in todoList) {
              for (var element1 in dashBoardController.dataList) {
                if ( element1.id == element.growspaceId ) {
                  todoIdentifierList.add(element1.identifier!);
                }
              }
            }
          }

          if ( inProgressList.isNotEmpty ) {
            inProgressIdentifierList.clear();
            for (var element in inProgressList) {
              for (var element1 in dashBoardController.dataList) {
                if ( element1.id == element.growspaceId ) {
                  inProgressIdentifierList.add(element1.identifier!);
                }
              }
            }
          }

          if ( completedList.isNotEmpty ) {
            completedIdentifierList.clear();
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
             userNameList.add(element);
           }

           AppConst().debug('user list length => ${userNameList.length}');

         }

         if ( userNameList.isNotEmpty ) {
           assignedTo.value = userNameList.first.id!;
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

  Future createTask({required Todo todo}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.todo,
            requestType: HTTPRequestType.POST,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: {
              "dueDate" : todo.dueDate,
              "tag" : todo.tag,
              "assignedTo" : todo.assignedTo,
              "description" : todo.description,
              "stage" : todo.stage,
              "growspaceId" : todo.growspaceId
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

  Future deleteTodo({required int id}) async {

    bool isConnected = await checkNetConnectivity();

    if ( isConnected == true ) {

      token = storeData.getString(StoreData.accessToken)!;

      if (token.isNotEmpty) {
        try {
          APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: "${ApiPath.baseUrl}${ApiPath.todo}/$id",
              requestType: HTTPRequestType.DELETE,
              headers: {
                "Authorization": 'Bearer $token',
              },
          );

          apiResponse =
          await ApiCall.instance.callService(requestInfo: apiRequestInfo);

          AppConst().debug("Api response => ${apiResponse!.statusCode}");

          dynamic data = jsonDecode(apiResponse!.body);

          if (apiResponse!.statusCode == 200) {

            return true;
          } else {
            if (apiResponse!.statusCode == 403) {
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
    } else {
      showSnack(
          title: AppStrings.noInternetConnection,
          width: 200.w
      );
    }


  }

  Future updateTodo({required Todo todo}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: "${ApiPath.baseUrl}${ApiPath.todo}/${todo.id}",
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization" : 'Bearer $token',
              "Content-Type" : "application/json"
            },
            parameter: todo.toJson()
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

    if ( descriptionController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( dateTimeController.text.isEmpty ) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else if ( tagController.text.isEmpty && isTodo.value == true) {

      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;

    } else {
      
      if ( isEdit.value == false ) {
        Todo data = Todo();

        data.dueDate = dateTimeController.text;
        data.tag = tagController.text;
        data.assignedTo = assignedTo.value;
        data.description = descriptionController.text;
        data.growspaceId = growSpaceId.value;

        if (isTodo.value == true) {
          data.stage = "toDo";
        } else if (isProgress.value == true) {
          data.stage = "inProgress";
        } else {
          data.stage = "completed";
        }

        await createTask(todo: data).whenComplete(() async {
          Get.back();
          await getTodoList();
        });
        
      } else {
        
        Todo data = editTodo;
        
        data.description = descriptionController.text;
        data.dueDate = dateTimeController.text;
        if ( isTodo.value == true ) {
          data.tag = tagController.text;
        }
        data.assignedTo = assignedTo.value;
        data.growspaceId = growSpaceId.value;
        
        await updateTodo(todo: data).whenComplete(() async {
          isEdit.value = false;
          Get.back();
          await getTodoList();
        });
      }

      descriptionController.clear();
      tagController.clear();
      dateTimeController.clear();

    }

  }

}