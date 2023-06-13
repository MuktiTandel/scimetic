import 'dart:convert';

NotificationSettingModel notificationSettingModelFromJson(String str) => NotificationSettingModel.fromJson(json.decode(str));

String notificationSettingModelToJson(NotificationSettingModel data) => json.encode(data.toJson());

class NotificationSettingModel {
  NotificationSettingModel({
    this.message,
    this.notificationSettings,
  });

  String? message;
  NotificationSettings? notificationSettings;

  factory NotificationSettingModel.fromJson(Map<String, dynamic> json) => NotificationSettingModel(
    message: json["message"] ?? "",
    notificationSettings: json["notificationSettings"] != null
        ? NotificationSettings.fromJson(json["notificationSettings"])
        : NotificationSettings(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "notificationSettings": notificationSettings!.toJson(),
  };
}

class NotificationSettings {
  NotificationSettings({
    this.id,
    this.newGroupMessage,
    this.newDirectMessage,
    this.todoEvent,
    this.calendarEvent,
    this.growspaceStatus,
    this.deviceStatus,
    this.growsheetChanges,
    this.email,
    this.sms,
    this.push,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  bool? newGroupMessage;
  bool? newDirectMessage;
  bool? todoEvent;
  bool? calendarEvent;
  bool? growspaceStatus;
  bool? deviceStatus;
  bool? growsheetChanges;
  bool? email;
  bool? sms;
  bool? push;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => NotificationSettings(
    id: json["id"] ?? 0,
    newGroupMessage: json["newGroupMessage"] ?? false,
    newDirectMessage: json["newDirectMessage"] ?? false,
    todoEvent: json["todoEvent"] ?? false,
    calendarEvent: json["calendarEvent"] ?? false,
    growspaceStatus: json["growspaceStatus"] ?? false,
    deviceStatus: json["deviceStatus"] ?? false,
    growsheetChanges: json["growsheetChanges"] ?? false,
    email: json["email"] ?? false,
    sms: json["sms"] ?? false,
    push: json["push"] ?? false,
    userId: json["userId"] ?? 0,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "newGroupMessage": newGroupMessage,
    "newDirectMessage": newDirectMessage,
    "todoEvent": todoEvent,
    "calendarEvent": calendarEvent,
    "growspaceStatus": growspaceStatus,
    "deviceStatus": deviceStatus,
    "growsheetChanges": growsheetChanges,
    "email": email,
    "sms": sms,
    "push": push,
    "userId": userId,
    "updatedAt": updatedAt!.toIso8601String(),
    "createdAt": createdAt!.toIso8601String(),
  };
}
