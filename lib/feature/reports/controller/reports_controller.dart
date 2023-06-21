import 'dart:convert';

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
import 'package:scimetic/core/utils/check_net_connectivity.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:scimetic/feature/reports/model/report_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class ReportController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController batchIdController = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  DateRangePickerController startDateController = DateRangePickerController();
  DateRangePickerController endDateController = DateRangePickerController();

  RxString chooseSensor = AppStrings.temperature.obs;

  List<String> sensorList = [
    AppStrings.temperature,
    AppStrings.cO2,
    AppStrings.humidity,
    AppStrings.vpd
  ];

  RxBool isValid = true.obs;

  RxString errorMessage = "".obs;

  RxBool isGetData = false.obs;

  String token = "";

  StoreData storeData = StoreData();

  http.Response? apiResponse;

  RxString identifier = "".obs;

  ReportTemperatureData reportTemperatureData = ReportTemperatureData();

  ReportCo2Data reportCo2Data = ReportCo2Data();

  ReportHumidityData reportHumidityData = ReportHumidityData();

  ReportVpdData reportVpdData = ReportVpdData();

  RxDouble maxValue = 0.0.obs;

  List valueList = [];

  List<TemperatureData> temperatureDataList = [];

  List<Co2Data> co2DataList = [];

  List<VpdData> vpdDataList = [];

  List<HumidityData> humidityDataList = [];

  List<TemperatureData> temperatureFilterDataList = [];

  List<Co2Data> co2FilterDataList = [];

  List<VpdData> vdpFilterDataList = [];

  List<HumidityData> humidityFilterDataList = [];

  List<ChartSampleData> chartDataList = [];

  Future getReportData() async {
    isGetData.value = false;

    token = storeData.getString(StoreData.accessToken)!;

    identifier.value = storeData.getString(StoreData.identifier)!;

    if (token.isNotEmpty) {
      progressDialog(true, Get.context!);

      valueList.clear();

      temperatureDataList.clear();
      co2DataList.clear();
      humidityDataList.clear();
      vpdDataList.clear();

      final differance = endDateController.selectedDate!
          .difference(startDateController.selectedDate!)
          .inDays;

      AppConst().debug('differance => $differance');

      try {
        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.report}/${identifier.value}'
                '/live?sensor=${chooseSensor.value}&start=${startDate.text}T00:00'
                ':00%2B05:30&end=${endDate.text}T23:59:59%2B05:30',
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
          isGetData.value = true;

          if (chooseSensor.contains("temperature")) {
            reportTemperatureData = ReportTemperatureData.fromJson(data);

            if (reportTemperatureData.climateData!.isNotEmpty) {
              temperatureDataList.addAll(reportTemperatureData.climateData!);
            }

            if (temperatureDataList.isNotEmpty) {
              temperatureFilterList();
            }
          } else if (chooseSensor.contains("co2")) {
            reportCo2Data = ReportCo2Data.fromJson(data);

            if (reportCo2Data.climateData!.isNotEmpty) {
              co2DataList.addAll(reportCo2Data.climateData!);
            }
          } else if (chooseSensor.contains("humidity")) {
            reportHumidityData = ReportHumidityData.fromJson(data);

            if (reportHumidityData.climateData!.isNotEmpty) {
              humidityDataList.addAll(reportHumidityData.climateData!);
            }
          } else if (chooseSensor.contains("vpd")) {
            reportVpdData = ReportVpdData.fromJson(data);

            if (reportVpdData.climateData!.isNotEmpty) {
              vpdDataList.addAll(reportVpdData.climateData!);
            }
          }

          if (temperatureDataList.isNotEmpty) {
            for (var element in temperatureDataList) {
              valueList.add(element.temperature);
            }
          } else if (co2DataList.isNotEmpty) {
            for (var element in co2DataList) {
              valueList.add(element.co2);
            }
          } else if (humidityDataList.isNotEmpty) {
            for (var element in humidityDataList) {
              valueList.add(element.humidity);
            }
          } else if (vpdDataList.isNotEmpty) {
            for (var element in vpdDataList) {
              valueList.add(element.vpd);
            }
          }

          maxValue.value = valueList.reduce(
                  (value, element) => value > element ? value : element) +
              1.0;

          AppConst().debug('max value => ${maxValue.value}');

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

  void onGenerate() async {
    isValid.value = true;

    if (nameController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (companyNameController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (batchIdController.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (startDate.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else if (endDate.text.isEmpty) {
      isValid.value = false;
      errorMessage.value = AppStrings.allFieldRequired;
    } else {
      bool isConnected = await checkNetConnectivity();

      if (isConnected == true) {
        await getReportData();
      } else {
        showSnack(title: AppStrings.noInternetConnection, width: 200.w);
      }
    }
  }

  void temperatureFilterList() {

    if ( temperatureDataList.isNotEmpty ) {
      temperatureFilterDataList.clear();

      double highValue = 0.0;

      double lowValue = 0.0;

      DateTime dateTime =
      DateFormat("yyyy-MM-dd hh:mm").parse(temperatureDataList.first.date!);

      AppConst().debug('hour => ${dateTime.hour}');

      List yValueList = [];

      for (var element in temperatureDataList) {
        AppConst().debug('date => ${element.date}');
        DateTime dateTime1 = DateFormat("yyyy-MM-dd hh:mm").parse(
            element.date!);
        if (dateTime1.hour == dateTime.hour) {
          AppConst().debug('date time 1 => $dateTime');
          temperatureFilterDataList.add(element);
        }
      }

      if (temperatureFilterDataList.isNotEmpty) {
        for (var element in temperatureFilterDataList) {
          yValueList.add(element.temperature);
          temperatureDataList.removeWhere((element1) =>
          (element1.temperature == element.temperature));
        }
      }

      if (yValueList.isNotEmpty) {
        highValue = yValueList
            .reduce((value, element) => value > element ? value : element);
        lowValue = yValueList
            .reduce((value, element) => value < element ? value : element);
      }

      AppConst().debug(
          'temperature data list length => ${temperatureDataList.length}');

      AppConst().debug('high value => $highValue');
      AppConst().debug('high value => $lowValue');

      ChartSampleData chartSampleData = ChartSampleData();

      chartSampleData.x = dateTime;
      chartSampleData.high = highValue;
      chartSampleData.low = lowValue;

      chartDataList.add(chartSampleData);

      AppConst()
          .debug('filter List length => ${temperatureFilterDataList.length}');

      temperatureFilterList();
    }
  }
}

///Chart sample data
class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  DateTime? x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  num? open;

  /// Holds close value of the datapoint
  num? close;

  /// Holds low value of the datapoint
  num? low;

  /// Holds high value of the datapoint
  num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
