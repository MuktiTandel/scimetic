import 'dart:convert';

CreateGrowSheet createGrowSheetFromJson(String str) => CreateGrowSheet.fromJson(json.decode(str));

String createGrowSheetToJson(CreateGrowSheet data) => json.encode(data.toJson());

class CreateGrowSheet {
  CreateGrowSheet({
    this.strain,
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
    this.fertigationControlId01,
    this.fertigationControlId02,
    this.irrigationControlId
  });

  String? strain;
  String? description;
  String? seedBank;
  String? tag;
  double? dayTargetTemperature;
  double? dayTemperatureDeadband;
  double? dayTargetRelativeHumidity;
  double? dayHumidityDeadband;
  double? dayTargetCo2;
  double? dayCo2Deadband;
  String? dayLightTimeOn;
  String? dayLightTimeOff;
  double? nightTargetTemperature;
  double? nightTemperatureDeadband;
  double? nightTargetRelativeHumidity;
  double? nightHumidityDeadband;
  double? nightTargetCo2;
  double? nightCo2Deadband;
  String? nightLightTimeOn;
  String? nightLightTimeOff;
  bool? applied;
  int? fertigationControlId01;
  int? fertigationControlId02;
  int? irrigationControlId;

  factory CreateGrowSheet.fromJson(Map<String, dynamic> json) => CreateGrowSheet(
    strain: json["strainX"] ?? "",
    description: json["description"] ?? "",
    seedBank: json["seedBank"] ?? "",
    tag: json["tag"] ?? "",
    dayTargetTemperature: json["dayTargetTemperature"].toDouble(),
    dayTemperatureDeadband: json["dayTemperatureDeadband"].toDouble(),
    dayTargetRelativeHumidity: json["dayTargetRelativeHumidity"].toDouble(),
    dayHumidityDeadband: json["dayHumidityDeadband"].toDouble(),
    dayTargetCo2: json["dayTargetCO2"].toDouble(),
    dayCo2Deadband: json["dayCO2Deadband"].toDouble(),
    dayLightTimeOn: json["dayLightTimeOn"] ?? "",
    dayLightTimeOff: json["dayLightTimeOff"] ?? "",
    nightTargetTemperature: json["nightTargetTemperature"].toDouble(),
    nightTemperatureDeadband: json["nightTemperatureDeadband"].toDouble(),
    nightTargetRelativeHumidity: json["nightTargetRelativeHumidity"].toDouble(),
    nightHumidityDeadband: json["nightHumidityDeadband"].toDouble(),
    nightTargetCo2: json["nightTargetCO2"].toDouble(),
    nightCo2Deadband: json["nightCO2Deadband"].toDouble(),
    nightLightTimeOn: json["nightLightTimeOn"] ?? "",
    nightLightTimeOff: json["nightLightTimeOff"] ?? "",
    applied: json["applied"] ?? false,
    fertigationControlId01: json["fertigationControlId01"] ?? 0,
    fertigationControlId02: json["fertigationControlId02"] ?? 0,
    irrigationControlId: json["irrigationControlId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "strain": strain,
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
    "fertigationControlId01": fertigationControlId01,
    "fertigationControlId02": fertigationControlId02,
    "irrigationControlId": irrigationControlId,
  };
}