import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_strava_ble_app/bootstrap.dart';

import 'package:my_strava_ble_app/modules/strava/bloc/strava_bloc.dart';
import 'package:my_strava_ble_app/modules/strava/view/strava_main_view.dart';

import '../../common/instances.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: Instance.scaffoldState,
      navigatorObservers: [RouteObserverService()],
      navigatorKey: Instance.navigatorKey,
      title: 'Strava BLE App',
      home: BlocProvider<StravaBloc>(
        create: (context) => StravaBloc( AppLinks())..add(AuthenticateStravaEvent()),
        child: StravaMainView(),
      ),
    );
  }
}
