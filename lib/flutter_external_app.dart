import 'dart:io';

import 'package:flutter/services.dart';

class FlutterExternalApp {
  /// Method channel declaration
  static const MethodChannel _methodChannel =
      MethodChannel('me.hmbadhon.flutter_external_app');

  static void openApp(String link) {
    if (Platform.isAndroid) {
      _methodChannel.invokeMethod("sendToExternalApp", link);
    } else if (Platform.isIOS) {
      _methodChannel.invokeMethod("sendToExternalAppIOS", link);
    }
  }
}
