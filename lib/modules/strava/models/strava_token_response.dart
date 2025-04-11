class StravaTokenResponse {
  final String? accessToken;
  final String? refreshToken;
  final int? expiresAt;
  final int? expiresIn;

  StravaTokenResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.expiresIn,
  });

  factory StravaTokenResponse.fromJson(Map<String, dynamic> json) {
    return StravaTokenResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresAt: json['expires_at'],
      expiresIn: json['expires_in'],
    );
  }
  //copywith
  StravaTokenResponse copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresAt,
    int? expiresIn,
  }) {
    return StravaTokenResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }
}
