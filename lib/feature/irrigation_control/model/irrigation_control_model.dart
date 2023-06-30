import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

IrrigationControlModel irrigationControlModelFromJson(String str) => IrrigationControlModel.fromJson(json.decode(str));

String irrigationControlModelToJson(IrrigationControlModel data) => json.encode(data.toJson());

class IrrigationControlModel {
  IrrigationControlModel({
    this.message,
    this.irrigationControls,
  });

  String? message;
  List<IrrigationControl>? irrigationControls;

  factory IrrigationControlModel.fromJson(Map<String, dynamic> json) => IrrigationControlModel(
    message: json["message"] ?? "",
    irrigationControls: json["irrigationControls"] != null
        ? List<IrrigationControl>.from(json["irrigationControls"].map((x) => IrrigationControl.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "irrigationControls": List<dynamic>.from(irrigationControls!.map((x) => x.toJson())),
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
    this.growController,
    this.schedules,
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
  GrowController? growController;
  List<Schedule>? schedules;

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
    growController: json["growController"] != null ? GrowController.fromJson(json["growController"]) : GrowController(),
    schedules: json["schedules"] != null ? List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))) : null,
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
    "growController": growController!.toJson(),
    "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
  };
}

class Schedule {
  Schedule({
    this.id,
    this.dayTimeActivate,
    this.nightTimeActivate,
    this.createdAt,
    this.updatedAt,
    this.irrigationSchedule,
  });

  int? id;
  String? dayTimeActivate;
  String? nightTimeActivate;
  DateTime? createdAt;
  DateTime? updatedAt;
  IrrigationSchedule? irrigationSchedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["id"] ?? 0,
    dayTimeActivate: json["dayTimeActivate"] ?? "",
    nightTimeActivate: json["nightTimeActivate"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    irrigationSchedule: json["irrigation_schedule"] != null
        ? IrrigationSchedule.fromJson(json["irrigation_schedule"])
        : IrrigationSchedule(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayTimeActivate": dayTimeActivate,
    "nightTimeActivate": nightTimeActivate,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "irrigation_schedule": irrigationSchedule!.toJson(),
  };
}

class IrrigationSchedule {
  IrrigationSchedule({
    this.createdAt,
    this.updatedAt,
    this.irrigationControlId,
    this.scheduleId,
  });

  DateTime? createdAt;
  DateTime? updatedAt;
  int? irrigationControlId;
  int? scheduleId;

  factory IrrigationSchedule.fromJson(Map<String, dynamic> json) => IrrigationSchedule(
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    irrigationControlId: json["irrigationControlId"] ?? 0,
    scheduleId: json["scheduleId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "irrigationControlId": irrigationControlId,
    "scheduleId": scheduleId,
  };
}