import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

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
    "user": user!.toJson(),
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
  dynamic verificationCode;
  dynamic mobile;
  dynamic recoveryEmail;
  dynamic image;
  dynamic createdAt;
  dynamic updatedAt;
  int? companyId;
  int? roleId;
  Company? company;
  Role? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    auth0Id: json["auth0Id"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    inDarkMode: json["inDarkMode"] ?? false,
    emailVerified: json["emailVerified"] ?? false,
    verificationCode: json["verificationCode"] ?? "",
    mobile: json["mobile"] ?? "",
    recoveryEmail: json["recoveryEmail"] ?? "",
    image: json["image"] ?? "",
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
    companyId: json["companyId"] ?? 0,
    roleId: json["roleId"] ?? 0,
    company: Company.fromJson(json["company"]),
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "companyId": companyId,
    "roleId": roleId,
    "company": company!.toJson(),
    "role": role!.toJson(),
  };
}

class Company {
  Company({
    this.id,
    this.name,
    this.address,
    this.logo,
    this.registrationNumber,
    this.licenseNumber,
    this.mobileNumber,
    this.email,
    this.website,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  dynamic address;
  dynamic logo;
  dynamic registrationNumber;
  dynamic licenseNumber;
  dynamic mobileNumber;
  dynamic email;
  dynamic website;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    address: json["address"] ?? "",
    logo: json["logo"] ?? "",
    registrationNumber: json["registrationNumber"] ?? "",
    licenseNumber: json["licenseNumber"] ?? "",
    mobileNumber: json["mobileNumber"] ?? "",
    email: json["email"] ?? "",
    website: json["website"] ?? "",
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "logo": logo,
    "registrationNumber": registrationNumber,
    "licenseNumber": licenseNumber,
    "mobileNumber": mobileNumber,
    "email": email,
    "website": website,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
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