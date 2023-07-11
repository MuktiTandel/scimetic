import 'dart:convert';

HumidityControlModel humidityControlModelFromJson(String str) =>
    HumidityControlModel.fromJson(json.decode(str));

String humidityControlModelToJson(HumidityControlModel data) =>
    json.encode(data.toJson());

class HumidityControlModel {
  HumidityControlModel({
    this.message,
    this.humidityControl,
  });

  String? message;
  HumidityControl? humidityControl;

  factory HumidityControlModel.fromJson(Map<String, dynamic> json) =>
      HumidityControlModel(
        message: json["message"] ?? "",
        humidityControl: json["humidityControl"] != null
            ? HumidityControl.fromJson(json["humidityControl"])
            : HumidityControl(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "humidityControl": humidityControl!.toJson(),
      };
}

class HumidityControl {
  HumidityControl({
    this.id,
    this.dayHumidityRh,
    this.dayHumidityRhDeadband,
    this.nightHumidityRh,
    this.nightHumidityRhDeadband,
    this.dayDehumidityRh,
    this.nightDehumidityRh,
    this.dayDehumidityRhDeadband,
    this.nightDehumidityRhDeadband,
    this.dayHumiditySwitch,
    this.nightHumiditySwitch,
    this.dayDehumiditySwitch,
    this.nightDehumiditySwitch,
    this.dayHumidityRelay,
    this.nightHumidityRelay,
    this.dayDehumidityRelay,
    this.nightDehumidityRelay,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  double? dayHumidityRh;
  double? dayHumidityRhDeadband;
  double? nightHumidityRh;
  double? nightHumidityRhDeadband;
  double? dayDehumidityRh;
  double? nightDehumidityRh;
  double? dayDehumidityRhDeadband;
  double? nightDehumidityRhDeadband;
  String? dayHumiditySwitch;
  String? nightHumiditySwitch;
  String? dayDehumiditySwitch;
  String? nightDehumiditySwitch;
  String? dayHumidityRelay;
  String? nightHumidityRelay;
  String? dayDehumidityRelay;
  String? nightDehumidityRelay;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory HumidityControl.fromJson(Map<String, dynamic> json) =>
      HumidityControl(
        id: json["id"] ?? 0,
        dayHumidityRh: json["dayHumidityRH"] != null
            ? json["dayHumidityRH"].toDouble()
            : 0,
        dayHumidityRhDeadband: json["dayHumidityRHDeadband"] != null
            ? json["dayHumidityRHDeadband"].toDouble()
            : 0,
        nightHumidityRh: json["nightHumidityRH"] != null
            ? json["nightHumidityRH"].toDouble()
            : 0,
        nightHumidityRhDeadband: json["nightHumidityRHDeadband"] != null
            ? json["nightHumidityRHDeadband"].toDouble()
            : 0,
        dayDehumidityRh: json["dayDehumidityRH"] != null
            ? json["dayDehumidityRH"].toDouble()
            : 0,
        nightDehumidityRh: json["nightDehumidityRH"] != null
            ? json["nightDehumidityRH"].toDouble()
            : 0,
        dayDehumidityRhDeadband: json["dayDehumidityRHDeadband"] != null
            ? json["dayDehumidityRHDeadband"].toDouble()
            : 0,
        nightDehumidityRhDeadband: json["nightDehumidityRHDeadband"] != null
            ? json["nightDehumidityRHDeadband"].toDouble()
            : 0,
        dayHumiditySwitch: json["dayHumiditySwitch"] ?? "",
        nightHumiditySwitch: json["nightHumiditySwitch"] ?? "",
        dayDehumiditySwitch: json["dayDehumiditySwitch"] ?? "",
        nightDehumiditySwitch: json["nightDehumiditySwitch"] ?? "",
        dayHumidityRelay: json["dayHumidityRelay"] ?? "",
        nightHumidityRelay: json["nightHumidityRelay"] ?? "",
        dayDehumidityRelay: json["dayDehumidityRelay"] ?? "",
        nightDehumidityRelay: json["nightDehumidityRelay"] ?? "",
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
        "dayHumidityRH": dayHumidityRh,
        "dayHumidityRHDeadband": dayHumidityRhDeadband,
        "nightHumidityRH": nightHumidityRh,
        "nightHumidityRHDeadband": nightHumidityRhDeadband,
        "dayDehumidityRH": dayDehumidityRh,
        "nightDehumidityRH": nightDehumidityRh,
        "dayDehumidityRHDeadband": dayDehumidityRhDeadband,
        "nightDehumidityRHDeadband": nightDehumidityRhDeadband,
        "dayHumiditySwitch": dayHumiditySwitch,
        "nightHumiditySwitch": nightHumiditySwitch,
        "dayDehumiditySwitch": dayDehumiditySwitch,
        "nightDehumiditySwitch": nightDehumiditySwitch,
        "dayHumidityRelay": dayHumidityRelay,
        "nightHumidityRelay": nightHumidityRelay,
        "dayDehumidityRelay": dayDehumidityRelay,
        "nightDehumidityRelay": nightDehumidityRelay,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "growControllerId": growControllerId,
      };
}
