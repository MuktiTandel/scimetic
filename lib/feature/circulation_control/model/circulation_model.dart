import 'dart:convert';

CirculationModel circulationModelFromJson(String str) => CirculationModel.fromJson(json.decode(str));

String circulationModelToJson(CirculationModel data) => json.encode(data.toJson());

class CirculationModel {
  CirculationModel({
    this.message,
    this.circulationFanControl,
  });

  String? message;
  CirculationFanControl? circulationFanControl;

  factory CirculationModel.fromJson(Map<String, dynamic> json) => CirculationModel(
    message: json["message"] ?? "",
    circulationFanControl: json["circulationFanControl"] != null
        ? CirculationFanControl.fromJson(json["circulationFanControl"])
        : CirculationFanControl(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "circulationFanControl": circulationFanControl!.toJson(),
  };
}

class CirculationFanControl {
  CirculationFanControl({
    this.id,
    this.temperatureOff,
    this.temperatureOffDeadband,
    this.humidityOn,
    this.humidityOnDeadband,
    this.timeOn,
    this.timeOff,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  dynamic temperatureOff;
  dynamic temperatureOffDeadband;
  dynamic humidityOn;
  dynamic humidityOnDeadband;
  String? timeOn;
  String? timeOff;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory CirculationFanControl.fromJson(Map<String, dynamic> json) => CirculationFanControl(
    id: json["id"] ?? 0,
    temperatureOff: json["temperatureOff"] ?? 0,
    temperatureOffDeadband: json["temperatureOffDeadband"] ?? 0,
    humidityOn: json["humidityOn"] ?? 0,
    humidityOnDeadband: json["humidityOnDeadband"] ?? 0,
    timeOn: json["timeOn"] ?? "",
    timeOff: json["timeOff"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "temperatureOff": temperatureOff,
    "temperatureOffDeadband": temperatureOffDeadband,
    "humidityOn": humidityOn,
    "humidityOnDeadband": humidityOnDeadband,
    "timeOn": timeOn,
    "timeOff": timeOff,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growControllerId": growControllerId,
  };
}