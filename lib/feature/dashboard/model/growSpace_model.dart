import 'dart:convert';

GrowspaceModel welcome2FromJson(String str) => GrowspaceModel.fromJson(json.decode(str));

String welcome2ToJson(GrowspaceModel data) => json.encode(data.toJson());

class GrowspaceModel {
  GrowspaceModel({
    this.name,
    this.identifier,
    this.location,
    this.description,
    this.dayStart,
    this.nightStart,
  });

  String? name;
  String? identifier;
  String? location;
  String? description;
  String? dayStart;
  String? nightStart;

  factory GrowspaceModel.fromJson(Map<String, dynamic> json) => GrowspaceModel(
    name: json["name"] ?? "",
    identifier: json["identifier"] ?? "",
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    dayStart: json["dayStart"] ?? "",
    nightStart: json["nightStart"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "identifier": identifier,
    "location": location,
    "description": description,
    "dayStart": dayStart,
    "nightStart": nightStart,
  };
}