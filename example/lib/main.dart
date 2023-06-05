import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_external_app/flutter_external_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String androidLink =
      'intent://payment#Intent;action=ch.twint.action.TWINT_UOF_REGISTRATION;scheme=twint;S.code=T23LU9K;S.startingOrigin=EXTERNAL_WEB_BROWSER;S.browser_fallback_url=;end';
  String iosLink =
      'twint-issuer1://applinks/?al_applink_data={"app_action_type": "TWINT_PAYMENT","extras": {"code": "{token}",},"referer_app_link": {"target_url": "", "url": "", "app_name": "EXTERNAL_WEB_BROWSER"}, "version": "6.0" }';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter External app example'),
        ),
        body: ElevatedButton(
          onPressed: () {
            // This platform check for static link only
            // In production just use this only
            // FlutterExternalApp.openApp(link);
            if (Platform.isAndroid) {
              FlutterExternalApp.openApp(androidLink);
            } else if (Platform.isIOS) {
              FlutterExternalApp.openApp(iosLink);
            }
          },
          child: const Text('Open External App'),
        ),
      ),
    );
  }
}
