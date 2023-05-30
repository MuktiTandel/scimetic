import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.message,
    this.events,
  });

  String? message;
  List<Event>? events;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    message: json["message"] ?? "",
    events: json["events"] != null
        ? List<Event>.from(json["events"].map((x) => Event.fromJson(x)))
        : []
    ,
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "events": List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class Event {
  Event({
    this.id,
    this.dueDate,
    this.tag,
    this.completedAt,
    this.description,
    this.stage,
    this.createdAt,
    this.updatedAt,
    this.assignedTo,
    this.createdBy,
    this.companyId,
    this.growspaceId,
  });

  int? id;
  String? dueDate;
  String? tag;
  String? completedAt;
  String? description;
  String? stage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? assignedTo;
  int? createdBy;
  int? companyId;
  int? growspaceId;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"] ?? 0,
    dueDate: json["dueDate"] ?? "",
    tag: json["tag"] ?? "",
    completedAt: json["completedAt"] ?? "",
    description: json["description"] ?? "",
    stage: json["stage"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    assignedTo: json["assignedTo"] ?? 0,
    createdBy: json["createdBy"] ?? 0,
    companyId: json["companyId"] ?? 0,
    growspaceId: json["growspaceId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dueDate": dueDate,
    "tag": tag,
    "completedAt": completedAt,
    "description": description,
    "stage": stage,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "assignedTo": assignedTo,
    "createdBy": createdBy,
    "companyId": companyId,
    "growspaceId": growspaceId,
  };
}