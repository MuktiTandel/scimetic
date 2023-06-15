import 'dart:convert';

FertigationControlModel fertigationControlModelFromJson(String str) => FertigationControlModel.fromJson(json.decode(str));

String fertigationControlModelToJson(FertigationControlModel data) => json.encode(data.toJson());

class FertigationControlModel {
  FertigationControlModel({
    this.tag,
    this.description,
    this.name,
    this.formulas,
  });

  String? tag;
  String? description;
  String? name;
  List<Formula>? formulas;

  factory FertigationControlModel.fromJson(Map<String, dynamic> json) => FertigationControlModel(
    tag: json["tag"] ?? "",
    description: json["description"] ?? "",
    name: json["name"] ?? "",
    formulas: json["formulas"] != null
        ? List<Formula>.from(json["formulas"].map((x) => Formula.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "tag": tag,
    "description": description,
    "name": name,
    "formulas": List<dynamic>.from(formulas!.map((x) => x.toJson())),
  };
}

class Formula {
  Formula({
    this.dayIngredient,
    this.dayQuantity,
    this.nightIngredient,
    this.nightQuantity,
  });

  String? dayIngredient;
  int? dayQuantity;
  String? nightIngredient;
  String? nightQuantity;

  factory Formula.fromJson(Map<String, dynamic> json) => Formula(
    dayIngredient: json["dayIngredient"] ?? "",
    dayQuantity: json["dayQuantity"] ?? 0,
    nightIngredient: json["nightIngredient"] ?? "",
    nightQuantity: json["nightQuantity"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "dayIngredient": dayIngredient,
    "dayQuantity": dayQuantity,
    "nightIngredient": nightIngredient,
    "nightQuantity": nightQuantity,
  };
}
