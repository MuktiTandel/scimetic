import 'dart:convert';

ExtractorControlModel extractorControlModelFromJson(String str) => ExtractorControlModel.fromJson(json.decode(str));

String extractorControlModelToJson(ExtractorControlModel data) => json.encode(data.toJson());

class ExtractorControlModel {
  ExtractorControlModel({
    this.dayTemperature,
    this.nightTemperature,
    this.dayTemperatureDeadband,
    this.nightTemperatureDeadband,
    this.daySwitch,
    this.nightSwitch,
    this.dayRelay,
    this.nightRelay,
    this.extractorFanAuto,
  });

  double? dayTemperature;
  double? nightTemperature;
  double? dayTemperatureDeadband;
  double? nightTemperatureDeadband;
  String? daySwitch;
  String? nightSwitch;
  String? dayRelay;
  String? nightRelay;
  bool? extractorFanAuto;

  factory ExtractorControlModel.fromJson(Map<String, dynamic> json) => ExtractorControlModel(
    dayTemperature: json["dayTemperature"] != null ? json["dayTemperature"].toDouble() : 0,
    nightTemperature: json["nightTemperature"] != null ? json["nightTemperature"].toDouble() : 0,
    dayTemperatureDeadband: json["dayTemperatureDeadband"] != null ? json["dayTemperatureDeadband"].toDouble() : 0,
    nightTemperatureDeadband: json["nightTemperatureDeadband"] != null ? json["nightTemperatureDeadband"].toDouble() : 0,
    daySwitch: json["daySwitch"] ?? "",
    nightSwitch: json["nightSwitch"] ?? "",
    dayRelay: json["dayRelay"] ?? "",
    nightRelay: json["nightRelay"] ?? "",
    extractorFanAuto: json["extractorFanAuto"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "dayTemperature": dayTemperature,
    "nightTemperature": nightTemperature,
    "dayTemperatureDeadband": dayTemperatureDeadband,
    "nightTemperatureDeadband": nightTemperatureDeadband,
    "daySwitch": daySwitch,
    "nightSwitch": nightSwitch,
    "dayRelay": dayRelay,
    "nightRelay": nightRelay,
    "extractorFanAuto": extractorFanAuto,
  };
}