import 'package:get_storage/get_storage.dart';

class StoreData {

  static const String accessToken = "accessToken";
  static const String id = "id";
  static const String identifier = "identifier";
  static const String irrigationId = "irrigationId";
  static const String fertigationId1 = "fertigationId1";
  static const String fertigationId2 = "fertigationId2";
  static const String roleId = "roleId";
  static const String email = "email";

  void setData(String key, dynamic value) => GetStorage().write(key, value);

  int? getInt(String key) => GetStorage().read(key);

  String? getString(String key) => GetStorage().read(key);

  bool? getBool(String key) => GetStorage().read(key);

  double? getDouble(String key) => GetStorage().read(key);

  dynamic getData(String key) => GetStorage().read(key);

  void clearData() async => GetStorage().erase();

}