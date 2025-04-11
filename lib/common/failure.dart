import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:my_strava_ble_app/common/type_defs.dart';

import 'enums/app_error_enum.dart';
import 'enums/error_enum.dart';
import 'enums/userflow_enums.dart';
import 'helper_methods.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure implements Exception {
  factory Failure.fromErrorObject(
    Object error, {
    required UserFlowEnums userFlow,
  }) {
    if (error is String) {
      if (kDebugMode) {
        debugPrint('SOME ERROR ----->$error USERFLOW---> $userFlow');
      }
      if (error.contains('ClientException with SocketException')) {
        // Instance.navigatorKey.currentState?.push(
        //   MaterialPageRoute<void>(
        //     builder: (context) => ServerErrorScreen(
        //       error: error,
        //     ),
        //   ),
        // );
      }
      return Failure._(
        userFlow: userFlow,
      );
    }

    if (error is SocketException) {
      if (kDebugMode) {
        debugPrint('SocketException ----->$error USERFLOW---> $userFlow');
      }
      // Instance.navigatorKey.currentState?.push(
      //   MaterialPageRoute<void>(
      //     builder: (context) => ServerErrorScreen(
      //       error: error,
      //     ),
      //   ),
      // );

      return Failure._(
        userFlow: userFlow,
        appError: AppErrorEnum.serverError,
      );
    }

    if (error is ApiResponse) {
      if (kDebugMode) {
        debugPrint('ApiResponse ----->$error USERFLOW---> $userFlow');
      }

      return Failure._(
        userFlow: userFlow,
        appError: AppErrorEnum.serverError,
      );
    }

    if (error is http.ClientException) {
      if (kDebugMode) {
        debugPrint('ClientException ----->$error USERFLOW---> $userFlow');
      }
      // Instance.navigatorKey.currentState?.push(
      //   MaterialPageRoute<void>(
      //     builder: (context) => ServerErrorScreen(
      //       error: error,
      //     ),
      //   ),
      // );

      return Failure._(
        userFlow: userFlow,
        appError: AppErrorEnum.noInternet,
      );
    }
    if (error is http.Response) {
      final body = error.body;
      final decodedData = jsonDecode(body);
      // final exceptionData = HelperMethods.safeCast<ApiResponse>(decodedData);

      var serverErrorMessage = 'Something went wrong';
      // if (exceptionData != null &&
      //     exceptionData.containsKey(JsonKeys.message)) {
      //   serverErrorMessage = exceptionData[JsonKeys.message].toString();
      // }
      // if (kDebugMode) {
      //   debugPrint(
      //     'api status code ----->${error.statusCode} USERFLOW---> $userFlow',
      //   );
      // }

      switch (error.statusCode) {
        case 200 when error.body.isEmpty:
          return Failure._(
            message: 'No data found',
            userFlow: userFlow,
            appError: AppErrorEnum.responseDataError,
          );
        case 400:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.badRequest,
          );

        case 401:

          // HiveService.clearAll();
          // final context = Instance.navigatorKey.currentContext!;
          // ScaffoldMessenger.of(context).clearSnackBars();
          //
          // ScaffoldMessenger.of(context).showSnackBar(
          //   newSnackBarWidget(
          //     isError: true,
          //     context: context,
          //     headingText: 'UnAuthorized!',
          //     text: 'Navigating to login!',
          //   ),
          // );

          // Instance.navigatorKey.currentState?.pushReplacement(
          //   MaterialPageRoute<void>(
          //     builder: (context) => BlocProvider<LoginBloc>(
          //       create: (_) => LoginBloc()..add(const InitPhoneNumberField()),
          //       child: const LoginMain(),
          //     ),
          //   ),
          // );
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.unauthorized,
          );
        case 404:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.notFound,
          );
        case 500:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.serverError,
          );
        case 408:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.requestTimeout,
          );
        case 409:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.conflict,
          );
        case 422:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.unprocessableEntity,
          );
        case 502:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.badGateway,
          );
        case 503:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.serviceUnavailable,
          );
        case 524:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.timedOut,
          );
        default:
          return Failure._(
            message: serverErrorMessage,
            userFlow: userFlow,
            appError: AppErrorEnum.unknown,
          );
      }
    }

    // if (error is FirebaseException) {
    //   if (kDebugMode) {
    //     debugPrint(error.toString());
    //   }
    //
    //   final noHostError = HelperMethods.containsWord(
    //     string: error.message,
    //     wordToSearch: 'Failed host lookup:',
    //   );
    //   if (noHostError) {
    //     return Failure._(
    //       appError: AppErrorEnum.noInternet,
    //       userFlow: userFlow,
    //     );
    //   }
    //   return Failure._(
    //     firebaseError: FirebaseException(
    //       message: error.message,
    //       code: error.code,
    //       plugin: 'Cloud_Firestore',
    //     ),
    //     userFlow: userFlow,
    //   );
    // }
    if (error is PlatformException) {
      if (kDebugMode) {
        debugPrint(error.toString());
      }

      final platformError = PlatformErrorEnum.getErrorFromCode(error.code);
      return Failure._(platformError: platformError, userFlow: userFlow);
    }
    // if (error is MediaServiceException) {
    //   return Failure._(mediaServiceError: error.error, userFlow: userFlow);
    // }

    return _instance;
  }
  factory Failure._({
    required UserFlowEnums userFlow,
    String? message,
    PlatformErrorEnum? platformError,
    AppErrorEnum? appError,
  }) = _Failure;

  static final _instance = Failure._(userFlow: UserFlowEnums.unknown);
}
