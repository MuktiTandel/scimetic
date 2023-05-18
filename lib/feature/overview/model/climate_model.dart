import 'dart:convert';

import 'package:scimetic/feature/dashboard/model/GrowController_model.dart';

ClimateModel climateModelFromJson(String str) => ClimateModel.fromJson(json.decode(str));

String climateModelToJson(ClimateModel data) => json.encode(data.toJson());

class ClimateModel {
  ClimateModel({
    this.climateData,
    this.growspace,
    this.length,
  });

  List<dynamic>? climateData;
  GrowController? growspace;
  int? length;

  factory ClimateModel.fromJson(Map<String, dynamic> json) => ClimateModel(
    climateData: List<dynamic>.from(json["climateData"].map((x) => x)),
    growspace: GrowController.fromJson(json["growspace"]),
    length: json["length"],
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x)),
    "growspace": GrowController().toJson(),
    "length": length,
  };
}