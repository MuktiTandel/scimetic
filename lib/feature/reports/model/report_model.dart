import 'dart:convert';

ReportTemperatureData reportDataFromJson(String str) => ReportTemperatureData.fromJson(json.decode(str));

String reportDataToJson(ReportTemperatureData data) => json.encode(data.toJson());

class ReportTemperatureData {
  ReportTemperatureData({
    this.climateData,
    this.length,
  });

  List<TemperatureData>? climateData;
  int? length;

  factory ReportTemperatureData.fromJson(Map<String, dynamic> json) => ReportTemperatureData(
    climateData: json["climateData"] != null ? List<TemperatureData>.from(json["climateData"].map((x) => TemperatureData.fromJson(x))) : [],
    length: json["length"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x.toJson())),
    "length": length,
  };
}

class ReportCo2Data {

  ReportCo2Data({
    this.climateData,
    this.length,
  });

  List<Co2Data>? climateData;
  int? length;

  factory ReportCo2Data.fromJson(Map<String, dynamic> json) => ReportCo2Data(
    climateData: json["climateData"] != null ? List<Co2Data>.from(json["climateData"].map((x) => Co2Data.fromJson(x))) : [],
    length: json["length"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x.toJson())),
    "length": length,
  };

}

class ReportHumidityData {

  ReportHumidityData({
    this.climateData,
    this.length,
  });

  List<HumidityData>? climateData;
  int? length;

  factory ReportHumidityData.fromJson(Map<String, dynamic> json) => ReportHumidityData(
    climateData: json["climateData"] != null ? List<HumidityData>.from(json["climateData"].map((x) => HumidityData.fromJson(x))) : [],
    length: json["length"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "climateData": List<dynamic>.from(climateData!.map((x) => x.toJson())),
    "length": length,
  };

}

class ReportVpdData {

  ReportVpdData({
    this.climateData,
    this.length,
  });

  List<VpdData>? climateData;
  int? length;

  factory ReportVpdData.fromJson(Map<String, dynamic> json) => ReportVpdData(
    climateData: json["climateData"] != null ? List<VpdData>.from(json["climateData"].map((x) => VpdData.fromJson(x))) : [],
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

  double? vpd;
  String? date;

  factory VpdData.fromJson(Map<String, dynamic> json) => VpdData(
    vpd: json["vpd"] != null ? json["vpd"].toDouble() : 0.0,
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