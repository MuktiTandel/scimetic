// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

MessageDataModel messageDataModelFromJson(String str) => MessageDataModel.fromJson(json.decode(str));

String messageDataModelToJson(MessageDataModel data) => json.encode(data.toJson());

class MessageDataModel {
    final String? message;
    final bool? success;
    final List<NotificationDatum>? notificationData;

    MessageDataModel({
        this.message,
        this.success,
        this.notificationData,
    });

    factory MessageDataModel.fromJson(Map<String, dynamic> json) => MessageDataModel(
        message: json["message"],
        success: json["success"],
        notificationData: json["notificationData"] == null ? [] : List<NotificationDatum>.from(json["notificationData"]!.map((x) => NotificationDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "notificationData": notificationData == null ? [] : List<dynamic>.from(notificationData!.map((x) => x.toJson())),
    };
}

class NotificationDatum {
    final String? group;
    final String? type;
    final String? message;
    final String? initiator;

    NotificationDatum({
        this.group,
        this.type,
        this.message,
        this.initiator,
    });

    factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
        group: json["group"],
        type: json["type"],
        message: json["message"],
        initiator: json["initiator"],
    );

    Map<String, dynamic> toJson() => {
        "group": group,
        "type": type,
        "message": message,
        "initiator": initiator,
    };
}
