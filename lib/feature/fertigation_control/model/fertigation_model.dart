import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

FertigationModel fertigationModelFromJson(String str) => FertigationModel.fromJson(json.decode(str));

String fertigationModelToJson(FertigationModel data) => json.encode(data.toJson());

class FertigationModel {
  FertigationModel({
    this.message,
    this.fertigationControls,
  });

  String? message;
  List<FertigationControl>? fertigationControls;

  factory FertigationModel.fromJson(Map<String, dynamic> json) => FertigationModel(
        message: json["message"] ?? "",
        fertigationControls: json["fertigationControls"] != null
            ? List<FertigationControl>.from(json["fertigationControls"]
                .map((x) => FertigationControl.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "fertigationControls":
            List<dynamic>.from(fertigationControls!.map((x) => x.toJson())),
      };
}

class FertigationControl {
  FertigationControl({
    this.id,
    this.name,
    this.description,
    this.tag,
    this.applied,
    this.favorite,
    this.createdAt,
    this.updatedAt,
    this.growControllerId,
    this.growController,
    this.formulas,
  });

  int? id;
  String? name;
  String? description;
  String? tag;
  bool? applied;
  bool? favorite;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? growControllerId;
  GrowController? growController;
  List<Formula>? formulas;

  factory FertigationControl.fromJson(Map<String, dynamic> json) =>
      FertigationControl(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
        tag: json["tag"] ?? "",
        applied: json["applied"] ?? false,
        favorite: json["favorite"] ?? false,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        growControllerId: json["growControllerId"] ?? 0,
        growController: json["growController"] != null
            ? GrowController.fromJson(json["growController"])
            : GrowController(),
        formulas: json["formulas"] != null
            ? List<Formula>.from(
                json["formulas"].map((x) => Formula.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "tag": tag,
        "applied": applied,
        "favorite": favorite,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "growControllerId": growControllerId,
        "growController": growController!.toJson(),
        "formulas": List<dynamic>.from(formulas!.map((x) => x.toJson())),
      };
}

class Formula {
  Formula({
    this.id,
    this.dayIngredient,
    this.dayQuantity,
    this.nightIngredient,
    this.nightQuantity,
    this.createdAt,
    this.updatedAt,
    this.fertigationFormula,
  });

  int? id;
  String? dayIngredient;
  String? dayQuantity;
  String? nightIngredient;
  String? nightQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  FertigationFormula? fertigationFormula;

  factory Formula.fromJson(Map<String, dynamic> json) => Formula(
        id: json["id"] ?? 0,
        dayIngredient: json["dayIngredient"] ?? "",
        dayQuantity: json["dayQuantity"] ?? "",
        nightIngredient: json["nightIngredient"] ?? "",
        nightQuantity: json["nightQuantity"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        fertigationFormula: json["fertigation_formula"] != null
            ? FertigationFormula.fromJson(json["fertigation_formula"])
            : FertigationFormula(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dayIngredient": dayIngredient,
        "dayQuantity": dayQuantity,
        "nightIngredient": nightIngredient,
        "nightQuantity": nightQuantity,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "fertigation_formula": fertigationFormula!.toJson(),
      };
}

class FertigationFormula {
  FertigationFormula({
    this.createdAt,
    this.updatedAt,
    this.fertigationControlId,
    this.formulaId,
  });

  DateTime? createdAt;
  DateTime? updatedAt;
  int? fertigationControlId;
  int? formulaId;

  factory FertigationFormula.fromJson(Map<String, dynamic> json) =>
      FertigationFormula(
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        fertigationControlId: json["fertigationControlId"] ?? 0,
        formulaId: json["formulaId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "fertigationControlId": fertigationControlId,
        "formulaId": formulaId,
      };
}
