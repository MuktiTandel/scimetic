import 'dart:convert';

LoginResponseModel welcome1FromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String welcome1ToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.message,
    this.accessToken,
    this.idToken,
    this.user,
  });

  String? message;
  String? accessToken;
  String? idToken;
  User? user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    message: json["message"] ?? "",
    accessToken: json["accessToken"] ?? "",
    idToken: json["idToken"] ?? "",
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "accessToken": accessToken,
    "idToken": idToken,
    "user": user?.toJson(),
  };
}

class User {
  User({
    this.id,
    this.auth0Id,
    this.email,
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
    this.company,
    this.role,
  });

  int? id;
  String? auth0Id;
  String? email;
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
  dynamic company;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    auth0Id: json["auth0Id"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    inDarkMode: json["inDarkMode"] ?? false,
    emailVerified: json["emailVerified"] ?? false,
    verificationCode: json["verificationCode"] ?? 0,
    mobile: json["mobile"] ?? "",
    recoveryEmail: json["recoveryEmail"] ?? "",
    image: json["image"] ?? "",
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    companyId: json["companyId"] ?? "",
    roleId: json["roleId"] ?? 0,
    company: json["company"] ?? "",
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "auth0Id": auth0Id,
    "email": email,
    "name": name,
    "inDarkMode": inDarkMode,
    "emailVerified": emailVerified,
    "verificationCode": verificationCode,
    "mobile": mobile,
    "recoveryEmail": recoveryEmail,
    "image": image,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "companyId": companyId,
    "roleId": roleId,
    "company": company,
    "role": role?.toJson(),
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
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}