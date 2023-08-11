import 'dart:convert';

import 'package:scimetic/feature/device_settings/Model/device_model.dart';

SwitchModel switchModelFromJson(String str) => SwitchModel.fromJson(json.decode(str));

String switchModelToJson(SwitchModel data) => json.encode(data.toJson());

class SwitchModel {
  SwitchModel({
    this.message,
    this.devices,
  });

  String? message;
  List<Device>? devices;

  factory SwitchModel.fromJson(Map<String, dynamic> json) => SwitchModel(
    message: json["message"] ?? "",
    devices: json["devices"] != null ? List<Device>.from(json["devices"].map((x) => Device.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "devices": List<dynamic>.from(devices!.map((x) => x.toJson())),
  };
}

class Device {
  Device({
    this.id,
    this.serialNumber,
    this.location,
    this.description,
    this.data,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.deviceTypeId,
    this.createdBy,
    this.growControllerId,
  });

  int? id;
  String? serialNumber;
  String? location;
  String? description;
  Data? data;
  String? status;
  dynamic createdAt;
  DateTime? updatedAt;
  int? companyId;
  int? deviceTypeId;
  int? createdBy;
  int? growControllerId;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    id: json["id"] ?? 0,
    serialNumber: json["serialNumber"] ?? "",
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    data: json["data"] != null ? Data.fromJson(json["data"]) : Data(),
    status: json["status"] ?? "",
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    companyId: json["companyId"] ?? 0,
    deviceTypeId: json["deviceTypeId"] ?? 0,
    createdBy: json["createdBy"] ?? 0,
    growControllerId: json["growControllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialNumber": serialNumber,
    "location": location,
    "description": description,
    "data": data!.toJson(),
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt!.toIso8601String(),
    "companyId": companyId,
    "deviceTypeId": deviceTypeId,
    "createdBy": createdBy,
    "growControllerId": growControllerId,
  };
}

class Data {
  Data({
    this.info1,
    this.info2,
    this.info3,
  });

  Info1? info1;
  Info2? info2;
  Info3? info3;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    info1: json["Info1"] != null ? Info1.fromJson(json["Info1"]) : Info1(),
    info2: json["Info2"] != null ? Info2.fromJson(json["Info2"]) : Info2(),
    info3: json["Info3"] != null ? Info3.fromJson(json["Info3"]) : Info3(),
  );

  Map<String, dynamic> toJson() => {
    "Info1": info1!.toJson(),
    "Info2": info2!.toJson(),
    "Info3": info3!.toJson(),
  };
}