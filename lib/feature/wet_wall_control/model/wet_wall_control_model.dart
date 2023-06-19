import 'dart:convert';

WetWallControlModel wetWallControlModelFromJson(String str) => WetWallControlModel.fromJson(json.decode(str));

String wetWallControlModelToJson(WetWallControlModel data) => json.encode(data.toJson());

class WetWallControlModel {
  WetWallControlModel({
    this.dayTemperature,
    this.nightTemperature,
    this.dayTemperatureDeadband,
    this.nightTemperatureDeadband,
    this.daySwitch,
    this.nightSwitch,
    this.dayRelay,
    this.nightRelay,
    this.wetWallAuto,
  });

  double? dayTemperature;
  double? nightTemperature;
  double? dayTemperatureDeadband;
  double? nightTemperatureDeadband;
  String? daySwitch;
  String? nightSwitch;
  String? dayRelay;
  String? nightRelay;
  bool? wetWallAuto;

  factory WetWallControlModel.fromJson(Map<String, dynamic> json) => WetWallControlModel(
    dayTemperature: json["dayTemperature"] != null ? json["dayTemperature"].toDouble() : 0.0,
    nightTemperature: json["nightTemperature"] != null ? json["nightTemperature"].toDouble() : 0.0,
    dayTemperatureDeadband: json["dayTemperatureDeadband"] != null ? json["dayTemperatureDeadband"].toDouble() : 0.0,
    nightTemperatureDeadband: json["nightTemperatureDeadband"] != null ? json["nightTemperatureDeadband"].toDouble() : 0.0,
    daySwitch: json["daySwitch"] ?? "",
    nightSwitch: json["nightSwitch"] ?? "",
    dayRelay: json["dayRelay"] ?? "",
    nightRelay: json["nightRelay"] ?? "",
    wetWallAuto: json["wetWallAuto"] ?? false ,
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
    "wetWallAuto": wetWallAuto,
  };
}