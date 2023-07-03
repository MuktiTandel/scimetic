import 'dart:convert';

ScreenModel screenModelFromJson(String str) => ScreenModel.fromJson(json.decode(str));

String screenModelToJson(ScreenModel data) => json.encode(data.toJson());

class ScreenModel {
  ScreenModel({
    this.message,
    this.screen,
  });

  String? message;
  List<Screen>? screen;

  factory ScreenModel.fromJson(Map<String, dynamic> json) => ScreenModel(
    message: json["message"] ?? "",
    screen: json["screen"] != null ? List<Screen>.from(
        json["screen"].map((x) => Screen.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "screen": List<dynamic>.from(screen!.map((x) => x.toJson())),
  };
}

class Screen {
  Screen({
    this.id,
    this.timeOn,
    this.timeOff,
    this.screenOpen,
    this.screenClose,
    this.switchSelection,
    this.relaySelection,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.growControllerId,
  });

  int? id;
  dynamic timeOn;
  dynamic timeOff;
  dynamic screenOpen;
  dynamic screenClose;
  String? switchSelection;
  String? relaySelection;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? growControllerId;

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
    id: json["id"] ?? 0,
    timeOn: json["timeOn"] ?? "",
    timeOff: json["timeOff"] ?? "",
    screenOpen: json["screenOpen"] ?? "",
    screenClose: json["screenClose"] ?? "",
    switchSelection: json["switchSelection"] ?? "",
    relaySelection: json["relaySelection"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    userId: json["userId"] ?? 0,
    growControllerId: json["grow_controllerId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "timeOn": timeOn,
    "timeOff": timeOff,
    "screenOpen": screenOpen,
    "screenClose": screenClose,
    "switchSelection": switchSelection,
    "relaySelection": relaySelection,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "userId": userId,
    "grow_controllerId": growControllerId,
  };
}