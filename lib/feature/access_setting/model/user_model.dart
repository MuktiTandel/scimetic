import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.users,
  });

  String? message;
  List<User>? users;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"] ?? "",
    users: json["users"] != null ? List<User>.from(json["users"].map((x) => User.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "users": List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.emailVerified,
    this.image,
    this.resetPasswordToken,
    this.resetPasswordExpired,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.roleId,
    this.role,
  });

  int? id;
  String? email;
  String? password;
  String? name;
  bool? emailVerified;
  String? image;
  String? resetPasswordToken;
  String? resetPasswordExpired;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? companyId;
  int? roleId;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    name: json["name"] ?? "",
    emailVerified: json["emailVerified"] ?? false,
    image: json["image"] ?? "",
    resetPasswordToken: json["resetPasswordToken"] ?? "",
    resetPasswordExpired: json["resetPasswordExpired"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    companyId: json["companyId"] ?? 0,
    roleId: json["roleId"] ?? 0 ,
    role: json["role"] != null ? Role.fromJson(json["role"]) : Role(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "emailVerified": emailVerified,
    "image": image,
    "resetPasswordToken": resetPasswordToken,
    "resetPasswordExpired": resetPasswordExpired,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
    "companyId": companyId,
    "roleId": roleId,
    "role": role!.toJson(),
  };
}

class Role {
  Role({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? code;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"] ?? 0,
    code: json["code"] ?? "",
    name: json["name"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}