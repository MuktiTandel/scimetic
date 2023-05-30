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

GrowController growControllerFromJson(String str) => GrowController.fromJson(json.decode(str));

String growControllerToJson(GrowController data) => json.encode(data.toJson());

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
    this.climate,
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
  Climate? climate;

  factory GrowController.fromJson(Map<String, dynamic> json) => GrowController(
    id: json["id"],
    name: json["name"],
    identifier: json["identifier"],
    description: json["description"] ?? "",
    longitude: json["longitude"] == null ? 0.0 : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? 0.0 : json["latitude"].toDouble(),
    dayStart: json["dayStart"],
    nightStart: json["nightStart"],
    temperatureControlAuto: json["temperatureControlAuto"],
    humidityControlAuto: json["humidityControlAuto"],
    co2ControlAuto: json["co2ControlAuto"],
    lightingControlAuto: json["lightingControlAuto"],
    createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? DateTime.now() : DateTime.parse(json["updatedAt"]),
    companyId: json["companyId"],
    creator: json["creator"],
    climate: json["climate"] == null ? Climate(
      temperature: 0.0,
      vpd: 0.0,
      humidity: 0.0,
      mol: 0,
      co2: 0.0
    ) : Climate.fromJson(json["climate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "identifier": identifier,
    "description": description ?? "",
    "longitude": longitude ?? 0.0,
    "latitude": latitude ?? 0.0,
    "dayStart": dayStart,
    "nightStart": nightStart,
    "temperatureControlAuto": temperatureControlAuto,
    "humidityControlAuto": humidityControlAuto,
    "co2ControlAuto": co2ControlAuto,
    "lightingControlAuto": lightingControlAuto,
    "createdAt": createdAt == null ? DateTime.now().toIso8601String() : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? DateTime.now().toIso8601String() : updatedAt!.toIso8601String(),
    "companyId": companyId,
    "creator": creator,
    "climate": climate == null ? null : climate!.toJson(),
  };
}

class Climate {
  Climate({
    this.temperature,
    this.vpd,
    this.humidity,
    this.mol,
    this.co2,
  });

  double? temperature;
  double? vpd;
  double? humidity;
  int? mol;
  double? co2;

  factory Climate.fromJson(Map<String, dynamic> json) => Climate(
    temperature: json["temperature"] == null ? 0.0 : json["temperature"].toDouble(),
    vpd: json["vpd"] == null ? 0.0 : json["vpd"].toDouble(),
    humidity: json["humidity"] == null ? 0.0 : json["humidity"].toDouble(),
    mol: json["mol"] ?? 0,
    co2: json["co2"] == null ? 0.0 : json["co2"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "vpd": vpd,
    "humidity": humidity,
    "mol": mol,
    "co2": co2,
  };
}