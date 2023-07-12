import 'dart:convert';

ExtractorFanModel extractorFanModelFromJson(String str) =>
    ExtractorFanModel.fromJson(json.decode(str));

String extractorFanModelToJson(ExtractorFanModel data) =>
    json.encode(data.toJson());

class ExtractorFanModel {
  ExtractorFanModel({
    this.message,
    this.extractorFanControl,
  });

  String? message;
  ExtractorFanControl? extractorFanControl;

  factory ExtractorFanModel.fromJson(Map<String, dynamic> json) =>
      ExtractorFanModel(
        message: json["message"] ?? "",
        extractorFanControl: json["extractorFanControl"] != null
            ? ExtractorFanControl.fromJson(json["extractorFanControl"])
            : ExtractorFanControl(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "extractorFanControl": extractorFanControl!.toJson(),
      };
}

class ExtractorFanControl {
  ExtractorFanControl({
    this.id,
    this.dayTemperature,
    this.nightTemperature,
    this.dayTemperatureDeadband,
    this.nightTemperatureDeadband,
    this.daySwitch,
    this.nightSwitch,
    this.dayRelay,
    this.nightRelay,
    this.extractorFanAuto,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  double? dayTemperature;
  double? nightTemperature;
  double? dayTemperatureDeadband;
  double? nightTemperatureDeadband;
  String? daySwitch;
  String? nightSwitch;
  String? dayRelay;
  String? nightRelay;
  bool? extractorFanAuto;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory ExtractorFanControl.fromJson(Map<String, dynamic> json) =>
      ExtractorFanControl(
        id: json["id"] ?? 0,
        dayTemperature: json["dayTemperature"] != null
            ? json["dayTemperature"].toDouble()
            : 0,
        nightTemperature: json["nightTemperature"] != null
            ? json["nightTemperature"].toDouble()
            : 0,
        dayTemperatureDeadband: json["dayTemperatureDeadband"] != null
            ? json["dayTemperatureDeadband"].toDouble()
            : 0,
        nightTemperatureDeadband: json["nightTemperatureDeadband"] != null
            ? json["nightTemperatureDeadband"].toDouble()
            : 0,
        daySwitch: json["daySwitch"] ?? "",
        nightSwitch: json["nightSwitch"] ?? "",
        dayRelay: json["dayRelay"] ?? "",
        nightRelay: json["nightRelay"] ?? "",
        extractorFanAuto: json["extractorFanAuto"] ?? false,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        growControllerId: json["growControllerId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dayTemperature": dayTemperature,
        "nightTemperature": nightTemperature,
        "dayTemperatureDeadband": dayTemperatureDeadband,
        "nightTemperatureDeadband": nightTemperatureDeadband,
        "daySwitch": daySwitch,
        "nightSwitch": nightSwitch,
        "dayRelay": dayRelay,
        "nightRelay": nightRelay,
        "extractorFanAuto": extractorFanAuto,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "growControllerId": growControllerId,
      };
}
