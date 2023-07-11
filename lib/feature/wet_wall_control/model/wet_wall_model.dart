import 'dart:convert';

WetWallModel wetWallModelFromJson(String str) =>
    WetWallModel.fromJson(json.decode(str));

String wetWallModelToJson(WetWallModel data) => json.encode(data.toJson());

class WetWallModel {
  WetWallModel({
    this.message,
    this.wetWallControl,
  });

  String? message;
  WetWallControl? wetWallControl;

  factory WetWallModel.fromJson(Map<String, dynamic> json) => WetWallModel(
        message: json["message"] ?? "",
        wetWallControl: json["wetWallControl"] != null
            ? WetWallControl.fromJson(json["wetWallControl"])
            : WetWallControl(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "wetWallControl": wetWallControl!.toJson(),
      };
}

class WetWallControl {
  WetWallControl({
    this.id,
    this.dayTemperature,
    this.nightTemperature,
    this.dayTemperatureDeadband,
    this.nightTemperatureDeadband,
    this.daySwitch,
    this.nightSwitch,
    this.dayRelay,
    this.nightRelay,
    this.wetWallAuto,
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
  bool? wetWallAuto;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory WetWallControl.fromJson(Map<String, dynamic> json) => WetWallControl(
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
        wetWallAuto: json["wetWallAuto"] ?? false,
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
        "wetWallAuto": wetWallAuto,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "growControllerId": growControllerId,
      };
}
