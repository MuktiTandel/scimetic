import 'dart:convert';

GrowModel welcome1FromJson(String str) => GrowModel.fromJson(json.decode(str));

String welcome1ToJson(GrowModel data) => json.encode(data.toJson());

class GrowModel {
  GrowModel({
    this.message,
    this.growControllers,
  });

  String? message;
  List<GrowController>? growControllers;

  factory GrowModel.fromJson(Map<String, dynamic> json) => GrowModel(
    message: json["message"] ?? "",
    growControllers: List<GrowController>.
    from(json["growControllers"].map((x) => GrowController.fromJson(x))) ,
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "growControllers": List<dynamic>.from(growControllers!.map((x) => x.toJson())),
  };
}

class GrowController {
  GrowController({
    this.id,
    this.name,
    this.identifier,
    this.description,
    this.longitude,
    this.latitude,
    this.dayStart,
    this.nightStart,
    this.temperatureControlAuto,
    this.humidityControlAuto,
    this.co2ControlAuto,
    this.lightingControlAuto,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.creator,
  });

  int? id;
  String? name;
  String? identifier;
  String? description;
  double? longitude;
  double? latitude;
  String? dayStart;
  String? nightStart;
  bool? temperatureControlAuto;
  bool? humidityControlAuto;
  bool? co2ControlAuto;
  bool? lightingControlAuto;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic companyId;
  int? creator;

  factory GrowController.fromJson(Map<String, dynamic> json) => GrowController(
    id: json["id"],
    name: json["name"],
    identifier: json["identifier"],
    description: json["description"] == null ? null : json["description"],
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
    dayStart: json["dayStart"],
    nightStart: json["nightStart"],
    temperatureControlAuto: json["temperatureControlAuto"],
    humidityControlAuto: json["humidityControlAuto"],
    co2ControlAuto: json["co2ControlAuto"],
    lightingControlAuto: json["lightingControlAuto"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    companyId: json["companyId"],
    creator: json["creator"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "identifier": identifier,
    "description": description == null ? null : description,
    "longitude": longitude,
    "latitude": latitude,
    "dayStart": dayStart,
    "nightStart": nightStart,
    "temperatureControlAuto": temperatureControlAuto,
    "humidityControlAuto": humidityControlAuto,
    "co2ControlAuto": co2ControlAuto,
    "lightingControlAuto": lightingControlAuto,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "companyId": companyId,
    "creator": creator,
  };
}