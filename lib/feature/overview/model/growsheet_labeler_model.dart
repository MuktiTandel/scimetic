import 'dart:convert';

GrowSheetLabelerModel growSheetLabelerFromJson(String str) => GrowSheetLabelerModel.fromJson(json.decode(str));

String growSheetLabelerToJson(GrowSheetLabelerModel data) => json.encode(data.toJson());

class GrowSheetLabelerModel {
  GrowSheetLabelerModel({
    this.message,
    this.growsheetLabeler,
  });

  String? message;
  GrowsheetLabeler? growsheetLabeler;

  factory GrowSheetLabelerModel.fromJson(Map<String, dynamic> json) => GrowSheetLabelerModel(
    message: json["message"] ?? "",
    growsheetLabeler: GrowsheetLabeler.fromJson(json["growsheetLabeler"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "growsheetLabeler": growsheetLabeler!.toJson(),
  };
}

class GrowsheetLabeler {
  GrowsheetLabeler({
    this.id,
    this.typeOfPlant,
    this.genealogy,
    this.stage,
    this.plantedDate,
    this.harvestDate,
    this.barcode,
    this.createdAt,
    this.updatedAt,
    this.growsheetId,
  });

  int? id;
  String? typeOfPlant;
  String? genealogy;
  String? stage;
  String? plantedDate;
  String? harvestDate;
  int? barcode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growsheetId;

  factory GrowsheetLabeler.fromJson(Map<String, dynamic> json) => GrowsheetLabeler(
    id: json["id"] ?? 0,
    typeOfPlant: json["typeOfPlant"] ?? "",
    genealogy: json["genealogy"] ?? "",
    stage: json["stage"] ?? "",
    plantedDate: json["plantedDate"] ?? "",
    harvestDate: json["harvestDate"] ?? "",
    barcode: json["barcode"] ?? 0,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    growsheetId: json["growsheetId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeOfPlant": typeOfPlant,
    "genealogy": genealogy,
    "stage": stage,
    "plantedDate": plantedDate,
    "harvestDate": harvestDate,
    "barcode": barcode,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "growsheetId": growsheetId,
  };
}