import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

ClimateModel climateDataFromJson(String str) => ClimateModel.fromJson(json.decode(str));

String climateDataToJson(ClimateModel data) => json.encode(data.toJson());

class ClimateModel {
  ClimateModel({
    this.climateData,
    this.growspace,
    this.length,
  });

  List<ClimateData>? climateData;
  GrowController? growspace;
  int? length;

  factory ClimateModel.fromJson(Map<String, dynamic> json) => ClimateModel(
    climateData: json["climateData"] != null ? List<ClimateData>.from(json["climateData"].map((x) => ClimateData.fromJson(x))) : [],
    growspace: GrowController.fromJson(json["growspace"]),
    length: json["length"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x.toJson())),
    "growspace": growspace!.toJson(),
    "length": length,
  };
}

class ClimateData {
  ClimateData({
    this.result,
    this.table,
    this.start,
    this.stop,
    this.time,
    this.co2,
    this.humidity,
    this.mol,
    this.temperature,
    this.vpd,
  });

  String? result;
  int? table;
  DateTime? start;
  DateTime? stop;
  DateTime? time;
  double? co2;
  double? humidity;
  int? mol;
  double? temperature;
  double? vpd;

  factory ClimateData.fromJson(Map<String, dynamic> json) => ClimateData(
    result: json["result"] ?? "",
    table: json["table"] ?? 0,
    start: json["_start"] != null ? DateTime.parse(json["_start"]) : DateTime.now(),
    stop: json["_stop"] != null ? DateTime.parse(json["_stop"]) : DateTime.now(),
    time: json["_time"] != null ? DateTime.parse(json["_time"]) : DateTime.now(),
    co2: json["co2"] != null ? json["co2"].toDouble() : 0.0,
    humidity: json["humidity"] != null ? json["humidity"].toDouble() : 0.0,
    mol: json["mol"] ?? 0,
    temperature: json["temperature"] != null ? json["temperature"].toDouble() : 0.0,
    vpd: json["vpd"] != null ? json["vpd"].toDouble() : 0.0,
  );

  Map<String, dynamic> toJson() => {
    "result":result,
    "table": table,
    "_start": start!.toIso8601String() ,
    "_stop": stop!.toIso8601String(),
    "_time": time!.toIso8601String(),
    "co2": co2,
    "humidity": humidity,
    "mol": mol,
    "temperature": temperature,
    "vpd": vpd,
  };
}