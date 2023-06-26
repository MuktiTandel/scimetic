import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.angles,
    this.data,
    this.totalPeriod,
    this.currentDays,
  });

  dynamic angles;
  StageData? data;
  int? totalPeriod;
  int? currentDays;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    angles: json["angles"] ?? "",
    data: json["data"] != null ? StageData.fromJson(json["data"]) : StageData(),
    totalPeriod: json["totalPeriod"] ?? 0,
    currentDays: json["currentDays"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "angles": angles,
    "data": data!.toJson(),
    "totalPeriod": totalPeriod,
    "currentDays": currentDays,
  };
}

class StageData {
  StageData({
    this.germination,
    this.seedling,
    this.vegetative,
    this.flowering,
  });

  double? germination;
  double? seedling;
  double? vegetative;
  double? flowering;

  factory StageData.fromJson(Map<String, dynamic> json) => StageData(
    germination: json["germination"] != null ? json["germination"].toDouble() : 0,
    seedling: json["seedling"] != null ? json["seedling"].toDouble() : 0,
    vegetative: json["vegetative"] != null ? json["vegetative"].toDouble() : 0,
    flowering: json["flowering"] != null ? json["flowering"].toDouble() : 0,
  );

  Map<String, dynamic> toJson() => {
    "germination": germination,
    "seedling": seedling,
    "vegetative": vegetative,
    "flowering": flowering,
  };
}