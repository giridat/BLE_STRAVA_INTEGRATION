import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_strava_ble_app/common/api_constants.dart';
import 'package:my_strava_ble_app/common/env_key_enum.dart';
import 'package:my_strava_ble_app/common/instances.dart';
import 'package:my_strava_ble_app/modules/strava/models/strava_activity_model.dart';
import 'package:my_strava_ble_app/services_config/app_links.dart';

part 'strava_event.dart';
part 'strava_state.dart';

part 'strava_bloc.freezed.dart';

class StravaBloc extends Bloc<StravaEvent, StravaState> {
  late final StreamSubscription _deepLinkSub;

  StravaBloc(AppLinks appLinks) : super(StravaStateInitial()) {
    _deepLinkSub = appLinks.uriLinkStream.listen(_handleUri);
    on<AuthenticateStravaEvent>(_onAuthenticateStravaEvent);
    on<GetStravaDataEvent>(_onGetActivityEvent);
    on<StravaDeepLinkReceivedEvent>(_onStravaDeepLinkReceived);
  }

  void _handleUri(Uri? uri) {

    if (uri != null &&
        uri.scheme == 'mystravaapp' &&
        uri.host == 'mystravaapp') {
      final code = uri.queryParameters['code'];
      if (code != null) {
        add(StravaDeepLinkReceivedEvent(code: code));
      }
    }
  }

  @override
  Future<void> close() {
    _deepLinkSub.cancel();
    return super.close();
  }
}

FutureOr<void> _onStravaDeepLinkReceived(
    StravaDeepLinkReceivedEvent event, Emitter<StravaState> emit) async {
  emit(AuthenticatingStrava());

  final tokenResult =
      await Instance.stravaRepo.getTokenFromCode(code: event.code);

  tokenResult.fold(
    (l) => emit(AuthenticationFailed()),
    (r) {
      Instance.stravaRepo =
          Instance.stravaRepo.copyWith(accessToken: r.accessToken);
      emit(StravaAuthenticated());
    },
  );
}

FutureOr<void> _onAuthenticateStravaEvent(
  AuthenticateStravaEvent event,
  Emitter<StravaState> emit,
) async {
  emit(AuthenticatingStrava());

  final accessToken = await Instance.secureStorage.read(key: 'accessToken');
  final expiresAtStr = await Instance.secureStorage.read(key: 'expiresAt');
  final refreshToken = await Instance.secureStorage.read(key: 'refreshToken');

  final nowInSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final expiresAt = int.tryParse(expiresAtStr ?? '');

  final isTokenValid =
      accessToken != null && expiresAt != null && nowInSeconds < expiresAt;

  if (isTokenValid) {
    Instance.stravaRepo =
        Instance.stravaRepo.copyWith(accessToken: accessToken);
    emit(StravaAuthenticated());
    return;
  }

  if (refreshToken != null && expiresAt != null && nowInSeconds >= expiresAt) {
    final refreshResult =
        await Instance.stravaRepo.refreshToken(token: refreshToken);

    return refreshResult.fold(
      (l) => emit(AuthenticationFailed()),
      (r) {
        Instance.stravaRepo =
            Instance.stravaRepo.copyWith(accessToken: r.accessToken);
        emit(StravaAuthenticated());
      },
    );
  }

  final authParams =
      'client_id=${EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientId)}'
      '&response_type=code'
      '&redirect_uri=${EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaRedirectUri)}'
      '&approval_prompt=auto'
      '&scope=activity:read';

  final authUrl = 'https://www.strava.com/oauth/mobile/authorize?$authParams';


  try {
    final result = await FlutterWebAuth2.authenticate(
      url: authUrl,
      callbackUrlScheme: 'mystravaapp',
    );

    final uri = Uri.parse(result);
    final code = uri.queryParameters['code'];

    if (code != null) {
      final tokenResult =
          await Instance.stravaRepo.getTokenFromCode(code: code);

      return tokenResult.fold(
        (l) => emit(AuthenticationFailed()),
        (r) {
          Instance.stravaRepo =
              Instance.stravaRepo.copyWith(accessToken: r.accessToken);
          emit(StravaAuthenticated());
        },
      );
    } else {
      emit(AuthenticationFailed());
    }
  } catch (e) {
    emit(AuthenticationFailed());
  }
}

FutureOr<void> _onGetActivityEvent(
    GetStravaDataEvent event, Emitter<StravaState> emit) async {
  emit(FetchingStravaData());
  final result = await Instance.stravaRepo.getActivity();
  result.fold((l) => emit(StravaDataFetchError(l.message)), (r) {
    final data = r;
    Instance.stravaRepo = Instance.stravaRepo.copyWith(activity: [...data]);
    if (data.isEmpty) {
      emit(AuthenticationFailed());
      return;
    }
    emit(StravaDataFetched(data));
  });
}
