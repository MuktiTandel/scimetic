import 'dart:convert';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
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
import 'package:scimetic/feature/overview/model/growsheet_labeler_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverviewController extends GetxController {

  RxBool isTemperature = false.obs;
  RxBool isElectricalLoad = false.obs;
  RxBool isCo2 = false.obs;
  RxBool isLightning = false.obs;
  RxBool isVdp = false.obs;

  RxBool isHour = true.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;

  RxBool isGermination = true.obs;
  RxBool isSeedling = false.obs;
  RxBool isVegetative = false.obs;
  RxBool isFlowering = false.obs;

  RxString chooseItem = "".obs;

  RxDouble temperatureValue = 0.0.obs;
  RxDouble humidityValue = 0.0.obs;
  RxDouble co2Value = 0.0.obs;
  RxDouble lightningValue = 0.0.obs;
  RxDouble vpdValue = 0.0.obs;

  RxString selectStage = AppStrings.germination.obs;

  DateRangePickerController plantedDate = DateRangePickerController();
  DateRangePickerController harvestDate = DateRangePickerController();

  RxDouble minTemperatureY = 0.0.obs;
  RxDouble maxTemperatureY = 0.0.obs;

  List temperatureYValueList = [];
  List<HourData> temperatureDataList = [];

  RxDouble minHumidityY = 0.0.obs;
  RxDouble maxHumidityY = 0.0.obs;

  List humidityYValueList = [];
  List<HourData> humidityDataList = [];

  RxDouble minCo2Y = 0.0.obs;
  RxDouble maxCo2Y = 0.0.obs;

  List co2YValueList = [];
  List<HourData> co2DataList = [];

  RxDouble minLightY = 0.0.obs;
  RxDouble maxLightY = 0.0.obs;

  List lightYValueList = [];
  List<HourData> lightDataList = [];

  RxDouble minVpdY = 0.0.obs;
  RxDouble maxVpdY = 0.0.obs;

  List vpdYValueList = [];
  List<HourData> vpdDataList = [];

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
  List<HourData> temperatureWeekDataList = [];
  List<MonthData> temperatureMonthDataList = [];

  List<WeekData> electricalWeekDataList = [];
  List<MonthData> electricalMonthDataList = [];
  List<HourData> electricalHourDataList = [];

  List<HourData> co2HourDataList = [];
  List<WeekData> co2WeekDataList = [];
  List<MonthData> co2MonthDataList = [];

  List<HourData> lightningHourDataList = [];
  List<WeekData> lightningWeekDataList = [];
  List<MonthData> lightningMonthDataList = [];

  List<HourData> vpdHourDataList = [];
  List<WeekData> vpdWeekDataList = [];
  List<MonthData> vpdMonthDataList = [];

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  GrowSheetData growSheetData = GrowSheetData();

  ClimateModel climateData = ClimateModel();

  DeviceModel deviceModel = DeviceModel();

  GrowSheetLabelerModel growSheetLabelerModel = GrowSheetLabelerModel();

  GrowsheetLabeler growsheetLabeler = GrowsheetLabeler();

  RxBool isGetData = false.obs;

  RxBool isOverview = false.obs;

  RxBool isClimateData = false.obs;

  RxString plantedDateValue = "".obs;
  RxString harvestDateValue = "".obs;

  RxInt growSheetId = 0.obs;

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

          growSheetId.value = growSheetData.growsheets!.first.id!;

          if ( growSheetData.growsheets!.isNotEmpty ) {
            getGrowSheetLabelerData(id: growSheetId.value).whenComplete(() {
              selectStage.value = growSheetLabelerModel.growsheetLabeler!.stage ?? AppStrings.germination;
              plantedDateValue.value = growSheetLabelerModel.growsheetLabeler!
                  .plantedDate ?? "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
              harvestDateValue.value = growSheetLabelerModel
                  .growsheetLabeler!.harvestDate ?? "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
            });
          }

          AppConst().debug('grow sheet id => ${growSheetId.value}');

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

    climateDataList.clear();

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
            climateDataList.addAll(climateData.climateData!);
            if ( climateDataList.isNotEmpty ) {
              getGraphData();
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

  Future getGrowSheetLabelerData({required int id}) async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetLabeler}/$id',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          growSheetLabelerModel = GrowSheetLabelerModel.fromJson(data);

          AppConst().debug('grow sheet label => ${growSheetLabelerModel.growsheetLabeler}');

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

  void getGraphData() {
    temperatureDataList.clear();
    temperatureYValueList.clear();
    humidityDataList.clear();
    humidityYValueList.clear();
    co2DataList.clear();
    co2YValueList.clear();
    lightDataList.clear();
    lightYValueList.clear();
    vpdDataList.clear();
    vpdYValueList.clear();
    if ( climateDataList.isNotEmpty ) {
      isClimateData.value = true;
      for (var element in climateDataList) {
        temperatureValue.value = climateDataList.last.temperature ?? 0.0;
        humidityValue.value = climateDataList.last.humidity ?? 0.0;
        co2Value.value = climateDataList.last.co2 ?? 0.0;
        lightningValue.value = climateDataList.last.mol!.toDouble();
        vpdValue.value = climateDataList.last.vpd ?? 0.0;
        HourData temperatureData = HourData(
            element.time!, element.temperature!);
        temperatureDataList.add(temperatureData);
        temperatureDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData humidityData = HourData(
            element.time!, element.humidity!);
        humidityDataList.add(humidityData);
        humidityDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData co2Data = HourData(element.time!, element.co2!);
        co2DataList.add(co2Data);
        co2DataList.sort((a, b) => a.x.compareTo(b.x));
        HourData vpdData = HourData(element.time!, element.vpd!);
        vpdDataList.add(vpdData);
        vpdDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData lightningData = HourData(element.time!, element.mol!.toDouble());
        lightDataList.add(lightningData);
        lightDataList.sort((a, b) => a.x.compareTo(b.x));
      }
      if (temperatureDataList.isNotEmpty) {
        for (var element in temperatureDataList) {
          temperatureYValueList.add(element.y);
        }
        if (temperatureYValueList.isNotEmpty) {
          minTemperatureY.value =
              temperatureYValueList.cast<double>().reduce(min);
          maxTemperatureY.value =
              temperatureYValueList.cast<double>().reduce(max);
          AppConst().debug(
              "temperature  min y${minTemperatureY.value}");
          AppConst().debug(
              "temperature  max y ${maxTemperatureY.value}");
        }
      }
      if (humidityDataList.isNotEmpty) {
        for (var element in humidityDataList) {
          humidityYValueList.add(element.y);
        }
        if (humidityYValueList.isNotEmpty) {
          minHumidityY.value =
              humidityYValueList.cast<double>().reduce(min);
          maxHumidityY.value =
              humidityYValueList.cast<double>().reduce(max);
          AppConst().debug(
              "humidity min y${minHumidityY.value}");
          AppConst().debug(
              "humidity max y ${maxHumidityY.value}");
        }
      }
      if ( co2DataList.isNotEmpty ) {
        for (var element in co2DataList) {
          co2YValueList.add(element.y);
        }
        if ( co2YValueList.isNotEmpty ) {
          minCo2Y.value =  co2YValueList.cast<double>().reduce(min);
          maxCo2Y.value =  co2YValueList.cast<double>().reduce(max);
          AppConst().debug(
              "co2 min y${minCo2Y.value}");
          AppConst().debug(
              "co2 max y ${maxCo2Y.value}");
        }
      }
      if ( vpdDataList.isNotEmpty ) {
        for (var element in vpdDataList) {
          vpdYValueList.add(element.y);
        }
        if ( vpdYValueList.isNotEmpty ) {
          minVpdY.value =  vpdYValueList.cast<double>().reduce(min);
          maxVpdY.value =  vpdYValueList.cast<double>().reduce(max);
          AppConst().debug(
              "vpd min y${minVpdY.value}");
          AppConst().debug(
              "vpd max y ${maxVpdY.value}");
        }
      }
      if ( lightDataList.isNotEmpty ) {
        for (var element in lightDataList) {
          lightYValueList.add(element.y);
        }
        if ( lightYValueList.isNotEmpty ) {
          minLightY.value =  lightYValueList.cast<double>().reduce(min);
          maxLightY.value =  lightYValueList.cast<double>().reduce(max);
          AppConst().debug(
              "lightning min y${minLightY.value}");
          AppConst().debug(
              "lightning max y ${maxLightY.value}");
        }
      }
    }
  }

  void getHourGraphData() {
    if ( isHour.value == true ) {
      temperatureHourDataList.clear();
      electricalHourDataList.clear();
      co2HourDataList.clear();
      lightningHourDataList.clear();
      vpdHourDataList.clear();
      temperatureHourYList.clear();
      humidityHourYList.clear();
      co2HourYList.clear();
      lightningHourYList.clear();
      vpdHourYList.clear();
      for (var element in climateDataList) {
        temperatureValue.value = climateDataList.last.temperature ?? 0.0;
        humidityValue.value = climateDataList.last.humidity ?? 0.0;
        co2Value.value = climateDataList.last.co2 ?? 0.0;
        lightningValue.value = climateDataList.last.mol!.toDouble();
        vpdValue.value = climateDataList.last.vpd ?? 0.0;
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
        vpdHourDataList.add(vpdData);
        vpdHourDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData lightningData = HourData(element.time!, element.mol!.toDouble());
        lightningHourDataList.add(lightningData);
        lightningHourDataList.sort((a, b) => a.x.compareTo(b.x));
      }
    }
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
      if (humidityHourYList.isNotEmpty) {
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
    if ( vpdHourDataList.isNotEmpty ) {
      for (var element in vpdHourDataList) {
        vpdHourYList.add(element.y);
      }
      if ( vpdHourYList.isNotEmpty ) {
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
      if ( lightningHourYList.isNotEmpty ) {
        minLightningHourY.value =  lightningHourYList.cast<double>().reduce(min);
        maxLightningHourY.value =  lightningHourYList.cast<double>().reduce(max);
        AppConst().debug(
            "lightning hour min y${minLightningHourY.value}");
        AppConst().debug(
            "lightning hour max y ${maxLightningHourY.value}");
      }
    }
  }

  void getWeekGraphData() {
    if ( isWeek.value == true ) {
      temperatureWeekDataList.clear();
      electricalWeekDataList.clear();
      co2WeekDataList.clear();
      lightningWeekDataList.clear();
      vpdWeekDataList.clear();
      temperatureWeekYList.clear();
      humidityWeekYList.clear();
      co2WeekYList.clear();
      lightningWeekYList.clear();
      vpdWeekYList.clear();
      for (var element in climateDataList) {
        temperatureValue.value = climateDataList.last.temperature ?? 0.0;
        humidityValue.value = climateDataList.last.humidity ?? 0.0;
        co2Value.value = climateDataList.last.co2 ?? 0.0;
        lightningValue.value = climateDataList.last.mol!.toDouble();
        vpdValue.value = climateDataList.last.vpd ?? 0.0;
        HourData temperatureData = HourData(
            element.time!, element.temperature!);
        temperatureWeekDataList.add(temperatureData);
        temperatureWeekDataList.sort((a, b) => a.x.compareTo(b.x));
        WeekData humidityData = WeekData(
            element.time!, element.humidity!);
        electricalWeekDataList.add(humidityData);
        electricalWeekDataList.sort((a, b) => a.x.compareTo(b.x));
        WeekData co2Data = WeekData(element.time!, element.co2!);
        co2WeekDataList.add(co2Data);
        co2WeekDataList.sort((a, b) => a.x.compareTo(b.x));
        WeekData vpdData = WeekData(element.time!, element.vpd!);
        vpdWeekDataList.add(vpdData);
        vpdWeekDataList.sort((a, b) => a.x.compareTo(b.x));
        WeekData lightningData = WeekData(element.time!, element.mol!.toDouble());
        lightningWeekDataList.add(lightningData);
        lightningWeekDataList.sort((a, b) => a.x.compareTo(b.x));
      }
    }
    if (temperatureWeekDataList.isNotEmpty) {
      for (var element in temperatureWeekDataList) {
        temperatureWeekYList.add(element.y);
      }
      if (temperatureWeekYList.isNotEmpty) {
        minTemperatureWeekY.value =
            temperatureWeekYList.cast<double>().reduce(min);
        maxTemperatureWeekY.value =
            temperatureWeekYList.cast<double>().reduce(max);
        AppConst().debug(
            "temperature week min y${minTemperatureWeekY.value}");
        AppConst().debug(
            "temperature week max y ${maxTemperatureWeekY.value}");
      }
    }
    if (electricalWeekDataList.isNotEmpty) {
      for (var element in electricalWeekDataList) {
        humidityWeekYList.add(element.y);
      }
      if (humidityWeekYList.isNotEmpty) {
        minHumidityWeekY.value =
            humidityWeekYList.cast<double>().reduce(min);
        maxHumidityWeekY.value =
            humidityWeekYList.cast<double>().reduce(max);
        AppConst().debug(
            "humidity week min y${minHumidityWeekY.value}");
        AppConst().debug(
            "humidity week max y ${maxHumidityWeekY.value}");
      }
    }
    if ( co2WeekDataList.isNotEmpty ) {
      for (var element in co2WeekDataList) {
        co2WeekYList.add(element.y);
      }
      if ( co2WeekYList.isNotEmpty ) {
        minCo2WeekY.value =  co2WeekYList.cast<double>().reduce(min);
        maxCo2WeekY.value =  co2WeekYList.cast<double>().reduce(max);
        AppConst().debug(
            "co2 week min y${minCo2WeekY.value}");
        AppConst().debug(
            "co2 week max y ${maxCo2WeekY.value}");
      }
    }
    if ( vpdWeekDataList.isNotEmpty ) {
      for (var element in vpdWeekDataList) {
        vpdWeekYList.add(element.y);
      }
      if ( vpdWeekYList.isNotEmpty ) {
        minVpdWeekY.value =  vpdWeekYList.cast<double>().reduce(min);
        maxVpdWeekY.value =  vpdWeekYList.cast<double>().reduce(max);
        AppConst().debug(
            "vpd week min y${minVpdWeekY.value}");
        AppConst().debug(
            "vpd week max y ${maxVpdWeekY.value}");
      }
    }
    if ( lightningWeekDataList.isNotEmpty ) {
      for (var element in lightningWeekDataList) {
        lightningWeekYList.add(element.y);
      }
      if ( lightningWeekYList.isNotEmpty ) {
        minLightningWeekY.value =  lightningWeekYList.cast<double>().reduce(min);
        maxLightningWeekY.value =  lightningWeekYList.cast<double>().reduce(max);
        AppConst().debug(
            "lightning week min y${minLightningWeekY.value}");
        AppConst().debug(
            "lightning week max y ${maxLightningWeekY.value}");
      }
    }
  }

  void getMonthGraphData() {
    if ( isMonth.value == true ) {
      temperatureMonthDataList.clear();
      electricalMonthDataList.clear();
      co2MonthDataList.clear();
      lightningMonthDataList.clear();
      vpdMonthDataList.clear();
      temperatureMonthYList.clear();
      humidityMonthYList.clear();
      co2MonthYList.clear();
      lightningMonthYList.clear();
      vpdMonthYList.clear();
      for (var element in climateDataList) {
        temperatureValue.value = climateDataList.last.temperature ?? 0.0;
        humidityValue.value = climateDataList.last.humidity ?? 0.0;
        co2Value.value = climateDataList.last.co2 ?? 0.0;
        lightningValue.value = climateDataList.last.mol!.toDouble();
        vpdValue.value = climateDataList.last.vpd ?? 0.0;
        MonthData temperatureData = MonthData(
            element.time!, element.temperature!);
        temperatureMonthDataList.add(temperatureData);
        temperatureMonthDataList.sort((a, b) => a.x.compareTo(b.x));
        MonthData humidityData = MonthData(
            element.time!, element.humidity!);
        electricalMonthDataList.add(humidityData);
        electricalMonthDataList.sort((a, b) => a.x.compareTo(b.x));
        MonthData co2Data = MonthData(element.time!, element.co2!);
        co2MonthDataList.add(co2Data);
        co2MonthDataList.sort((a, b) => a.x.compareTo(b.x));
        MonthData vpdData = MonthData(element.time!, element.vpd!);
        vpdMonthDataList.add(vpdData);
        vpdMonthDataList.sort((a, b) => a.x.compareTo(b.x));
        MonthData lightningData = MonthData(element.time!, element.mol!.toDouble());
        lightningMonthDataList.add(lightningData);
        lightningMonthDataList.sort((a, b) => a.x.compareTo(b.x));
      }
    }
    if (temperatureMonthDataList.isNotEmpty) {
      for (var element in temperatureMonthDataList) {
        temperatureMonthYList.add(element.y);
      }
      if (temperatureMonthYList.isNotEmpty) {
        minTemperatureMonthY.value =
            temperatureMonthYList.cast<double>().reduce(min);
        maxTemperatureMonthY.value =
            temperatureMonthYList.cast<double>().reduce(max);
        AppConst().debug(
            "temperature Month min y${minTemperatureMonthY.value}");
        AppConst().debug(
            "temperature Month max y ${maxTemperatureMonthY.value}");
      }
    }
    if (electricalMonthDataList.isNotEmpty) {
      for (var element in electricalMonthDataList) {
        humidityMonthYList.add(element.y);
      }
      if (humidityMonthYList.isNotEmpty) {
        minHumidityMonthY.value =
            humidityMonthYList.cast<double>().reduce(min);
        maxHumidityMonthY.value =
            humidityMonthYList.cast<double>().reduce(max);
        AppConst().debug(
            "humidity Month min y${minHumidityMonthY.value}");
        AppConst().debug(
            "humidity Month max y ${maxHumidityMonthY.value}");
      }
    }
    if ( co2MonthDataList.isNotEmpty ) {
      for (var element in co2MonthDataList) {
        co2MonthYList.add(element.y);
      }
      if ( co2MonthYList.isNotEmpty ) {
        minCo2MonthY.value =  co2MonthYList.cast<double>().reduce(min);
        maxCo2MonthY.value =  co2MonthYList.cast<double>().reduce(max);
        AppConst().debug(
            "co2 Month min y${minCo2MonthY.value}");
        AppConst().debug(
            "co2 Month max y ${maxCo2MonthY.value}");
      }
    }
    if ( vpdMonthDataList.isNotEmpty ) {
      for (var element in vpdMonthDataList) {
        vpdMonthYList.add(element.y);
      }
      if ( vpdMonthYList.isNotEmpty ) {
        minVpdMonthY.value =  vpdMonthYList.cast<double>().reduce(min);
        maxVpdMonthY.value =  vpdMonthYList.cast<double>().reduce(max);
        AppConst().debug(
            "vpd Month min y${minVpdMonthY.value}");
        AppConst().debug(
            "vpd Month max y ${maxVpdMonthY.value}");
      }
    }
    if ( lightningMonthDataList.isNotEmpty ) {
      for (var element in lightningMonthDataList) {
        lightningMonthYList.add(element.y);
      }
      if ( lightningMonthYList.isNotEmpty ) {
        minLightningMonthY.value =  lightningMonthYList.cast<double>().reduce(min);
        maxLightningMonthY.value =  lightningMonthYList.cast<double>().reduce(max);
        AppConst().debug(
            "lightning month min y${minLightningMonthY.value}");
        AppConst().debug(
            "lightning month max y ${maxLightningMonthY.value}");
      }
    }
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