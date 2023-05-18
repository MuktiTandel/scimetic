import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

GrowSheetData growSheetDataFromJson(String str) => GrowSheetData.fromJson(json.decode(str));

String growSheetDataToJson(GrowSheetData data) => json.encode(data.toJson());

class GrowSheetData {
  GrowSheetData({
    this.message,
    this.growsheets,
  });

  String? message;
  List<GrowSheet>? growsheets;

  factory GrowSheetData.fromJson(Map<String, dynamic> json) => GrowSheetData(
    message: json["message"] ?? "",
    growsheets: List<GrowSheet>.from(json["growsheets"].map((x) => GrowSheet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "growsheets": List<dynamic>.from(growsheets!.map((x) => x.toJson())),
  };
}

class GrowSheet {
  GrowSheet({
    this.id,
    this.name,
    this.description,
    this.seedBank,
    this.tag,
    this.dayTargetTemperature,
    this.dayTemperatureDeadband,
    this.dayTargetRelativeHumidity,
    this.dayHumidityDeadband,
    this.dayTargetCo2,
    this.dayCo2Deadband,
    this.dayLightTimeOn,
    this.dayLightTimeOff,
    this.nightTargetTemperature,
    this.nightTemperatureDeadband,
    this.nightTargetRelativeHumidity,
    this.nightHumidityDeadband,
    this.nightTargetCo2,
    this.nightCo2Deadband,
    this.nightLightTimeOn,
    this.nightLightTimeOff,
    this.applied,
    this.createdAt,
    this.updatedAt,
    this.irrigationControlId,
    this.fertigationControlId01,
    this.fertigationControlId02,
    this.growControllerId,
    this.companyId,
    this.irrigationControl,
    this.fertigationControl01,
    this.fertigationControl02,
    this.growController,
    this.company,
  });

  int? id;
  String? name;
  String? description;
  dynamic seedBank;
  dynamic tag;
  int? dayTargetTemperature;
  int? dayTemperatureDeadband;
  int? dayTargetRelativeHumidity;
  int? dayHumidityDeadband;
  int? dayTargetCo2;
  int? dayCo2Deadband;
  String? dayLightTimeOn;
  String? dayLightTimeOff;
  int? nightTargetTemperature;
  int? nightTemperatureDeadband;
  int? nightTargetRelativeHumidity;
  int? nightHumidityDeadband;
  int? nightTargetCo2;
  int? nightCo2Deadband;
  String? nightLightTimeOn;
  String? nightLightTimeOff;
  bool? applied;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic irrigationControlId;
  dynamic fertigationControlId01;
  dynamic fertigationControlId02;
  int? growControllerId;
  int? companyId;
  dynamic irrigationControl;
  dynamic fertigationControl01;
  dynamic fertigationControl02;
  GrowController? growController;
  Company? company;

  factory GrowSheet.fromJson(Map<String, dynamic> json) => GrowSheet(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    seedBank: json["seedBank"],
    tag: json["tag"],
    dayTargetTemperature: json["dayTargetTemperature"] ?? 0,
    dayTemperatureDeadband: json["dayTemperatureDeadband"] ?? 0,
    dayTargetRelativeHumidity: json["dayTargetRelativeHumidity"] ?? 0,
    dayHumidityDeadband: json["dayHumidityDeadband"] ?? 0,
    dayTargetCo2: json["dayTargetCO2"] ?? 0,
    dayCo2Deadband: json["dayCO2Deadband"] ?? 0,
    dayLightTimeOn: json["dayLightTimeOn"] ?? '',
    dayLightTimeOff: json["dayLightTimeOff"] ?? '',
    nightTargetTemperature: json["nightTargetTemperature"] ?? 0,
    nightTemperatureDeadband: json["nightTemperatureDeadband"] ?? 0,
    nightTargetRelativeHumidity: json["nightTargetRelativeHumidity"] ?? 0,
    nightHumidityDeadband: json["nightHumidityDeadband"] ?? 0,
    nightTargetCo2: json["nightTargetCO2"] ?? 0,
    nightCo2Deadband: json["nightCO2Deadband"] ?? 0,
    nightLightTimeOn: json["nightLightTimeOn"] ?? "",
    nightLightTimeOff: json["nightLightTimeOff"] ?? "",
    applied: json["applied"] ?? false,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    irrigationControlId: json["irrigationControlId"],
    fertigationControlId01: json["fertigationControlId01"],
    fertigationControlId02: json["fertigationControlId02"],
    growControllerId: json["growControllerId"] ?? 0,
    companyId: json["companyId"] ?? 0,
    irrigationControl: json["irrigationControl"],
    fertigationControl01: json["fertigationControl01"],
    fertigationControl02: json["fertigationControl02"],
    growController: GrowController.fromJson(json["growController"]),
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "seedBank": seedBank,
    "tag": tag,
    "dayTargetTemperature": dayTargetTemperature,
    "dayTemperatureDeadband": dayTemperatureDeadband,
    "dayTargetRelativeHumidity": dayTargetRelativeHumidity,
    "dayHumidityDeadband": dayHumidityDeadband,
    "dayTargetCO2": dayTargetCo2,
    "dayCO2Deadband": dayCo2Deadband,
    "dayLightTimeOn": dayLightTimeOn,
    "dayLightTimeOff": dayLightTimeOff,
    "nightTargetTemperature": nightTargetTemperature,
    "nightTemperatureDeadband": nightTemperatureDeadband,
    "nightTargetRelativeHumidity": nightTargetRelativeHumidity,
    "nightHumidityDeadband": nightHumidityDeadband,
    "nightTargetCO2": nightTargetCo2,
    "nightCO2Deadband": nightCo2Deadband,
    "nightLightTimeOn": nightLightTimeOn,
    "nightLightTimeOff": nightLightTimeOff,
    "applied": applied,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "irrigationControlId": irrigationControlId,
    "fertigationControlId01": fertigationControlId01,
    "fertigationControlId02": fertigationControlId02,
    "growControllerId": growControllerId,
    "companyId": companyId,
    "irrigationControl": irrigationControl,
    "fertigationControl01": fertigationControl01,
    "fertigationControl02": fertigationControl02,
    "growController": growController!.toJson(),
    "company": company!.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.name,
    this.address,
    this.logo,
    this.registrationNumber,
    this.licenseNumber,
    this.mobileNumber,
    this.email,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic address;
  dynamic logo;
  dynamic registrationNumber;
  dynamic licenseNumber;
  dynamic mobileNumber;
  dynamic email;
  dynamic website;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    address: json["address"],
    logo: json["logo"],
    registrationNumber: json["registrationNumber"],
    licenseNumber: json["licenseNumber"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    website: json["website"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "logo": logo,
    "registrationNumber": registrationNumber,
    "licenseNumber": licenseNumber,
    "mobileNumber": mobileNumber,
    "email": email,
    "website": website,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}