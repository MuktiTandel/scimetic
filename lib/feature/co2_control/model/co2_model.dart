import 'dart:convert';

Co2Model co2ModelFromJson(String str) => Co2Model.fromJson(json.decode(str));

String co2ModelToJson(Co2Model data) => json.encode(data.toJson());

class Co2Model {
  Co2Model({
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
  });

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

  factory Co2Model.fromJson(Map<String, dynamic> json) => Co2Model(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}