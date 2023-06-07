import 'dart:convert';

LightningModel lightningModelFromJson(String str) => LightningModel.fromJson(json.decode(str));

String lightningModelToJson(LightningModel data) => json.encode(data.toJson());

class LightningModel {
  LightningModel({
    this.dayTimeOn,
    this.dayTimeOff,
    this.dayOutput,
    this.nightTimeOn,
    this.nightTimeOff,
    this.nightOutput,
    this.daySpectrum,
    this.nightSpectrum,
  });

  String? dayTimeOn;
  String? dayTimeOff;
  double? dayOutput;
  String? nightTimeOn;
  String? nightTimeOff;
  double? nightOutput;
  String? daySpectrum;
  String? nightSpectrum;

  factory LightningModel.fromJson(Map<String, dynamic> json) => LightningModel(
    dayTimeOn: json["dayTimeOn"] ?? "",
    dayTimeOff: json["dayTimeOff"] ?? "",
    dayOutput: json["dayOutput"] != null ? json["dayOutput"].toDouble() : 0,
    nightTimeOn: json["nightTimeOn"] ?? "",
    nightTimeOff: json["nightTimeOff"] ?? "",
    nightOutput: json["nightOutput"] != null ? json["nightOutput"].toDouble() : 0,
    daySpectrum: json["daySpectrum"] ?? "",
    nightSpectrum: json["nightSpectrum"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "dayTimeOn": dayTimeOn,
    "dayTimeOff": dayTimeOff,
    "dayOutput": dayOutput,
    "nightTimeOn": nightTimeOn,
    "nightTimeOff": nightTimeOff,
    "nightOutput": nightOutput,
    "daySpectrum": daySpectrum,
    "nightSpectrum": nightSpectrum,
  };
}