import 'dart:convert';

IrrigationModel irrigationModelFromJson(String str) => IrrigationModel.fromJson(json.decode(str));

String irrigationModelToJson(IrrigationModel data) => json.encode(data.toJson());

class IrrigationModel {
  IrrigationModel({
    this.tag,
    this.description,
    this.name,
    this.day100Temperature,
    this.day100Duration,
    this.night100Temperature,
    this.night100Duration,
    this.day0Temperature,
    this.day0Duration,
    this.night0Temperature,
    this.night0Duration,
    this.schedules,
  });

  String? tag;
  String? description;
  String? name;
  int? day100Temperature;
  int? day100Duration;
  int? night100Temperature;
  int? night100Duration;
  int? day0Temperature;
  int? day0Duration;
  int? night0Temperature;
  int? night0Duration;
  List<Schedule1>? schedules;

  factory IrrigationModel.fromJson(Map<String, dynamic> json) => IrrigationModel(
    tag: json["tag"] ?? "",
    description: json["description"] ?? "",
    name: json["name"] ?? "",
    day100Temperature: json["day100Temperature"] ?? 0,
    day100Duration: json["day100Duration"] ?? 0,
    night100Temperature: json["night100Temperature"] ?? 0,
    night100Duration: json["night100Duration"] ?? 0,
    day0Temperature: json["day0Temperature"] ?? 0,
    day0Duration: json["day0Duration"] ?? 0,
    night0Temperature: json["night0Temperature"] ?? 0,
    night0Duration: json["night0Duration"] ?? 0,
    schedules: json["schedules"] != null
        ? List<Schedule1>.from(json["schedules"].map((x) => Schedule1.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "tag": tag,
    "description": description,
    "name": name,
    "day100Temperature": day100Temperature,
    "day100Duration": day100Duration,
    "night100Temperature": night100Temperature,
    "night100Duration": night100Duration,
    "day0Temperature": day0Temperature,
    "day0Duration": day0Duration,
    "night0Temperature": night0Temperature,
    "night0Duration": night0Duration,
    "schedules": List<dynamic>.from(schedules!.map((x) => x.toJson())),
  };
}

class Schedule1 {
  Schedule1({
    this.dayTimeActivate,
    this.nightTimeActivate,
  });

  String? dayTimeActivate;
  String? nightTimeActivate;

  factory Schedule1.fromJson(Map<String, dynamic> json) => Schedule1(
    dayTimeActivate: json["dayTimeActivate"] ?? "",
    nightTimeActivate: json["nightTimeActivate"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "dayTimeActivate": dayTimeActivate,
    "nightTimeActivate": nightTimeActivate,
  };
}