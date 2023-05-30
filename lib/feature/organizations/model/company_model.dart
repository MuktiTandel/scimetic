import 'dart:convert';

CompanyResponseModel companyResponseModelFromJson(String str) => CompanyResponseModel.fromJson(json.decode(str));

String companyResponseModelToJson(CompanyResponseModel data) => json.encode(data.toJson());

class CompanyResponseModel {

  CompanyResponseModel({
    this.message,
    this.companies,
  });

  String? message;
  List<Company>? companies;

  factory CompanyResponseModel.fromJson(Map<String, dynamic> json) => CompanyResponseModel(
    message: json["message"] ?? "",
    companies: List<Company>.from(json["companies"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "companies": List<dynamic>.from(companies!.map((x) => x.toJson())),
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
    this.growspaces,
    this.controllers,
    this.sensors,
    this.admins,
    this.technicians,
  });

  int? id;
  String? name;
  String? address;
  dynamic logo;
  String? registrationNumber;
  String? licenseNumber;
  dynamic mobileNumber;
  String? email;
  String? website;
  Controllers? growspaces;
  Controllers? controllers;
  Controllers? sensors;
  int? admins;
  int? technicians;

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
    growspaces: Controllers.fromJson(json["growspaces"]),
    controllers: Controllers.fromJson(json["controllers"]),
    sensors: Controllers.fromJson(json["sensors"]),
    admins: json["admins"] ?? 0,
    technicians: json["technicians"] ?? 0,
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
    "growspaces": growspaces!.toJson(),
    "controllers": controllers!.toJson(),
    "sensors": sensors!.toJson(),
    "admins": admins,
    "technicians": technicians,
  };
}

class Controllers {
  Controllers({
    this.total,
    this.offline,
    this.online,
  });

  int? total;
  int? offline;
  int? online;

  factory Controllers.fromJson(Map<String, dynamic> json) => Controllers(
    total: json["total"] ?? 0,
    offline: json["offline"] ?? 0,
    online: json["online"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "offline": offline,
    "online": online,
  };
}