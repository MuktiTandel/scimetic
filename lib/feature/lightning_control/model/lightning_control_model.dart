import 'dart:convert';

LightningControlModel lightningControlModelFromJson(String str) =>
    LightningControlModel.fromJson(json.decode(str));

String lightningControlModelToJson(LightningControlModel data) =>
    json.encode(data.toJson());

class LightningControlModel {
  LightningControlModel({
    this.message,
    this.lightingControl,
  });

  String? message;
  LightingControl? lightingControl;

  factory LightningControlModel.fromJson(Map<String, dynamic> json) =>
      LightningControlModel(
        message: json["message"] ?? "",
        lightingControl: json["lightingControl"] != null
            ? LightingControl.fromJson(json["lightingControl"])
            : LightingControl(),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "lightingControl": lightingControl!.toJson(),
      };
}

class LightingControl {
  LightingControl({
    this.id,
    this.dayTimeOn,
    this.dayTimeOff,
    this.dayOutput,
    this.nightTimeOn,
    this.nightTimeOff,
    this.nightOutput,
    this.daySpectrum,
    this.nightSpectrum,
    this.createdAt,
    this.updatedAt,
    this.lightingBankId,
    this.growControllerId,
  });

  int? id;
  String? dayTimeOn;
  String? dayTimeOff;
  double? dayOutput;
  String? nightTimeOn;
  String? nightTimeOff;
  double? nightOutput;
  String? daySpectrum;
  String? nightSpectrum;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic lightingBankId;
  int? growControllerId;

  factory LightingControl.fromJson(Map<String, dynamic> json) =>
      LightingControl(
        id: json["id"] ?? 0,
        dayTimeOn: json["dayTimeOn"] ?? "",
        dayTimeOff: json["dayTimeOff"] ?? "",
        dayOutput: json["dayOutput"] != null ? json["dayOutput"].toDouble() : 0,
        nightTimeOn: json["nightTimeOn"] ?? "",
        nightTimeOff: json["nightTimeOff"] ?? "",
        nightOutput:
            json["nightOutput"] != null ? json["nightOutput"].toDouble() : 0,
        daySpectrum: json["daySpectrum"] ?? "",
        nightSpectrum: json["nightSpectrum"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        lightingBankId: json["lightingBankId"] ?? 0,
        growControllerId: json["growControllerId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dayTimeOn": dayTimeOn,
        "dayTimeOff": dayTimeOff,
        "dayOutput": dayOutput,
        "nightTimeOn": nightTimeOn,
        "nightTimeOff": nightTimeOff,
        "nightOutput": nightOutput,
        "daySpectrum": daySpectrum,
        "nightSpectrum": nightSpectrum,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "lightingBankId": lightingBankId,
        "growControllerId": growControllerId,
      };
}
