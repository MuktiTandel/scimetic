import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/core/elements/custom_dialog.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/overview/element/hour_graph.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/overview/model/climate_model.dart';
import 'package:scimetic/feature/device_settings/Model/device_model.dart';
import 'package:scimetic/feature/growsheet/model/growsheet_model.dart';
import 'package:scimetic/feature/overview/model/growsheet_labeler_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OverviewController extends GetxController {
  RxBool isTemperature = false.obs;
  RxBool isElectricalLoad = false.obs;
  RxBool isCo2 = false.obs;
  RxBool isLightning = false.obs;
  RxBool isVdp = false.obs;

  RxBool is24Hour = true.obs;
  RxBool is1Hour = false.obs;
  RxBool is6Hour = false.obs;
  RxBool is12Hour = false.obs;
  RxBool isWeek = false.obs;
  RxBool isMonth = false.obs;

  RxBool isGermination = false.obs;
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

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxInt id = 0.obs;

  GrowSheetData growSheetData = GrowSheetData();

  Growsheet growSheet = Growsheet();

  ClimateModel climateData = ClimateModel();

  DeviceModel deviceModel = DeviceModel();

  GrowSheetLabelerModel growSheetLabelerModel = GrowSheetLabelerModel();

  GrowsheetLabeler growSheetLabeler = GrowsheetLabeler();

  RxBool isGetData = false.obs;

  RxBool isOverview = false.obs;

  RxBool isClimateData = false.obs;

  RxString plantedDateValue = "".obs;
  RxString harvestDateValue = "".obs;

  RxInt growSheetId = 0.obs;

  List<ClimateData> climateDataList = [];

  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController plantController = TextEditingController();
  final TextEditingController genealogyController = TextEditingController();

  RxBool isGraphScreen = false.obs;

  RxDouble rangeValue1 = 0.0.obs;
  RxDouble rangeValue2 = 0.0.obs;
  RxDouble rangeValue3 = 0.0.obs;
  RxDouble rangeValue4 = 0.0.obs;
  RxInt progressValue = 0.obs;

  RxInt currentDay = 0.obs;
  RxInt totalPeriod = 0.obs;

  RxBool isGetDevice = false.obs;

  DateTime plantedDate1 = DateTime.now();

  DateTime harvestDate1 = DateTime.now();

  Map<String, num> data = {
    'germination': 0,
    'seedling': 0,
    'vegetative': 0,
    'flowering': 0
  };

  Future getGrowSheetData({required int id}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                '${ApiPath.baseUrl}${ApiPath.growSheetGrowController}/$id?applied=true',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if (apiResponse!.statusCode == 200) {
          growSheetData = GrowSheetData.fromJson(data);

          growSheetId.value = growSheetData.growsheets!.first.id!;

          if (growSheetData.growsheets!.isNotEmpty) {
            growSheet = growSheetData.growsheets!.first;
            await getGrowSheetLabelerData(id: growSheetId.value);
          }

          AppConst().debug('grow sheet id => ${growSheetId.value}');

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

  Future getClimateData(
      {required String identifier, required String range}) async {
    token = storeData.getString(StoreData.accessToken)!;

    climateDataList.clear();

    if (token.isNotEmpty) {
      isClimateData.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url:
                '${ApiPath.baseUrl}${ApiPath.growController}/$identifier/climate?range=$range',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if (apiResponse!.statusCode == 200) {
          climateData = ClimateModel.fromJson(data);

          if (climateData.climateData!.isNotEmpty) {
            climateDataList.addAll(climateData.climateData!);
            if (climateDataList.isNotEmpty) {
              getGraphData();
            }
          }

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

  Future getDeviceData({required int id}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      isGetDevice.value = false;

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.device}/$id',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if (apiResponse!.statusCode == 200) {
          isGetDevice.value = true;

          deviceModel = DeviceModel.fromJson(data);

          AppConst().debug('device => ${deviceModel.devices!.sensor!.total}');

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

  Future getGrowSheetLabelerData({required int id}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetLabeler}/$id',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization": 'Bearer $token',
            });

        apiResponse =
            await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if (apiResponse!.statusCode == 200) {
          growSheetLabelerModel = GrowSheetLabelerModel.fromJson(data);

          if (growSheetLabelerModel.growsheetLabeler != null) {

            selectStage.value =
                growSheetLabelerModel.growsheetLabeler!.stage ??
                    AppStrings.germination;

          }

          if (selectStage.value.contains(AppStrings.flowering)) {

            isFlowering.value = true;
            isVegetative.value = false;
            isSeedling.value = false;
            isGermination.value = false;

          } else if (selectStage.value.contains(AppStrings.germination)) {

            isGermination.value = true;
            isSeedling.value = false;
            isVegetative.value = false;
            isFlowering.value = false;

          } else if (selectStage.value.contains(AppStrings.seedling)) {

            isSeedling.value = true;
            isFlowering.value = false;
            isVegetative.value = false;
            isGermination.value = false;

          } else if (selectStage.value.contains(AppStrings.vegetative)) {

            isVegetative.value = true;
            isGermination.value = false;
            isFlowering.value = false;
            isSeedling.value = false;

          } else {

            isGermination.value = true;
            isSeedling.value = false;
            isFlowering.value = false;
            isVegetative.value = false;

          }

          if (growSheetLabelerModel.growsheetLabeler != null) {

            plantController.text = growSheetLabelerModel.growsheetLabeler!.typeOfPlant!;
            genealogyController.text = growSheetLabelerModel.growsheetLabeler!.genealogy!;

            if (growSheetLabelerModel
                .growsheetLabeler!.plantedDate!.isNotEmpty) {
              plantedDate1 = DateFormat("dd.MM.yyyy").parse(
                  growSheetLabelerModel.growsheetLabeler!.plantedDate!);

              plantedDateValue.value =
              "${plantedDate1.day}.${plantedDate1.month}.${plantedDate1.year}";
            }

          }

          if (growSheetLabelerModel.growsheetLabeler != null) {

            if (growSheetLabelerModel
                .growsheetLabeler!.harvestDate!.isNotEmpty) {
              harvestDate1 = DateFormat("dd.MM.yyyy").parse(
                  growSheetLabelerModel.growsheetLabeler!.harvestDate!);

              harvestDateValue.value =
              "${harvestDate1.day}.${harvestDate1.month}.${harvestDate1.year}";
            }

          }

          growSheetLabeler =
              growSheetLabelerModel.growsheetLabeler ?? GrowsheetLabeler();

          harvestDate.selectedDate = harvestDate1;

          plantedDate.selectedDate = plantedDate1;

          progressValue.value = 0;

          totalPeriod.value = harvestDate.selectedDate!
                  .difference(plantedDate.selectedDate!)
                  .inDays +
              1;

          currentDay.value =
              DateTime.now().difference(plantedDate.selectedDate!).inDays + 1;

          final graphData1 = graphData();

          final num totalSpent =
              graphData1.values.reduce((prev, curr) => prev + curr);
          progressValue.value =
              ((totalSpent / totalPeriod.value) * 100).ceil().clamp(0, 100);

          AppConst().debug("progress value => ${progressValue.value}");

          resolveAngles(graphData1, totalPeriod.value);

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

  Future updateGrowSheetLabelerData(
      {required int id, required GrowsheetLabeler growsheetLabeler}) async {
    token = storeData.getString(StoreData.accessToken)!;

    if (token.isNotEmpty) {
      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.growSheetLabeler}/$id',
            requestType: HTTPRequestType.PUT,
            headers: {
              "Authorization": 'Bearer $token',
              "Content-Type": "application/json"
            },
            parameter: growsheetLabeler.toJson());

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
  }

  Future addGrowSheetLabeler() async {
    GrowsheetLabeler growSheetLabeler = GrowsheetLabeler();

    growSheetLabeler.typeOfPlant =
        plantController.text.isNotEmpty ? plantController.text : "";
    growSheetLabeler.genealogy =
        genealogyController.text.isNotEmpty ? genealogyController.text : "";
    growSheetLabeler.stage =
        selectStage.value.isNotEmpty ? selectStage.value : "";
    growSheetLabeler.plantedDate =
        plantedDateValue.value.isNotEmpty ? plantedDateValue.value : "";
    growSheetLabeler.harvestDate =
        harvestDateValue.value.isNotEmpty ? harvestDateValue.value : "";
    growSheetLabeler.barcode = barcodeController.text.isNotEmpty
        ? int.parse(barcodeController.text)
        : 0;

    await updateGrowSheetLabelerData(
        id: growSheetId.value, growsheetLabeler: growSheetLabeler);
  }

  Future get1HourData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "1h")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      });
    });
  }

  Future get6HourData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "6h")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      });
    });
  }

  Future get12HourData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "12h")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      });
    });
  }

  Future get24HourData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "24h")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      });
    });
  }

  Future getWeekData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "1w")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
        });
      });
    });
  }

  Future getMonthData({required int id, required String identifier}) async {
    progressDialog(true, Get.context!);

    await getClimateData(identifier: identifier, range: "30d")
        .whenComplete(() async {
      await getGrowSheetData(id: id).whenComplete(() async {
        await getDeviceData(id: id).whenComplete(() {
          progressDialog(false, Get.context!);
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
    if (climateDataList.isNotEmpty) {
      isClimateData.value = true;
      for (var element in climateDataList) {
        temperatureValue.value = climateDataList.last.temperature ?? 0.0;
        humidityValue.value = climateDataList.last.humidity ?? 0.0;
        co2Value.value = climateDataList.last.co2 ?? 0.0;
        lightningValue.value = climateDataList.last.mol!.toDouble();
        vpdValue.value = climateDataList.last.vpd ?? 0.0;
        HourData temperatureData =
            HourData(element.time!, element.temperature!);
        temperatureDataList.add(temperatureData);
        temperatureDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData humidityData = HourData(element.time!, element.humidity!);
        humidityDataList.add(humidityData);
        humidityDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData co2Data = HourData(element.time!, element.co2!);
        co2DataList.add(co2Data);
        co2DataList.sort((a, b) => a.x.compareTo(b.x));
        HourData vpdData = HourData(element.time!, element.vpd!);
        vpdDataList.add(vpdData);
        vpdDataList.sort((a, b) => a.x.compareTo(b.x));
        HourData lightningData =
            HourData(element.time!, element.mol!.toDouble());
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
        }
      }
      if (humidityDataList.isNotEmpty) {
        for (var element in humidityDataList) {
          humidityYValueList.add(element.y);
        }
        if (humidityYValueList.isNotEmpty) {
          minHumidityY.value = humidityYValueList.cast<double>().reduce(min);
          maxHumidityY.value = humidityYValueList.cast<double>().reduce(max);
        }
      }
      if (co2DataList.isNotEmpty) {
        for (var element in co2DataList) {
          co2YValueList.add(element.y);
        }
        if (co2YValueList.isNotEmpty) {
          minCo2Y.value = co2YValueList.cast<double>().reduce(min);
          maxCo2Y.value = co2YValueList.cast<double>().reduce(max);
        }
      }
      if (vpdDataList.isNotEmpty) {
        for (var element in vpdDataList) {
          vpdYValueList.add(element.y);
        }
        if (vpdYValueList.isNotEmpty) {
          minVpdY.value = vpdYValueList.cast<double>().reduce(min);
          maxVpdY.value = vpdYValueList.cast<double>().reduce(max);
        }
      }
      if (lightDataList.isNotEmpty) {
        for (var element in lightDataList) {
          lightYValueList.add(element.y);
        }
        if (lightYValueList.isNotEmpty) {
          minLightY.value = lightYValueList.cast<double>().reduce(min);
          maxLightY.value = lightYValueList.cast<double>().reduce(max);
        }
      }
    }
  }

  Map<String, num> graphData() {
    final Map<String, num> dataClone = Map.from(data);
    final Map<String, double> weightages = {
      'germination': (1 / 16) * totalPeriod.value,
      'seedling': (2 / 16) * totalPeriod.value,
      'vegetative': (4 / 16) * totalPeriod.value,
      'flowering': (9 / 16) * totalPeriod.value,
    };

    int remainingDays = currentDay.value;
    weightages.forEach((key, value) {
      if (remainingDays > 0) {
        dataClone[key] = (value - remainingDays) > 0 ? remainingDays : value;
        remainingDays = remainingDays - value.toInt();
      }
    });
    dataClone.forEach((key, value) {
      AppConst().debug("$key $value");
    });

    return dataClone;
  }

  Map<String, Map<String, double>> resolveAngles(
      Map<String, num> data, int totalPeriod) {
    rangeValue4.value = 0.0;
    rangeValue3.value = 0.0;
    rangeValue2.value = 0.0;
    rangeValue1.value = 0.0;

    final List<String> keys = data.keys.toList();
    final Map<String, Map<String, double>> angles = {};

    double startAngle = 0;
    double endAngle = 0;
    for (var key in keys) {
      startAngle = angles.isEmpty
          ? 0
          : startAngle +
              (data[keys[keys.indexOf(key) - 1]]! / totalPeriod) * 2 * pi;
      endAngle = endAngle + (data[key]! / totalPeriod) * 2 * pi;
      angles[key] = {'startAngle': startAngle, 'endAngle': endAngle};
    }

    rangeValue1.value = angles["germination"]!["endAngle"]! * 10 + 6;
    rangeValue2.value = angles["seedling"]!["endAngle"]! * 10 + 10;
    rangeValue3.value = angles["vegetative"]!["endAngle"]! * 10 + 10;
    rangeValue4.value = progressValue.value.toDouble();

    if (rangeValue2.value < rangeValue1.value) {
      rangeValue2.value = rangeValue1.value + 5;
    }

    if (rangeValue3.value < rangeValue2.value) {
      rangeValue3.value = rangeValue2.value + 5;
    }

    if (rangeValue4.value < rangeValue3.value) {
      rangeValue4.value = rangeValue3.value + 5;
    }

    angles.forEach((key, value) {
      AppConst().debug('$key $value');
    });

    AppConst().debug('range value 4 => ${rangeValue4.value}');
    AppConst().debug('range value 3 => ${rangeValue3.value}');
    AppConst().debug('range value 2 => ${rangeValue2.value}');
    AppConst().debug('range value 1 => ${rangeValue1.value}');

    return angles;
  }
}

class ChartSampleData {
  double x;
  double y;

  ChartSampleData({required this.x, required this.y});
}
