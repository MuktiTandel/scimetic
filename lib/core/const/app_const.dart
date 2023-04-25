import 'package:flutter/foundation.dart';

class AppConst {

  void debug(String message) {
    if (kDebugMode) {
      print(message);
    }
  }

}