import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_colors.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/calendar/model/event_model.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarController extends GetxController {

  RxBool isDay = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;
  RxBool isYear = false.obs;

  RxBool isCropWeek = true.obs;
  RxBool isCropMonth = false.obs;
  RxBool isMonth3 = false.obs;
  RxBool isMonth6 = false.obs;
  RxBool isCropYear = false.obs;

  RxBool personalCalendar = false.obs;
  RxBool cropCalendar = true.obs;

  List<String> cropCalendarType = [AppStrings.week,
    AppStrings.month, AppStrings.month3, AppStrings.month6, AppStrings.year];

  List<Event> eventList = [];

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  EventModel eventModel = EventModel();

  List<TimeRegion> dayEventList = [];

  getIndex() {

    DateTime selectedDate = DateTime.now();

    AppConst().debug('today day => ${selectedDate.weekday}');

    return selectedDate.weekday;
  }

  getDateList() {

    List<int> getDates = [];

    DateTime selectedDate = DateTime.now();

    int weekDay = selectedDate.weekday;

    if (weekDay == 5 ) {
      getDates.add(DateTime.now().add(Duration(days: weekDay - 9)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 8)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 7)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 6)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 5)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 4)).day);
      getDates.add(DateTime.now().add(Duration(days: weekDay - 3)).day);
    }

    return getDates;
  }

  Future getEventList() async {

    isGetData.value = false;

    eventList.clear();

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: ApiPath.baseUrl + ApiPath.events,
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          eventModel = EventModel.fromJson(data);

          if ( eventModel.events!.isNotEmpty ) {
            eventList.addAll(eventModel.events!);
          }

          if ( eventList.isNotEmpty ) {

            dayEventList.clear();

            for ( int i = 0; i < eventList.length; i++ ) {
              Event data = eventList[i];
              dayEventList.add(
                TimeRegion(
                  startTime: data.createdAt!.toLocal(),
                  endTime: DateFormat("dd.MM.yyyy").parse(data.dueDate!),
                  enablePointerInteraction: false,
                  color: i.isEven ? AppColors.blue : AppColors.orange,
                  text: data.description,
                  textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),
                ),
              );
            }

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