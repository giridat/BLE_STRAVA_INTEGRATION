import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_strava_ble_app/modules/strava/bloc/strava_bloc.dart';

void listenToStravaDeepLinks(BuildContext context) {
  final _appLinks = AppLinks();




  _appLinks.uriLinkStream.listen((Uri? uri) {
    print('Received URI: $uri'); // 🔍

    if (uri != null && uri.scheme == 'mystravaapp' && uri.host == 'callback') {
      final code = uri.queryParameters['code'];
      print('Received code: $code'); // 🔍

      if (code != null) {
        context.read<StravaBloc>().add(StravaDeepLinkReceivedEvent(code: code));
      } else {
        print('code is null');
      }
    }
  });
}
