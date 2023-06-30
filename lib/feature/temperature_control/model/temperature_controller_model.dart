import 'dart:convert';

TemperatureControllerModel temperatureControllerModelFromJson(String str) => TemperatureControllerModel.fromJson(json.decode(str));

String temperatureControllerModelToJson(TemperatureControllerModel data) => json.encode(data.toJson());

class TemperatureControllerModel {
  TemperatureControllerModel({
    this.message,
    this.temperatureControl,
  });

  String? message;
  TemperatureControl? temperatureControl;

  factory TemperatureControllerModel.fromJson(Map<String, dynamic> json) => TemperatureControllerModel(
    message: json["message"] ?? "",
    temperatureControl: json["temperatureControl"] != null
        ? TemperatureControl.fromJson(json["temperatureControl"]) : TemperatureControl(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "temperatureControl": temperatureControl!.toJson(),
  };
}

class TemperatureControl {
  TemperatureControl({
    this.id,
    this.dayCoolingSwitch,
    this.nightCoolingSwitch,
    this.dayHeatingSwitch,
    this.nightHeatingSwitch,
    this.dayCoolingRelay,
    this.nightCoolingRelay,
    this.dayHeatingRelay,
    this.nightHeatingRelay,
    this.dayTemperatureExtractorFan,
    this.nightTemperatureExtractorFan,
    this.dayTemperatureWetWall,
    this.nightTemperatureWetWall,
    this.daySwitchExtractorFan,
    this.nightSwitchExtractorFan,
    this.daySwitchWetWall,
    this.nightSwitchWetWall,
    this.dayRelayExtractorFan,
    this.nightRelayExtractorFan,
    this.dayRelayWetWall,
    this.nightRelayWetWall,
    this.coolingAuto,
    this.heatingAuto,
    this.extractorFanAuto,
    this.wetWallAuto,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  String? dayCoolingSwitch;
  String? nightCoolingSwitch;
  String? dayHeatingSwitch;
  String? nightHeatingSwitch;
  String? dayCoolingRelay;
  String? nightCoolingRelay;
  String? dayHeatingRelay;
  String? nightHeatingRelay;
  dynamic dayTemperatureExtractorFan;
  dynamic nightTemperatureExtractorFan;
  dynamic dayTemperatureWetWall;
  dynamic nightTemperatureWetWall;
  String? daySwitchExtractorFan;
  String? nightSwitchExtractorFan;
  String? daySwitchWetWall;
  String? nightSwitchWetWall;
  String? dayRelayExtractorFan;
  String? nightRelayExtractorFan;
  String? dayRelayWetWall;
  String? nightRelayWetWall;
  bool? coolingAuto;
  bool? heatingAuto;
  bool? extractorFanAuto;
  bool? wetWallAuto;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory TemperatureControl.fromJson(Map<String, dynamic> json) => TemperatureControl(
    id: json["id"] ?? 0,
    dayCoolingSwitch: json["dayCoolingSwitch"] ?? "",
    nightCoolingSwitch: json["nightCoolingSwitch"] ?? "",
    dayHeatingSwitch: json["dayHeatingSwitch"] ?? "",
    nightHeatingSwitch: json["nightHeatingSwitch"] ?? "",
    dayCoolingRelay: json["dayCoolingRelay"] ?? "",
    nightCoolingRelay: json["nightCoolingRelay"] ?? "",
    dayHeatingRelay: json["dayHeatingRelay"] ?? "",
    nightHeatingRelay: json["nightHeatingRelay"] ?? "",
    dayTemperatureExtractorFan: json["dayTemperatureExtractorFan"] ?? "",
    nightTemperatureExtractorFan: json["nightTemperatureExtractorFan"] ?? "",
    dayTemperatureWetWall: json["dayTemperatureWetWall"] ?? "",
    nightTemperatureWetWall: json["nightTemperatureWetWall"] ?? "",
    daySwitchExtractorFan: json["daySwitchExtractorFan"] ?? "",
    nightSwitchExtractorFan: json["nightSwitchExtractorFan"] ?? "",
    daySwitchWetWall: json["daySwitchWetWall"] ?? "",
    nightSwitchWetWall: json["nightSwitchWetWall"] ?? "",
    dayRelayExtractorFan: json["dayRelayExtractorFan"] ?? "",
    nightRelayExtractorFan: json["nightRelayExtractorFan"] ?? "",
    dayRelayWetWall: json["dayRelayWetWall"] ?? "",
    nightRelayWetWall: json["nightRelayWetWall"] ?? "",
    coolingAuto: json["coolingAuto"] ?? false,
    heatingAuto: json["heatingAuto"] ?? false,
    extractorFanAuto: json["extractorFanAuto"] ?? false,
    wetWallAuto: json["wetWallAuto"] ?? false,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayCoolingSwitch": dayCoolingSwitch,
    "nightCoolingSwitch": nightCoolingSwitch,
    "dayHeatingSwitch": dayHeatingSwitch,
    "nightHeatingSwitch": nightHeatingSwitch,
    "dayCoolingRelay": dayCoolingRelay,
    "nightCoolingRelay": nightCoolingRelay,
    "dayHeatingRelay": dayHeatingRelay,
    "nightHeatingRelay": nightHeatingRelay,
    "dayTemperatureExtractorFan": dayTemperatureExtractorFan,
    "nightTemperatureExtractorFan": nightTemperatureExtractorFan,
    "dayTemperatureWetWall": dayTemperatureWetWall,
    "nightTemperatureWetWall": nightTemperatureWetWall,
    "daySwitchExtractorFan": daySwitchExtractorFan,
    "nightSwitchExtractorFan": nightSwitchExtractorFan,
    "daySwitchWetWall": daySwitchWetWall,
    "nightSwitchWetWall": nightSwitchWetWall,
    "dayRelayExtractorFan": dayRelayExtractorFan,
    "nightRelayExtractorFan": nightRelayExtractorFan,
    "dayRelayWetWall": dayRelayWetWall,
    "nightRelayWetWall": nightRelayWetWall,
    "coolingAuto": coolingAuto,
    "heatingAuto": heatingAuto,
    "extractorFanAuto": extractorFanAuto,
    "wetWallAuto": wetWallAuto,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growControllerId": growControllerId,
  };
}