import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvKeyEnum {
  stravaClientId('STRAVA_CLIENT_ID'),
  stravaRedirectUri('STRAVA_REDIRECT_URI'),
  stravaClientSecret('STRAVA_CLIENT_SECRET');

  const EnvKeyEnum(this.stringValue);
  final String stringValue;

  static String getEnvValue(EnvKeyEnum key) {
    try {
      final value = dotenv.env[key.stringValue];
      if (value == null) {
        throw Exception('Missing environment variable: ${key.stringValue}');
      }
      return value;
    } catch (error) {
      throw Exception('Missing environment variable: ${key.stringValue}');
    }
  }
}
