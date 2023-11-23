// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    final String? message;
    final String? url;

    UserProfileModel({
        this.message,
        this.url,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        message: json["message"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "url": url,
    };
}
