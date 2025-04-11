part of 'strava_bloc.dart';


sealed class StravaState {}

@freezed
class StravaStateInitial extends StravaState with _$StravaStateInitial {
  const factory StravaStateInitial() = _StravaStateInitial;
}

@freezed
class AuthenticatingStrava extends StravaState with _$AuthenticatingStrava {
  const factory AuthenticatingStrava() = _AuthenticatingStrava;
}

@freezed
class StravaAuthenticated extends StravaState with _$StravaAuthenticated {
  const factory StravaAuthenticated() = _StravaAuthenticated;
}

@freezed
class AuthenticationFailed extends StravaState with _$AuthenticationFailed {
  const factory AuthenticationFailed() = _AuthenticationFailed;
}

@freezed
class FetchingStravaData extends StravaState with _$FetchingStravaData {
  const factory FetchingStravaData() = _FetchingStravaData;
}

@freezed
class StravaDataFetched extends StravaState with _$StravaDataFetched {
  const factory StravaDataFetched(List<StravaActivityModel> activity) = _StravaDataFetched;
}

@freezed
class StravaDataFetchError extends StravaState with _$StravaDataFetchError {
  const factory StravaDataFetchError( String? errorMsg) = _StravaDataFetchError;
}


