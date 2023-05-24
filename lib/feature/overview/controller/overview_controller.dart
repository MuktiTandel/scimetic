import 'dart:convert';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:scimetic/feature/overview/element/month_graph.dart';
import 'package:scimetic/feature/overview/element/week_graph.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/overview/model/climate_model.dart';
import 'package:scimetic/feature/overview/model/device_model.dart';
import 'package:scimetic/feature/growsheet/model/growsheet_model.dart';

class OverviewController extends GetxController {

  RxBool isTemperature = false.obs;
  RxBool isElectricalLoad = false.obs;
  RxBool isCo2 = false.obs;
  RxBool isLightning = false.obs;
  RxBool isVdp = false.obs;

  RxBool isHour = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;

  RxString chooseItem = "".obs;

  RxDouble minTemperatureHourY = 0.0.obs;
  RxDouble maxTemperatureHourY = 0.0.obs;

  RxDouble minTemperatureWeekY = 0.0.obs;
  RxDouble maxTemperatureWeekY = 0.0.obs;

  RxDouble minTemperatureMonthY = 0.0.obs;
  RxDouble maxTemperatureMonthY = 0.0.obs;

  RxDouble minHumidityHourY = 0.0.obs;
  RxDouble maxHumidityHourY = 0.0.obs;

  RxDouble minHumidityWeekY = 0.0.obs;
  RxDouble maxHumidityWeekY = 0.0.obs;

  RxDouble minHumidityMonthY = 0.0.obs;
  RxDouble maxHumidityMonthY = 0.0.obs;

  RxDouble minCo2HourY = 0.0.obs;
  RxDouble maxCo2HourY = 0.0.obs;

  RxDouble minCo2WeekY = 0.0.obs;
  RxDouble maxCo2WeekY = 0.0.obs;

  RxDouble minCo2MonthY = 0.0.obs;
  RxDouble maxCo2MonthY = 0.0.obs;

  RxDouble minLightningHourY = 0.0.obs;
  RxDouble maxLightningHourY = 0.0.obs;

  RxDouble minLightningWeekY = 0.0.obs;
  RxDouble maxLightningWeekY = 0.0.obs;

  RxDouble minLightningMonthY = 0.0.obs;
  RxDouble maxLightningMonthY = 0.0.obs;

  RxDouble minVpdHourY = 0.0.obs;
  RxDouble maxVpdHourY = 0.0.obs;

  RxDouble minVpdWeekY = 0.0.obs;
  RxDouble maxVpdWeekY = 0.0.obs;

  RxDouble minVpdMonthY = 0.0.obs;
  RxDouble maxVpdMonthY = 0.0.obs;

  List<double> temperatureHourYList = [];
  List<double> temperatureWeekYList = [];
  List<double> temperatureMonthYList = [];

  List<double> humidityHourYList = [];
  List<double> humidityWeekYList = [];
  List<double> humidityMonthYList = [];

  List<double> co2HourYList = [];
  List<double> co2WeekYList = [];
  List<double> co2MonthYList = [];

  List<double> lightningHourYList = [];
  List<double> lightningWeekYList = [];
  List<double> lightningMonthYList = [];

  List<double> vpdHourYList = [];
  List<double> vpdWeekYList = [];
  List<double> vpdMonthYList = [];

  List<HourData> temperatureHourDataList = [];

  List<WeekData> temperatureWeekDataList = [];

  List<MonthData> temperatureMonthDataList = [
    MonthData(0, 22),
    MonthData(5, 24),
    MonthData(10, 24),
    MonthData(15, 25),
    MonthData(20, 25),
    MonthData(25, 24),
    MonthData(30, 24),
    MonthData(31, 24),
  ];

  List<WeekData> electricalWeekDataList = [];

  List<MonthData> electricalMonthDataList = [
    MonthData(0, 84),
    MonthData(5, 84),
    MonthData(10, 85),
    MonthData(15, 85),
    MonthData(20, 86),
    MonthData(25, 86),
    MonthData(30, 84),
    MonthData(31, 84),
  ];

  List<HourData> electricalHourDataList = [
  ];

  List<HourData> co2HourDataList = [
  ];

  List<WeekData> co2WeekDataList = [];

  List<MonthData> co2MonthDataList = [
    MonthData(0, 750),
    MonthData(5, 750),
    MonthData(10, 760),
    MonthData(15, 760),
    MonthData(20, 780),
    MonthData(25, 780),
    MonthData(30, 760),
    MonthData(31, 760),
  ];

  List<HourData> lightningHourDataList = [
  ];

  List<WeekData> lightningWeekDataList = [];

  List<MonthData> lightningMonthDataList = [
    MonthData(0, 42),
    MonthData(5, 43),
    MonthData(10, 44),
    MonthData(15, 45),
    MonthData(20, 46),
    MonthData(25, 42),
    MonthData(30, 41),
    MonthData(31, 40),
  ];

  List<HourData> vdpHourDataList = [
  ];

  List<WeekData> vdpWeekDataList = [];

  List<MonthData> vdpMonthDataList = [
    MonthData(0, 0.95),
    MonthData(5, 0.96),
    MonthData(10, 0.97),
    MonthData(15, 0.98),
    MonthData(20, 0.99),
    MonthData(25, 0.96),
    MonthData(30, 0.94),
    MonthData(31, 0.93),
  ];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  GrowSheetData growSheetData = GrowSheetData();

  ClimateModel climateData = ClimateModel();

  DeviceModel deviceModel = DeviceModel();

  RxBool isGetData = false.obs;

  RxBool isOverview = false.obs;

  RxBool isClimateData = false.obs;

  List<ClimateData> climateDataList = [];

  Future getGrowSheetData({required int id}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetGrowController}/$id?applied=true',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          growSheetData = GrowSheetData.fromJson(data);

