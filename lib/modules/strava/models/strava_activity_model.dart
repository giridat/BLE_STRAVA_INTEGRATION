class StravaActivityModel {
  final String? id;
  final AthleteData? athlete;
  final String? name;
  final double? distance;
  final int? movingTime;
  final int? elapsedTime;
  final double? totalElevationGain;
  final String? type;
  final String? sportType;
  final int? workoutType;
  final DateTime? startDate;
  final DateTime? startDateLocal;
  final String? timezone;
  final double? utcOffset;
  final String? locationCity;
  final String? locationState;
  final String? locationCountry;
  final int? achievementCount;
  final int? kudosCount;
  final int? commentCount;
  final int? athleteCount;
  final int? photoCount;
  final MapData? map;
  final bool? trainer;
  final bool? commute;
  final bool? manual;
  final bool? private;
  final String? visibility;
  final bool? flagged;
  final String? gearId;
  final List<double>? startLatlng;
  final List<double>? endLatlng;
  final double? averageSpeed;
  final double? maxSpeed;
  final bool? hasHeartrate;
  final bool? heartrateOptOut;
  final bool? displayHideHeartrateOption;
  final double? elevHigh;
  final double? elevLow;
  final String? uploadId;
  final String? uploadIdStr;
  final String? externalId;
  final bool? fromAcceptedTag;
  final int? prCount;
  final int? totalPhotoCount;
  final bool? hasKudoed;

  StravaActivityModel({
    this.id,
    this.athlete,
    this.name,
    this.distance,
    this.movingTime,
    this.elapsedTime,
    this.totalElevationGain,
    this.type,
    this.sportType,
    this.workoutType,
    this.startDate,
    this.startDateLocal,
    this.timezone,
    this.utcOffset,
    this.locationCity,
    this.locationState,
    this.locationCountry,
    this.achievementCount,
    this.kudosCount,
    this.commentCount,
    this.athleteCount,
    this.photoCount,
    this.map,
    this.trainer,
    this.commute,
    this.manual,
    this.private,
    this.visibility,
    this.flagged,
    this.gearId,
    this.startLatlng,
    this.endLatlng,
    this.averageSpeed,
    this.maxSpeed,
    this.hasHeartrate,
    this.heartrateOptOut,
    this.displayHideHeartrateOption,
    this.elevHigh,
    this.elevLow,
    this.uploadId,
    this.uploadIdStr,
    this.externalId,
    this.fromAcceptedTag,
    this.prCount,
    this.totalPhotoCount,
    this.hasKudoed,
  });

  factory StravaActivityModel.fromJson(Map<String, dynamic> json) {
    return StravaActivityModel(
      id: json['id']?.toString(),
      athlete: json['athlete'] != null ? AthleteData.fromJson(json['athlete']) : null,
      name: json['name'],
      distance: (json['distance'] as num?)?.toDouble(),
      movingTime: json['moving_time'],
      elapsedTime: json['elapsed_time'],
      totalElevationGain: (json['total_elevation_gain'] as num?)?.toDouble(),
      type: json['type'],
      sportType: json['sport_type'],
      workoutType: json['workout_type'],
      startDate: json['start_date'] != null ? DateTime.tryParse(json['start_date']) : null,
      startDateLocal: json['start_date_local'] != null ? DateTime.tryParse(json['start_date_local']) : null,
      timezone: json['timezone'],
      utcOffset: (json['utc_offset'] as num?)?.toDouble(),
      locationCity: json['location_city'],
      locationState: json['location_state'],
      locationCountry: json['location_country'],
      achievementCount: json['achievement_count'],
      kudosCount: json['kudos_count'],
      commentCount: json['comment_count'],
      athleteCount: json['athlete_count'],
      photoCount: json['photo_count'],
      map: json['map'] != null ? MapData.fromJson(json['map']) : null,
      trainer: json['trainer'],
      commute: json['commute'],
      manual: json['manual'],
      private: json['private'],
      visibility: json['visibility'],
      flagged: json['flagged'],
      gearId: json['gear_id'],
      startLatlng: (json['start_latlng'] as List?)?.map((e) => (e as num).toDouble()).toList(),
      endLatlng: (json['end_latlng'] as List?)?.map((e) => (e as num).toDouble()).toList(),
      averageSpeed: (json['average_speed'] as num?)?.toDouble(),
      maxSpeed: (json['max_speed'] as num?)?.toDouble(),
      hasHeartrate: json['has_heartrate'],
      heartrateOptOut: json['heartrate_opt_out'],
      displayHideHeartrateOption: json['display_hide_heartrate_option'],
      elevHigh: (json['elev_high'] as num?)?.toDouble(),
      elevLow: (json['elev_low'] as num?)?.toDouble(),
      uploadId: json['upload_id']?.toString(),
      uploadIdStr: json['upload_id_str'],
      externalId: json['external_id'],
      fromAcceptedTag: json['from_accepted_tag'],
      prCount: json['pr_count'],
      totalPhotoCount: json['total_photo_count'],
      hasKudoed: json['has_kudoed'],
    );
  }

  StravaActivityModel copyWith({
    String? id,
    AthleteData? athlete,
    String? name,
    double? distance,
    int? movingTime,
    int? elapsedTime,
    double? totalElevationGain,
    String? type,
    String? sportType,
    int? workoutType,
    DateTime? startDate,
    DateTime? startDateLocal,
    String? timezone,
    double? utcOffset,
    String? locationCity,
    String? locationState,
    String? locationCountry,
    int? achievementCount,
    int? kudosCount,
    int? commentCount,
    int? athleteCount,
    int? photoCount,
    MapData? map,
    bool? trainer,
    bool? commute,
    bool? manual,
    bool? private_,
    String? visibility,
    bool? flagged,
    String? gearId,
    List<double>? startLatlng,
    List<double>? endLatlng,
    double? averageSpeed,
    double? maxSpeed,
    bool? hasHeartrate,
    bool? heartrateOptOut,
    bool? displayHideHeartrateOption,
    double? elevHigh,
    double? elevLow,
    String? uploadId,
    String? uploadIdStr,
    String? externalId,
    bool? fromAcceptedTag,
    int? prCount,
    int? totalPhotoCount,
    bool? hasKudoed,
  }) {
    return StravaActivityModel(
      id: id ?? this.id,
      athlete: athlete ?? this.athlete,
      name: name ?? this.name,
      distance: distance ?? this.distance,
      movingTime: movingTime ?? this.movingTime,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      totalElevationGain: totalElevationGain ?? this.totalElevationGain,
      type: type ?? this.type,
      sportType: sportType ?? this.sportType,
      workoutType: workoutType ?? this.workoutType,
      startDate: startDate ?? this.startDate,
      startDateLocal: startDateLocal ?? this.startDateLocal,
      timezone: timezone ?? this.timezone,
      utcOffset: utcOffset ?? this.utcOffset,
      locationCity: locationCity ?? this.locationCity,
      locationState: locationState ?? this.locationState,
      locationCountry: locationCountry ?? this.locationCountry,
      achievementCount: achievementCount ?? this.achievementCount,
      kudosCount: kudosCount ?? this.kudosCount,
      commentCount: commentCount ?? this.commentCount,
      athleteCount: athleteCount ?? this.athleteCount,
      photoCount: photoCount ?? this.photoCount,
      map: map ?? this.map,
      trainer: trainer ?? this.trainer,
      commute: commute ?? this.commute,
      manual: manual ?? this.manual,
      private: private_ ?? this.private,
      visibility: visibility ?? this.visibility,
      flagged: flagged ?? this.flagged,
      gearId: gearId ?? this.gearId,
      startLatlng: startLatlng ?? this.startLatlng,
      endLatlng: endLatlng ?? this.endLatlng,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      hasHeartrate: hasHeartrate ?? this.hasHeartrate,
      heartrateOptOut: heartrateOptOut ?? this.heartrateOptOut,
      displayHideHeartrateOption: displayHideHeartrateOption ?? this.displayHideHeartrateOption,
      elevHigh: elevHigh ?? this.elevHigh,
      elevLow: elevLow ?? this.elevLow,
      uploadId: uploadId ?? this.uploadId,
      uploadIdStr: uploadIdStr ?? this.uploadIdStr,
      externalId: externalId ?? this.externalId,
      fromAcceptedTag: fromAcceptedTag ?? this.fromAcceptedTag,
      prCount: prCount ?? this.prCount,
      totalPhotoCount: totalPhotoCount ?? this.totalPhotoCount,
      hasKudoed: hasKudoed ?? this.hasKudoed,
    );
  }
}

class AthleteData {
  final int? id;
  final int? resourceState;

  AthleteData({
    this.id,
    this.resourceState,
  });

  factory AthleteData.fromJson(Map<String, dynamic> json) {
    return AthleteData(
      id: json['id'],
      resourceState: json['resource_state'],
    );
  }
}

class MapData {
  final String? id;
  final String? summaryPolyline;

  MapData({
    this.id,
    this.summaryPolyline,
  });

  factory MapData.fromJson(Map<String, dynamic> json) {
    return MapData(
      id: json['id'],
      summaryPolyline: json['summary_polyline'],
    );
  }
}