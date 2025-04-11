import 'package:dartz/dartz.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_strava_ble_app/common/enums/userflow_enums.dart';
import 'package:my_strava_ble_app/common/env_key_enum.dart';
import 'package:my_strava_ble_app/common/failure.dart';
import 'package:my_strava_ble_app/common/instances.dart';
import 'package:my_strava_ble_app/common/repo_type.dart';
import 'package:my_strava_ble_app/modules/strava/models/strava_activity_model.dart';
import 'package:my_strava_ble_app/modules/strava/models/strava_token_response.dart';

import '../../../common/api_constants.dart';

part 'strava_repo.freezed.dart';

@freezed
class StravaRepo extends Repo with _$StravaRepo {
  const factory StravaRepo({
    List<StravaActivityModel>? activity,
    String? accessToken,
  }) = _StravaRepo;
  const StravaRepo._();

  Future<Either<Failure, List<StravaActivityModel>>> getActivity() async {
    try {
      final response = await Instance.apiServices
          .getRequest(url: ApiConstants.getActivityUrl);
      return response.fold(
          (l) => Left(Failure.fromErrorObject(l,
              userFlow: UserFlowEnums.stravaLoginError)), (r) {
        final parsedJson = r as List;
        final activities = parsedJson
            .map((e) => StravaActivityModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(activities);
      });
    } catch (e, ex) {
      return Left(
          Failure.fromErrorObject(e, userFlow: UserFlowEnums.stravaLoginError));
    }
  }

  Future<Either<Failure, StravaTokenResponse>> getTokenFromCode(
      {required String code}) async {
    try {

      final tokenRequest = await Instance.apiServices.postRequest(
        url: ApiConstants.stravaTokenUrl,
        body: {
          'client_id': EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientId),
          'client_secret':
              EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientSecret),
          'grant_type': 'authorization_code',
          'code': code,
        },
      );

      return tokenRequest.fold(
        (l) => Left(Failure.fromErrorObject(l,
            userFlow: UserFlowEnums.stravaLoginError)),
        (r) {
          final parsedJson = r as Map<String, dynamic>;
          final data = StravaTokenResponse.fromJson(parsedJson);

          // Save tokens to secure storage
          Instance.secureStorage
              .write(key: 'accessToken', value: data.accessToken);
          Instance.secureStorage
              .write(key: 'refreshToken', value: data.refreshToken);
          Instance.secureStorage
              .write(key: 'expiresAt', value: data.expiresAt.toString());
          Instance.secureStorage
              .write(key: 'expiresIn', value: data.expiresIn.toString());

          return Right(data);
        },
      );
    } catch (e) {
      return Left(
          Failure.fromErrorObject(e, userFlow: UserFlowEnums.stravaLoginError));
    }
  }

  Future<Either<Failure, StravaTokenResponse>> getToken(
      {required String params}) async {
    try {
      print('params:  ${ApiConstants.stravaAuthorizeUrl + params}');
      final codeRequest = await FlutterWebAuth2.authenticate(
        url: ApiConstants.stravaAuthorizeUrl + params,
        callbackUrlScheme: 'mystravaapp',
      );

      final code = Uri.parse(codeRequest).queryParameters['code'];
      if (code == null) {
        return Left(Failure.fromErrorObject('code is null',
            userFlow: UserFlowEnums.stravaLoginError));
      } else {
        final tokenRequest = await Instance.apiServices
            .postRequest(url: ApiConstants.stravaTokenUrl, body: {
          'client_id': EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientId),
          'client_secret':
              EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientSecret),
          'grant_type': 'authorization_code',
          'code': code,
        });
        return tokenRequest.fold(
            (l) => Left(Failure.fromErrorObject(l,
                userFlow: UserFlowEnums.stravaLoginError)), (r) {
          final parsedJson = r as Map<String, dynamic>;
          final data = StravaTokenResponse.fromJson(parsedJson);

          Instance.secureStorage
              .write(key: 'accessToken', value: data.accessToken);
          Instance.secureStorage
              .write(key: 'refreshToken', value: data.refreshToken);
          Instance.secureStorage
              .write(key: 'expiresAt', value: data.expiresAt.toString());
          Instance.secureStorage
              .write(key: 'expiresIn', value: data.expiresIn.toString());

          return Right(data);
        });
      }
    } catch (e, ex) {
      return Left(
          Failure.fromErrorObject(e, userFlow: UserFlowEnums.stravaLoginError));
    }
  }

  Future<Either<Failure, StravaTokenResponse>> refreshToken(
      {required String token}) async {
    try {
      final tokenRequest = await Instance.apiServices
          .postRequest(url: ApiConstants.stravaTokenUrl, body: {
        'client_id': EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientId),
        'client_secret': EnvKeyEnum.getEnvValue(EnvKeyEnum.stravaClientSecret),
        'grant_type': 'refresh_token',
        'refresh_token': token
      });
      return tokenRequest.fold(
          (l) => Left(Failure.fromErrorObject(l,
              userFlow: UserFlowEnums.stravaLoginError)), (r) {
        final parsedJson = r as Map<String, dynamic>;
        final data = StravaTokenResponse.fromJson(parsedJson);

        Instance.secureStorage
            .write(key: 'accessToken', value: data.accessToken);
        Instance.secureStorage
            .write(key: 'refreshToken', value: data.refreshToken);
        Instance.secureStorage
            .write(key: 'expiresAt', value: data.expiresAt.toString());
        Instance.secureStorage
            .write(key: 'expiresIn', value: data.expiresIn.toString());

        return Right(data);
      });
    } catch (e, ex) {
      return Left(
          Failure.fromErrorObject(e, userFlow: UserFlowEnums.stravaLoginError));
    }
  }
}
