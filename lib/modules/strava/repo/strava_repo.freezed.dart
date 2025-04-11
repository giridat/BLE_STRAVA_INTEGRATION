// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'strava_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StravaRepo {
  List<StravaActivityModel>? get activity => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;

  /// Create a copy of StravaRepo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StravaRepoCopyWith<StravaRepo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StravaRepoCopyWith<$Res> {
  factory $StravaRepoCopyWith(
          StravaRepo value, $Res Function(StravaRepo) then) =
      _$StravaRepoCopyWithImpl<$Res, StravaRepo>;
  @useResult
  $Res call({List<StravaActivityModel>? activity, String? accessToken});
}

/// @nodoc
class _$StravaRepoCopyWithImpl<$Res, $Val extends StravaRepo>
    implements $StravaRepoCopyWith<$Res> {
  _$StravaRepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StravaRepo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_value.copyWith(
      activity: freezed == activity
          ? _value.activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<StravaActivityModel>?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StravaRepoImplCopyWith<$Res>
    implements $StravaRepoCopyWith<$Res> {
  factory _$$StravaRepoImplCopyWith(
          _$StravaRepoImpl value, $Res Function(_$StravaRepoImpl) then) =
      __$$StravaRepoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StravaActivityModel>? activity, String? accessToken});
}

/// @nodoc
class __$$StravaRepoImplCopyWithImpl<$Res>
    extends _$StravaRepoCopyWithImpl<$Res, _$StravaRepoImpl>
    implements _$$StravaRepoImplCopyWith<$Res> {
  __$$StravaRepoImplCopyWithImpl(
      _$StravaRepoImpl _value, $Res Function(_$StravaRepoImpl) _then)
      : super(_value, _then);

  /// Create a copy of StravaRepo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activity = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_$StravaRepoImpl(
      activity: freezed == activity
          ? _value._activity
          : activity // ignore: cast_nullable_to_non_nullable
              as List<StravaActivityModel>?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$StravaRepoImpl extends _StravaRepo {
  const _$StravaRepoImpl(
      {final List<StravaActivityModel>? activity, this.accessToken})
      : _activity = activity,
        super._();

  final List<StravaActivityModel>? _activity;
  @override
  List<StravaActivityModel>? get activity {
    final value = _activity;
    if (value == null) return null;
    if (_activity is EqualUnmodifiableListView) return _activity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? accessToken;

  @override
  String toString() {
    return 'StravaRepo(activity: $activity, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StravaRepoImpl &&
            const DeepCollectionEquality().equals(other._activity, _activity) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_activity), accessToken);

  /// Create a copy of StravaRepo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StravaRepoImplCopyWith<_$StravaRepoImpl> get copyWith =>
      __$$StravaRepoImplCopyWithImpl<_$StravaRepoImpl>(this, _$identity);
}

abstract class _StravaRepo extends StravaRepo {
  const factory _StravaRepo(
      {final List<StravaActivityModel>? activity,
      final String? accessToken}) = _$StravaRepoImpl;
  const _StravaRepo._() : super._();

  @override
  List<StravaActivityModel>? get activity;
  @override
  String? get accessToken;

  /// Create a copy of StravaRepo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StravaRepoImplCopyWith<_$StravaRepoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
