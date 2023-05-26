import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

OptionModel optionModelFromJson(String str) => OptionModel.fromJson(json.decode(str));

String optionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel {
  OptionModel({
    this.message,
    this.irrigationControls,
    this.fertigationControls,
  });

  String? message;
  List<IgationControl>? irrigationControls;
  List<IgationControl>? fertigationControls;

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
    message: json["message"] ?? "",
    irrigationControls: json["irrigationControls"] != null
        ? List<IgationControl>.from(json["irrigationControls"].map((x) => IgationControl.fromJson(x)))
        : [],
    fertigationControls: json["fertigationControls"] != null
        ? List<IgationControl>.from(json["fertigationControls"].map((x) => IgationControl.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "irrigationControls": List<dynamic>.from(irrigationControls!.map((x) => x.toJson())),
    "fertigationControls": List<dynamic>.from(fertigationControls!.map((x) => x.toJson())),
  };
}

class IgationControl {
  IgationControl({
    this.id,
    this.name,
    this.description,
    this.growController,
  });

  int? id;
  String? name;
  String? description;
  GrowController? growController;

  factory IgationControl.fromJson(Map<String, dynamic> json) => IgationControl(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    growController: json["growController"] != null
        ? GrowController.fromJson(json["growController"]) : GrowController(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "growController": growController!.toJson(),
  };
}