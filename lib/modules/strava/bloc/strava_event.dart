part of 'strava_bloc.dart';

sealed class StravaEvent {}

@freezed
class AuthenticateStravaEvent extends StravaEvent with _$AuthenticateStravaEvent {
  const factory AuthenticateStravaEvent() = _AuthenticateStravaEvent;
}

@freezed
class GetStravaDataEvent extends StravaEvent with _$GetStravaDataEvent {
  const factory GetStravaDataEvent() = _GetStravaDataEvent;
}

@freezed
class StravaDeepLinkReceivedEvent extends StravaEvent  with _$StravaDeepLinkReceivedEvent {
  factory StravaDeepLinkReceivedEvent({required String code}) = _StravaDeepLinkReceivedEvent;

}
