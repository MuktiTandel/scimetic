// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String? message;
    final String? accessToken;
    final User? user;
    final String? url;

    LoginResponseModel({
        this.message,
        this.accessToken,
        this.user,
        this.url,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json["message"],
        accessToken: json["accessToken"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "user": user?.toJson(),
        "url": url,
    };
}

class User {
    final int? id;
    final String? email;
    final String? name;
    final bool? inDarkMode;
    final bool? emailVerified;
    final int? verificationCode;
    final dynamic mobile;
    final dynamic recoveryEmail;
    final String? image;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? companyId;
    final int? roleId;
    final Role? role;

    User({
        this.id,
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
        this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        inDarkMode: json["inDarkMode"],
        emailVerified: json["emailVerified"],
        verificationCode: json["verificationCode"],
        mobile: json["mobile"],
        recoveryEmail: json["recoveryEmail"],
        image: json["image"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        companyId: json["companyId"],
        roleId: json["roleId"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
        "role": role?.toJson(),
    };
}

class Role {
    final int? id;
    final String? code;
    final String? name;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Role({
        this.id,
        this.code,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
