import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_strava_ble_app/common/api_services.dart';
import 'package:my_strava_ble_app/modules/strava/repo/strava_repo.dart';

class Instance{
  static final scaffoldMessengerState = GlobalKey<ScaffoldMessengerState>();
  static final scaffoldState = GlobalKey<ScaffoldState>();
  static final theme = ThemeData();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final navigator = Navigator.of(navigatorKey.currentContext!);
  static final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  static final ApiServices apiServices = ApiServices();
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static   StravaRepo stravaRepo = StravaRepo();

}