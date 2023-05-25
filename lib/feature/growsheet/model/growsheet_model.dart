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
  List<Growsheet>? growsheets;

  factory GrowSheetData.fromJson(Map<String, dynamic> json) => GrowSheetData(
    message: json["message"] ?? "",
    growsheets: List<Growsheet>.from(json["growsheets"].map((x) => Growsheet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "growsheets": List<dynamic>.from(growsheets!.map((x) => x.toJson())),
  };
}

class Growsheet {
  Growsheet({
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
  String? seedBank;
  String? tag;
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
  int? irrigationControlId;
  int? fertigationControlId01;
  int? fertigationControlId02;
  int? growControllerId;
  int? companyId;
  IrrigationControl? irrigationControl;
  FertigationControl0? fertigationControl01;
  FertigationControl0? fertigationControl02;
  GrowController? growController;
  Company? company;

  factory Growsheet.fromJson(Map<String, dynamic> json) => Growsheet(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    seedBank: json["seedBank"] ?? "",
    tag: json["tag"] ?? "",
    dayTargetTemperature: json["dayTargetTemperature"] ?? 0,
    dayTemperatureDeadband: json["dayTemperatureDeadband"] ?? 0,
    dayTargetRelativeHumidity: json["dayTargetRelativeHumidity"] ?? 0,
    dayHumidityDeadband: json["dayHumidityDeadband"] ?? 0,
    dayTargetCo2: json["dayTargetCO2"] ?? 0,
    dayCo2Deadband: json["dayCO2Deadband"] ?? 0,
    dayLightTimeOn: json["dayLightTimeOn"] ?? "",
    dayLightTimeOff: json["dayLightTimeOff"] ?? "",
    nightTargetTemperature: json["nightTargetTemperature"] ?? 0,
    nightTemperatureDeadband: json["nightTemperatureDeadband"] ?? 0,
    nightTargetRelativeHumidity: json["nightTargetRelativeHumidity"] ?? 0,
    nightHumidityDeadband: json["nightHumidityDeadband"] ?? 0,
    nightTargetCo2: json["nightTargetCO2"] ?? 0,
    nightCo2Deadband: json["nightCO2Deadband"] ?? 0,
    nightLightTimeOn: json["nightLightTimeOn"] ?? "",
    nightLightTimeOff: json["nightLightTimeOff"] ?? "",
    applied: json["applied"] ?? false,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    irrigationControlId: json["irrigationControlId"] ?? 0,
    fertigationControlId01: json["fertigationControlId01"] ?? 0,
    fertigationControlId02: json["fertigationControlId02"] ?? 0,
    growControllerId: json["growControllerId"] ?? 0,
    companyId: json["companyId"] ?? 0,
    irrigationControl: json["irrigationControl"] == null ? IrrigationControl() : IrrigationControl.fromJson(json["irrigationControl"]),
    fertigationControl01: json["fertigationControl01"] == null ? FertigationControl0() : FertigationControl0.fromJson(json["fertigationControl01"]),
    fertigationControl02: json["fertigationControl02"] == null ? FertigationControl0() : FertigationControl0.fromJson(json["fertigationControl02"]),
    growController: GrowController.fromJson(json["growController"]),
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "seedBank": seedBank == null ? null : seedBank,
    "tag": tag == null ? null : tag,
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
    "irrigationControl": irrigationControl == null ? null : irrigationControl!.toJson(),
    "fertigationControl01": fertigationControl01 == null ? null : fertigationControl01!.toJson(),
    "fertigationControl02": fertigationControl02 == null ? null : fertigationControl02!.toJson(),
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
    name: json["name"] ?? "",
    address: json["address"],
    logo: json["logo"],
    registrationNumber: json["registrationNumber"],
    licenseNumber: json["licenseNumber"],
    mobileNumber: json["mobileNumber"],
    email: json["email"],
    website: json["website"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
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

class FertigationControl0 {
  FertigationControl0({
    this.id,
    this.name,
    this.description,
    this.tag,
    this.applied,
    this.favorite,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  String? name;
  String? description;
  String? tag;
  bool? applied;
  bool? favorite;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory FertigationControl0.fromJson(Map<String, dynamic> json) => FertigationControl0(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    tag: json["tag"] ?? "",
    applied: json["applied"] ?? false,
    favorite: json["favorite"] ?? false,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "tag": tag,
    "applied": applied,
    "favorite": favorite,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growControllerId": growControllerId,
  };
}

class IrrigationControl {
  IrrigationControl({
    this.id,
    this.name,
    this.description,
    this.tag,
    this.applied,
    this.favorite,
    this.day100Temperature,
    this.day100Duration,
    this.night100Temperature,
    this.night100Duration,
    this.day0Temperature,
    this.day0Duration,
    this.night0Temperature,
    this.night0Duration,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
  });

  int? id;
  String? name;
  String? description;
  String? tag;
  bool? applied;
  bool? favorite;
  int? day100Temperature;
  int? day100Duration;
  int? night100Temperature;
  int? night100Duration;
  int? day0Temperature;
  int? day0Duration;
  int? night0Temperature;
  int? night0Duration;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;

  factory IrrigationControl.fromJson(Map<String, dynamic> json) => IrrigationControl(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    tag: json["tag"] ?? "",
    applied: json["applied"] ?? false,
    favorite: json["favorite"] ?? false,
    day100Temperature: json["day100Temperature"] ?? 0,
    day100Duration: json["day100Duration"] ?? 0,
    night100Temperature: json["night100Temperature"] ?? 0,
    night100Duration: json["night100Duration"] ?? 0,
    day0Temperature: json["day0Temperature"] ?? 0,
    day0Duration: json["day0Duration"] ?? 0,
    night0Temperature: json["night0Temperature"] ?? 0,
    night0Duration: json["night0Duration"] ?? 0,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "tag": tag,
    "applied": applied,
    "favorite": favorite,
    "day100Temperature": day100Temperature,
    "day100Duration": day100Duration,
    "night100Temperature": night100Temperature,
    "night100Duration": night100Duration,
    "day0Temperature": day0Temperature,
    "day0Duration": day0Duration,
    "night0Temperature": night0Temperature,
    "night0Duration": night0Duration,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growControllerId": growControllerId,
  };
}