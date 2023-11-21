import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceService {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void setString(String key, String val) {
    prefs?.setString(key, val);
  }

  static String getString(String key) => prefs?.getString(key) ?? "";

  static void clean(String key) {
    prefs?.remove(key);
  }
  
}
