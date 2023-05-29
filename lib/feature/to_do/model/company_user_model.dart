import 'dart:convert';

CompanyUserModel companyUserModelFromJson(String str) => CompanyUserModel.fromJson(json.decode(str));

String companyUserModelToJson(CompanyUserModel data) => json.encode(data.toJson());

class CompanyUserModel {
  CompanyUserModel({
    this.message,
    this.users,
  });

  String? message;
  List<User>? users;

  factory CompanyUserModel.fromJson(Map<String, dynamic> json) => CompanyUserModel(
    message: json["message"] ?? "",
    users: json["users"] != null
        ? List<User>.from(json["users"].map((x) => User.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.image,
    this.companyId,
    this.roleId,
  });

  int? id;
  String? name;
  dynamic image;
  int? companyId;
  int? roleId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    image: json["image"] ?? "",
    companyId: json["companyId"] ?? 0,
    roleId: json["roleId"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "companyId": companyId,
    "roleId": roleId,
  };
}
