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
    devices: json["devices"]  != null ? Devices.fromJson(json["devices"]) : Devices(),
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
  Switch? devicesSwitch;

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
    sensor: json["sensor"] != null ? Sensor.fromJson(json["sensor"]) : Sensor(),
    valve: json["valve"] != null ? Sensor.fromJson(json["valve"]) : Sensor(),
    devicesSwitch: json["switch"] != null ? Switch.fromJson(json["switch"]) : Switch(),
  );

  Map<String, dynamic> toJson() => {
    "sensor": sensor!.toJson(),
    "valve": valve!.toJson(),
    "switch": devicesSwitch!.toJson(),
  };
}

class Switch {
  Switch({
    this.devices,
    this.total,
    this.online,
    this.offline,
  });

  List<SwitchDevice>? devices;
  int? total;
  int? online;
  int? offline;

  factory Switch.fromJson(Map<String, dynamic> json) => Switch(
    devices: json["devices"] != null
        ? List<SwitchDevice>.from(json["devices"].map((x) => SwitchDevice.fromJson(x)))
        : null,
    total: json["total"] ?? 0,
    online: json["online"] ?? 0,
    offline: json["offline"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "devices": List<dynamic>.from(devices!.map((x) => x.toJson())),
    "total": total,
    "online": online,
    "offline": offline,
  };
}

class SwitchDevice {
  SwitchDevice({
    this.id,
    this.serialNumber,
    this.location,
    this.description,
    this.data,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.deviceTypeId,
    this.createdBy,
    this.growControllerId,
    this.deviceType,
  });

  int? id;
  String? serialNumber;
  String? location;
  dynamic description;
  FluffyData? data;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic companyId;
  int? deviceTypeId;
  dynamic createdBy;
  int? growControllerId;
  DeviceType? deviceType;

  factory SwitchDevice.fromJson(Map<String, dynamic> json) => SwitchDevice(
    id: json["id"] ?? 0,
    serialNumber: json["serialNumber"] ?? "",
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    data: json["data"] != null ? FluffyData.fromJson(json["data"]) : FluffyData(),
    status: json["status"] ?? "",
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
    companyId: json["companyId"] ?? "",
    deviceTypeId: json["deviceTypeId"] ?? 0,
    createdBy: json["createdBy"] ?? "",
    growControllerId: json["growControllerId"] ?? 0,
    deviceType: json["deviceType"] != null
        ? DeviceType.fromJson(json["deviceType"])
        : DeviceType(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialNumber": serialNumber,
    "location": location,
    "description": description,
    "data": data!.toJson(),
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "companyId": companyId,
    "deviceTypeId": deviceTypeId,
    "createdBy": createdBy,
    "growControllerId": growControllerId,
    "deviceType": deviceType!.toJson(),
  };
}

class FluffyData {
  FluffyData({
    this.heap,
    this.time,
    this.wifi,
    this.info1,
    this.info2,
    this.info3,
    this.sleep,
    this.power1,
    this.power2,
    this.power3,
    this.power4,
    this.uptime,
    this.loadAvg,
    this.mqttCount,
    this.sleepMode,
    this.uptimeSec,
    this.topic,
    this.current,
    this.previous,
    this.description,
  });

  int? heap;
  DateTime? time;
  Wifi? wifi;
  Info1? info1;
  Info2? info2;
  Info3? info3;
  int? sleep;
  String? power1;
  String? power2;
  String? power3;
  String? power4;
  String? uptime;
  int? loadAvg;
  int? mqttCount;
  String? sleepMode;
  int? uptimeSec;
  String? topic;
  String? current;
  String? previous;
  String? description;

  factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
    heap: json["Heap"] ?? 0,
    time: json["Time"] == null ? DateTime.now() : DateTime.parse(json["Time"]),
    wifi: json["Wifi"] == null ? Wifi() : Wifi.fromJson(json["Wifi"]),
    info1: json["Info1"] == null ? Info1() : Info1.fromJson(json["Info1"]),
    info2: json["Info2"] == null ? Info2() : Info2.fromJson(json["Info2"]),
    info3: json["Info3"] == null ? Info3() : Info3.fromJson(json["Info3"]),
    sleep: json["Sleep"] ?? 0,
    power1: json["POWER1"] ?? "",
    power2: json["POWER2"] ?? "",
    power3: json["POWER3"] ?? "",
    power4: json["POWER4"] ?? "",
    uptime: json["Uptime"] ?? "",
    loadAvg: json["LoadAvg"] ?? 0,
    mqttCount: json["MqttCount"] ?? 0,
    sleepMode: json["SleepMode"] ?? "",
    uptimeSec: json["UptimeSec"] ?? 0,
    topic: json["topic"] ?? "",
    current: json["current"] ?? "",
    previous: json["previous"] ?? "",
    description: json["description"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Heap": heap,
    "Time": time!.toIso8601String(),
    "Wifi": wifi!.toJson(),
    "Info1": info1!.toJson(),
    "Info2": info2!.toJson(),
    "Info3": info3!.toJson(),
    "Sleep": sleep,
    "POWER1": power1,
    "POWER2": power2,
    "POWER3": power3,
    "POWER4": power4,
    "Uptime": uptime,
    "LoadAvg": loadAvg,
    "MqttCount": mqttCount,
    "SleepMode": sleepMode,
    "UptimeSec": uptimeSec,
    "topic": topic,
    "current": current,
    "previous": previous,
    "description": description,
  };
}

class Info1 {
  Info1({
    this.module,
    this.version,
    this.groupTopic,
    this.fallbackTopic,
  });

  String? module;
  String? version;
  String? groupTopic;
  String? fallbackTopic;

  factory Info1.fromJson(Map<String, dynamic> json) => Info1(
    module: json["Module"] ?? "",
    version: json["Version"] ?? "",
    groupTopic: json["GroupTopic"] ?? "",
    fallbackTopic: json["FallbackTopic"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Module": module,
    "Version": version,
    "GroupTopic": groupTopic,
    "FallbackTopic": fallbackTopic,
  };
}

class Info2 {
  Info2({
    this.hostname,
    this.ipAddress,
    this.webServerMode,
  });

  String? hostname;
  String? ipAddress;
  String? webServerMode;

  factory Info2.fromJson(Map<String, dynamic> json) => Info2(
    hostname: json["Hostname"] ?? "",
    ipAddress: json["IPAddress"] ?? "",
    webServerMode: json["WebServerMode"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Hostname": hostname,
    "IPAddress": ipAddress,
    "WebServerMode": webServerMode,
  };
}

class Info3 {
  Info3({
    this.restartReason,
  });

  String? restartReason;

