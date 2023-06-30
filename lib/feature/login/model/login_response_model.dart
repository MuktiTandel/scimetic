import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.accessToken,
    this.user,
  });

  String? message;
  String? accessToken;
  User? user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    message: json["message"] ?? "",
    accessToken: json["accessToken"] ?? "",
    user: json["user"] != null ? User.fromJson(json["user"]) : User(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "accessToken": accessToken,
    "user": user!.toJson(),
  };
}

class User {
  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.inDarkMode,
    this.emailVerified,
    this.verificationCode,
    this.mobile,
    this.recoveryEmail,
    this.image,
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
  bool? inDarkMode;
  bool? emailVerified;
  int? verificationCode;
  dynamic mobile;
  dynamic recoveryEmail;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic companyId;
  int? roleId;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    email: json["email"] ?? "",
    password: json["password"] ?? "",
    name: json["name"] ?? "",
    inDarkMode: json["inDarkMode"] ?? false,
    emailVerified: json["emailVerified"] ?? false,
    verificationCode: json["verificationCode"] ?? 0,
    mobile: json["mobile"] ?? "",
    recoveryEmail: json["recoveryEmail"] ?? "",
    image: json["image"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    companyId: json["companyId"] ?? "",
    roleId: json["roleId"] ?? 0,
    role: json["role"] != null ? Role.fromJson(json["role"]) : Role(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "inDarkMode": inDarkMode,
    "emailVerified": emailVerified,
    "verificationCode": verificationCode,
    "mobile": mobile,
    "recoveryEmail": recoveryEmail,
    "image": image,
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