import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    this.message,
    this.todos,
  });

  String? message;
  Todos? todos;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    message: json["message"] ?? "",
    todos: json["todos"] != null ? Todos.fromJson(json["todos"]) : Todos(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "todos": todos!.toJson(),
  };
}

class Todos {
  Todos({
    this.toDo,
    this.inProgress,
    this.completed,
  });

  List<Todo>? toDo;
  List<Todo>? inProgress;
  List<Todo>? completed;

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
    toDo: json["toDo"] != null ? List<Todo>.from(json["toDo"].map((x) => Todo.fromJson(x))) : [],
    inProgress: json["inProgress"] != null ? List<Todo>.from(json["inProgress"].map((x) => Todo.fromJson(x))) : [],
    completed: json["completed"] != null ? List<Todo>.from(json["completed"].map((x) => Todo.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "toDo": List<dynamic>.from(toDo!.map((x) => x.toJson())),
    "inProgress": List<dynamic>.from(inProgress!.map((x) => x.toJson())),
    "completed": List<dynamic>.from(completed!.map((x) => x.toJson())),
  };
}

class Todo {
  Todo({
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

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
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