  factory Info3.fromJson(Map<String, dynamic> json) => Info3(
    restartReason: json["RestartReason"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "RestartReason": restartReason,
  };
}

class DeviceType {
  DeviceType({
    this.id,
    this.type,
    this.label,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? label;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DeviceType.fromJson(Map<String, dynamic> json) => DeviceType(
    id: json["id"] ?? 0,
    type: json["type"] ?? "",
    label: json["label"] ?? "",
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "label": label,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}

class Sensor {
  Sensor({
    this.devices,
    this.total,
    this.online,
    this.offline,
  });

  List<SensorDevice>? devices;
  int? total;
  int? online;
  int? offline;

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
    devices: json["devices"] != null ? List<SensorDevice>.from(json["devices"].map((x) => SensorDevice.fromJson(x))) : [],
    total: json["total"] ?? 0,
    online: json["online"] ?? 0,
    offline: json["offline"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "devices": List<dynamic>.from(devices!.map((x) => x.toJson())),
    "total": total,
    "online": online,
    "offline": offline,
  };
}

class SensorDevice {
  SensorDevice({
    this.id,
    this.serialNumber,
    this.location,
    this.description,
    this.data,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.deviceTypeId,
    this.createdBy,
    this.growControllerId,
    this.deviceType,
  });

  int? id;
  String? serialNumber;
  String? location;
  dynamic description;
  FluffyData? data;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic companyId;
  int? deviceTypeId;
  dynamic createdBy;
  int? growControllerId;
  DeviceType? deviceType;

  factory SensorDevice.fromJson(Map<String, dynamic> json) => SensorDevice(
    id: json["id"] ?? 0,
    serialNumber: json["serialNumber"] ?? "",
    location: json["location"] ?? "",
    description: json["description"] ?? "",
    data: json["data"] != null ? FluffyData.fromJson(json["data"]) : FluffyData(),
    status: json["status"] ?? "",
    createdAt: json["createdAt"] ?? "",
    updatedAt: json["updatedAt"] ?? "",
    companyId: json["companyId"] ?? "",
    deviceTypeId: json["deviceTypeId"] ?? 0,
    createdBy: json["createdBy"] ?? "",
    growControllerId: json["growControllerId"] ?? 0,
    deviceType: json["deviceType"] != null ? DeviceType.fromJson(json["deviceType"]) : DeviceType(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serialNumber": serialNumber,
    "location": location,
    "description": description,
    "data": data!.toJson(),
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "companyId": companyId,
    "deviceTypeId": deviceTypeId,
    "createdBy": createdBy,
    "growControllerId": growControllerId,
    "deviceType": deviceType!.toJson(),
  };
}

class PurpleData {
  PurpleData({
    this.heap,
    this.time,
    this.wifi,
    this.info1,
    this.info2,
    this.info3,
    this.sleep,
    this.uptime,
    this.loadAvg,
    this.mqttCount,
    this.sleepMode,
    this.uptimeSec,
  });

  int? heap;
  DateTime? time;
  Wifi? wifi;
  Info1? info1;
  Info2? info2;
  Info3? info3;
  int? sleep;
  String? uptime;
  int? loadAvg;
  int? mqttCount;
  String? sleepMode;
  int? uptimeSec;

  factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
    heap: json["Heap"] ?? 0,
    time: json["Time"] != null ? DateTime.parse(json["Time"]) : DateTime.now(),
    wifi: json["Wifi"] != null ? Wifi.fromJson(json["Wifi"]) : Wifi(),
    info1: json["Info1"] != null ? Info1.fromJson(json["Info1"]) : Info1(),
    info2: json["Info2"] != null ? Info2.fromJson(json["Info2"]) : Info2(),
    info3: json["Info3"] != null ? Info3.fromJson(json["Info3"]) : Info3(),
    sleep: json["Sleep"] ?? 0,
    uptime: json["Uptime"] ?? "",
    loadAvg: json["LoadAvg"] ?? 0,
    mqttCount: json["MqttCount"] ?? 0,
    sleepMode: json["SleepMode"] ?? "",
    uptimeSec: json["UptimeSec"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "Heap": heap,
    "Time": time!.toIso8601String(),
    "Wifi": wifi!.toJson(),
    "Info1": info1!.toJson(),
    "Info2": info2!.toJson(),
    "Info3": info3!.toJson(),
    "Sleep": sleep,
    "Uptime": uptime,
    "LoadAvg": loadAvg,
    "MqttCount": mqttCount,
    "SleepMode": sleepMode,
    "UptimeSec": uptimeSec,
  };
}

class Wifi {
  Wifi({
    this.ap,
    this.mode,
    this.rssi,
    this.ssId,
    this.bssId,
    this.signal,
    this.channel,
    this.downtime,
    this.linkCount,
  });

  int? ap;
  String? mode;
  int? rssi;
  String? ssId;
  String? bssId;
  int? signal;
  int? channel;
  String? downtime;
  int? linkCount;

  factory Wifi.fromJson(Map<String, dynamic> json) => Wifi(
    ap: json["AP"] ?? 0,
    mode: json["Mode"] ?? "",
    rssi: json["RSSI"] ?? 0,
    ssId: json["SSId"] ?? "",
    bssId: json["BSSId"] ?? "",
    signal: json["Signal"] ?? 0,
    channel: json["Channel"] ?? 0,
    downtime: json["Downtime"] ?? "",
    linkCount: json["LinkCount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "AP": ap,
    "Mode": mode,
    "RSSI": rssi,
    "SSId": ssId,
    "BSSId": bssId,
    "Signal": signal,
    "Channel": channel,
    "Downtime": downtime,
    "LinkCount": linkCount,
  };
}