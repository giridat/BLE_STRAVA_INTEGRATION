import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:my_strava_ble_app/common/failure.dart';
import 'package:my_strava_ble_app/common/instances.dart';
import 'package:my_strava_ble_app/common/type_defs.dart';
import 'package:http/http.dart' as http;

import 'enums/userflow_enums.dart';
import 'helper_methods.dart';

class ApiServices {
  Future<Either<Failure, List<dynamic>?>> getRequest(
      {required String url}) async {
    try {
      final token = await Instance.secureStorage.read(key: 'accessToken');
      if (token == null) {
        return Left(Failure.fromErrorObject('token is null',
            userFlow: UserFlowEnums.getRequestError));
      }
      final responseData = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (responseData.statusCode == 200) {
        final decoded = jsonDecode(responseData.body); // Now it's a List or Map
        final finalData = HelperMethods.safeCast<List<dynamic>>(decoded);

        if (finalData == null) {
          return Left(
            Failure.fromErrorObject(
              responseData,
              userFlow: UserFlowEnums.getRequestError,
            ),
          );
        }
        return Right(finalData);
      }
      HelperMethods.printWrapped('response------>:$url \n${responseData.body}');
      return Left(
        Failure.fromErrorObject(
          responseData,
          userFlow: UserFlowEnums.getRequestError,
        ),
      );
    } catch (e, ex) {
      return Left(
          Failure.fromErrorObject(e, userFlow: UserFlowEnums.getRequestError));
    }
  }

  Future<Either<Failure, ApiResponse?>> postRequest(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    try {
      //add print
      print('request------>:$url \n$body');

      final responseData = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      //add print
      if (responseData.statusCode == 200 || responseData.statusCode == 201) {
        final json = responseData.body;
        var finalData = HelperMethods.safeCast<ApiResponse>(json);

        final decodedJson = jsonDecode(json);
        finalData = HelperMethods.safeCast<ApiResponse>(decodedJson);

        if (finalData == null) {
          return Left(
            Failure.fromErrorObject(
              responseData,
              userFlow: UserFlowEnums.postRequestError,
            ),
          );
        }
        HelperMethods.printWrapped('response------>:$url \n$finalData');
        return Right(finalData);
      }
      HelperMethods.printWrapped(
        'Error response------>:$url \n status code------>:${responseData.statusCode} \nbody------>: ${responseData.body.isEmpty ? '' : responseData.body}',
      );

      return Left(
        Failure.fromErrorObject(
          responseData,
          userFlow: UserFlowEnums.postRequestError,
        ),
      );
    } catch (e, s) {
      return Left(Failure.fromErrorObject(
        e,
        userFlow: UserFlowEnums.postRequestError,
      ));
    }
  }
}
