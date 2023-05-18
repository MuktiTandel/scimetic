import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  DeviceModel({
    this.message,
    this.devices,
  });

  String? message;
  Devices? devices;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
    message: json["message"] ?? "",
    devices: Devices.fromJson(json["devices"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "devices": devices!.toJson(),
  };
}

class Devices {
  Devices({
    this.sensor,
    this.valve,
    this.devicesSwitch,
  });

  Sensor? sensor;
  Sensor? valve;
  Sensor? devicesSwitch;

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
    sensor: Sensor.fromJson(json["sensor"]),
    valve: Sensor.fromJson(json["valve"]),
    devicesSwitch: Sensor.fromJson(json["switch"]),
  );

  Map<String, dynamic> toJson() => {
    "sensor": sensor!.toJson(),
    "valve": valve!.toJson(),
    "switch": devicesSwitch!.toJson(),
  };
}

class Sensor {
  Sensor({
    this.devices,
    this.total,
    this.online,
    this.offline,
  });

  List<dynamic>? devices;
  int? total;
  int? online;
  int? offline;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
    devices: List<dynamic>.from(json["devices"].map((x) => x)),
    total: json["total"],
    online: json["online"],
    offline: json["offline"],
  );

  Map<String, dynamic> toJson() => {
    "devices": List<dynamic>.from(devices!.map((x) => x)),
    "total": total,
    "online": online,
    "offline": offline,
  };
}