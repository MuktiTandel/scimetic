import 'dart:convert';

ReportData reportDataFromJson(String str) => ReportData.fromJson(json.decode(str));

String reportDataToJson(ReportData data) => json.encode(data.toJson());

class ReportData {
  ReportData({
    this.climateData,
    this.length,
  });

  List? climateData;
  int? length;

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
    climateData: json["climateData"] ?? [],
    length: json["length"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x.toJson())),
    "length": length,
  };
}

class VpdData {
  VpdData({
    this.vpd,
    this.date,
  });

  int? vpd;
  String? date;

  factory VpdData.fromJson(Map<String, dynamic> json) => VpdData(
    vpd: json["vpd"] ?? 0,
    date: json["date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "vpd": vpd,
    "date": date,
  };
}

class HumidityData {
  HumidityData({
    this.humidity,
    this.date,
  });

  double? humidity;
  String? date;

  factory HumidityData.fromJson(Map<String, dynamic> json) => HumidityData(
    humidity: json["humidity"] != null ? json["humidity"].toDouble() : 0.0,
    date: json["date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "date": date,
  };
}

class TemperatureData {
  TemperatureData({
    this.temperature,
    this.date,
  });

  double? temperature;
  String? date;

  factory TemperatureData.fromJson(Map<String, dynamic> json) => TemperatureData(
    temperature: json["temperature"] != null ? json["temperature"].toDouble() : 0.0,
    date: json["date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "date": date,
  };
}

class Co2Data {
  Co2Data({
    this.co2,
    this.date,
  });

  double? co2;
  String? date;

  factory Co2Data.fromJson(Map<String, dynamic> json) => Co2Data(
    co2: json["co2"] != null ? json["co2"].toDouble() : 0.0,
    date: json["date"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "co2": co2,
    "date": date,
  };
}