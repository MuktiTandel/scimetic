import 'dart:convert';

HumidityModel humidityModelFromJson(String str) =>
    HumidityModel.fromJson(json.decode(str));

String humidityModelToJson(HumidityModel data) => json.encode(data.toJson());

class HumidityModel {
  HumidityModel({
    this.dayHumidityRh,
    this.dayHumidityRhDeadband,
    this.nightHumidityRh,
    this.nightHumidityRhDeadband,
    this.dayDehumidityRh,
    this.nightDehumidityRh,
    this.dayDehumidityRhDeadband,
    this.nightDehumidityRhDeadband,
    this.dayHumiditySwitch,
    this.nightHumiditySwitch,
    this.dayDehumiditySwitch,
    this.nightDehumiditySwitch,
    this.dayHumidityRelay,
    this.nightHumidityRelay,
    this.dayDehumidityRelay,
    this.nightDehumidityRelay,
  });

  double? dayHumidityRh;
  double? dayHumidityRhDeadband;
  double? nightHumidityRh;
  double? nightHumidityRhDeadband;
  double? dayDehumidityRh;
  double? nightDehumidityRh;
  double? dayDehumidityRhDeadband;
  double? nightDehumidityRhDeadband;
  String? dayHumiditySwitch;
  String? nightHumiditySwitch;
  String? dayDehumiditySwitch;
  String? nightDehumiditySwitch;
  String? dayHumidityRelay;
  String? nightHumidityRelay;
  String? dayDehumidityRelay;
  String? nightDehumidityRelay;

  factory HumidityModel.fromJson(Map<String, dynamic> json) => HumidityModel(
        dayHumidityRh: json["dayHumidityRH"] != null
            ? json["dayHumidityRH"].toDouble()
            : 0,
        dayHumidityRhDeadband: json["dayHumidityRhDeadband"] != null
            ? json["dayHumidityRhDeadband"].toDouble()
            : 0,
        nightHumidityRh: json["nightHumidityRh"] != null
            ? json["nightHumidityRh"].toDouble()
            : 0,
        nightHumidityRhDeadband: json["nightHumidityRhDeadband"] != null
            ? json["nightHumidityRhDeadband"].toDouble()
            : 0,
        dayDehumidityRh: json["dayDehumidityRh"] != null
            ? json["dayDehumidityRh"].toDouble()
            : 0,
        nightDehumidityRh: json["nightDehumidityRh"] != null
            ? json["nightDehumidityRh"].toDouble()
            : 0,
        dayDehumidityRhDeadband: json["dayDehumidityRhDeadband"] != null
            ? json["dayDehumidityRhDeadband"].toDouble()
            : 0,
        nightDehumidityRhDeadband: json["nightDehumidityRhDeadband"] != null
            ? json["nightDehumidityRhDeadband"].toDouble()
            : 0,
        dayHumiditySwitch: json["dayHumiditySwitch"] ?? "",
        nightHumiditySwitch: json["nightHumiditySwitch"] ?? "",
        dayDehumiditySwitch: json["dayDehumiditySwitch"] ?? "",
        nightDehumiditySwitch: json["nightDehumiditySwitch"] ?? "",
        dayHumidityRelay: json["dayHumidityRelay"] ?? "",
        nightHumidityRelay: json["nightHumidityRelay"] ?? "",
        dayDehumidityRelay: json["dayDehumidityRelay"] ?? "",
        nightDehumidityRelay: json["nightDehumidityRelay"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "dayHumidityRH": dayHumidityRh,
        "dayHumidityRHDeadband": dayHumidityRhDeadband,
        "nightHumidityRH": nightHumidityRh,
        "nightHumidityRHDeadband": nightHumidityRhDeadband,
        "dayDehumidityRH": dayDehumidityRh,
        "nightDehumidityRH": nightDehumidityRh,
        "dayDehumidityRHDeadband": dayDehumidityRhDeadband,
        "nightDehumidityRHDeadband": nightDehumidityRhDeadband,
        "dayHumiditySwitch": dayHumiditySwitch,
        "nightHumiditySwitch": nightHumiditySwitch,
        "dayDehumiditySwitch": dayDehumiditySwitch,
        "nightDehumiditySwitch": nightDehumiditySwitch,
        "dayHumidityRelay": dayHumidityRelay,
        "nightHumidityRelay": nightHumidityRelay,
        "dayDehumidityRelay": dayDehumidityRelay,
        "nightDehumidityRelay": nightDehumidityRelay,
      };
}
