import 'dart:convert';

Co2ControlModel co2ControlModelFromJson(String str) => Co2ControlModel.fromJson(json.decode(str));

String co2ControlModelToJson(Co2ControlModel data) => json.encode(data.toJson());

class Co2ControlModel {
  Co2ControlModel({
    this.message,
    this.co2Control,
  });

  String? message;
  Co2Control? co2Control;

  factory Co2ControlModel.fromJson(Map<String, dynamic> json) => Co2ControlModel(
    message: json["message"] ?? "",
    co2Control: json["co2Control"] != null ? Co2Control.fromJson(json["co2Control"]) : Co2Control(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "co2Control": co2Control!.toJson(),
  };
}

class Co2Control {
  Co2Control({
    this.id,
    this.dayMinLevel,
    this.dayMaxLevel,
    this.dayHighLevel,
    this.daySwitch,
    this.dayRelay,
    this.nightMinLevel,
    this.nightMaxLevel,
    this.nightHighLevel,
    this.nightSwitch,
    this.nightRelay,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  int? dayMinLevel;
  int? dayMaxLevel;
  int? dayHighLevel;
  String? daySwitch;
  String? dayRelay;
  int? nightMinLevel;
  int? nightMaxLevel;
  int? nightHighLevel;
  String? nightSwitch;
  String? nightRelay;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory Co2Control.fromJson(Map<String, dynamic> json) => Co2Control(
    id: json["id"] ?? 0,
    dayMinLevel: json["dayMinLevel"] ?? 0,
    dayMaxLevel: json["dayMaxLevel"] ?? 0,
    dayHighLevel: json["dayHighLevel"] ?? 0,
    daySwitch: json["daySwitch"] ?? "",
    dayRelay: json["dayRelay"] ?? "",
    nightMinLevel: json["nightMinLevel"] ?? 0,
    nightMaxLevel: json["nightMaxLevel"] ?? 0,
    nightHighLevel: json["nightHighLevel"] ?? 0,
    nightSwitch: json["nightSwitch"] ?? "",
    nightRelay: json["nightRelay"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayMinLevel": dayMinLevel,
    "dayMaxLevel": dayMaxLevel,
    "dayHighLevel": dayHighLevel,
    "daySwitch": daySwitch,
    "dayRelay": dayRelay,
    "nightMinLevel": nightMinLevel,
    "nightMaxLevel": nightMaxLevel,
    "nightHighLevel": nightHighLevel,
    "nightSwitch": nightSwitch,
    "nightRelay": nightRelay,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growControllerId": growControllerId,
  };
}