          AppConst().debug('grow sheet data => ${growSheetData.growsheets}');

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

  Future getClimateData({required String identifier, required String range}) async {
    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {

      isClimateData.value = false;

      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growController}/$identifier/climate?range=$range',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          climateData = ClimateModel.fromJson(data);

          AppConst().debug('grow sheet data => ${climateData.growspace}');

          if ( climateData.climateData!.isNotEmpty ) {
            isClimateData.value = true;
            climateDataList.addAll(climateData.climateData!);
            if ( climateDataList.isNotEmpty ) {
              if ( isHour.value == true ) {
                temperatureHourDataList.clear();
                electricalHourDataList.clear();
                co2HourDataList.clear();
                lightningHourDataList.clear();
                vdpHourDataList.clear();
                for (var element in climateDataList) {
                  HourData temperatureData = HourData(
                      element.time!, element.temperature!);
                  temperatureHourDataList.add(temperatureData);
                  temperatureHourDataList.sort((a, b) => a.x.compareTo(b.x));
                  HourData humidityData = HourData(
                      element.time!, element.humidity!);
                  electricalHourDataList.add(humidityData);
                  electricalHourDataList.sort((a, b) => a.x.compareTo(b.x));
                  HourData co2Data = HourData(element.time!, element.co2!);
                  co2HourDataList.add(co2Data);
                  co2HourDataList.sort((a, b) => a.x.compareTo(b.x));
                  HourData vpdData = HourData(element.time!, element.vpd!);
                  vdpHourDataList.add(vpdData);
                  vdpHourDataList.sort((a, b) => a.x.compareTo(b.x));
                  HourData lightningData = HourData(element.time!, element.mol!.toDouble());
                  lightningHourDataList.add(lightningData);
                  lightningHourDataList.sort((a, b) => a.x.compareTo(b.x));
                }
              }
            }
            if ( isHour.value == true ) {
              if (temperatureHourDataList.isNotEmpty) {
                for (var element in temperatureHourDataList) {
                  temperatureHourYList.add(element.y);
                }
                if (temperatureHourYList.isNotEmpty) {
                  AppConst().debug(
                      "${temperatureHourYList.cast<double>().reduce(min)}");
                  AppConst().debug(
                      "${temperatureHourYList.cast<double>().reduce(max)}");
                  minTemperatureHourY.value =
                      temperatureHourYList.cast<double>().reduce(min);
                  maxTemperatureHourY.value =
                      temperatureHourYList.cast<double>().reduce(max);
                }
              }
              if (electricalHourDataList.isNotEmpty) {
                for (var element in electricalHourDataList) {
                  humidityHourYList.add(element.y);
                }
                if (electricalHourDataList.isNotEmpty) {
                  minHumidityHourY.value =
                      humidityHourYList.cast<double>().reduce(min);
                  maxHumidityHourY.value =
                      humidityHourYList.cast<double>().reduce(max);
                  AppConst().debug(
                      "humidity hour min y${minHumidityHourY.value}");
                  AppConst().debug(
                      "humidity hour max y ${maxHumidityHourY.value}");
                }
              }
              if ( co2HourDataList.isNotEmpty ) {
                for (var element in co2HourDataList) {
                  co2HourYList.add(element.y);
                }
                if ( co2HourYList.isNotEmpty ) {
                  minCo2HourY.value =  co2HourYList.cast<double>().reduce(min);
                  maxCo2HourY.value =  co2HourYList.cast<double>().reduce(max);
                  AppConst().debug(
                      "co2 hour min y${minCo2HourY.value}");
                  AppConst().debug(
                      "co2 hour max y ${maxCo2HourY.value}");
                }
              }
              if ( vdpHourDataList.isNotEmpty ) {
                for (var element in vdpHourDataList) {
                  vpdHourYList.add(element.y);
                }
                if ( vdpHourDataList.isNotEmpty ) {
                  minVpdHourY.value =  vpdHourYList.cast<double>().reduce(min);
                  maxVpdHourY.value =  vpdHourYList.cast<double>().reduce(max);
                  AppConst().debug(
                      "vpd hour min y${minVpdHourY.value}");
                  AppConst().debug(
                      "vpd hour max y ${maxVpdHourY.value}");
                }
              }
              if ( lightningHourDataList.isNotEmpty ) {
                for (var element in lightningHourDataList) {
                  lightningHourYList.add(element.y);
                }
                if ( vdpHourDataList.isNotEmpty ) {
                  minLightningHourY.value =  lightningHourYList.cast<double>().reduce(min);
                  maxLightningHourY.value =  lightningHourYList.cast<double>().reduce(max);
                  AppConst().debug(
                      "lightning hour min y${minLightningHourY.value}");
                  AppConst().debug(
                      "lightning hour max y ${maxLightningHourY.value}");
                }
              }
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

  Future getDeviceData({required int id}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.device}/$id',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          deviceModel = DeviceModel.fromJson(data);

          AppConst().debug('grow sheet data => ${deviceModel.devices}');

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

  Future getHourData({required int id, required String identifier}) async {

    isGetData.value = false;

   await getClimateData(identifier: identifier, range: "24h").whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          isGetData.value = true;
        });
      });
    });
  }

  Future getWeekData({required int id, required String identifier}) async {

    isGetData.value = false;

    await getClimateData(identifier: identifier, range: "1w").whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          isGetData.value = true;
        });
      });
    });
  }

  Future getMonthData({required int id, required String identifier}) async {

    isGetData.value = false;

    await getClimateData(identifier: identifier, range: "30d").whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          isGetData.value = true;
        });
      });
    });
  }

}

class ChartSampleData {

  double x;
  double y;

  ChartSampleData({
    required this.x,
    required this.y
  });
}