// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  UserFlowEnums get userFlow => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  PlatformErrorEnum? get platformError => throw _privateConstructorUsedError;
  AppErrorEnum? get appError => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call(
      {UserFlowEnums userFlow,
      String? message,
      PlatformErrorEnum? platformError,
      AppErrorEnum? appError});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userFlow = null,
    Object? message = freezed,
    Object? platformError = freezed,
    Object? appError = freezed,
  }) {
    return _then(_value.copyWith(
      userFlow: null == userFlow
          ? _value.userFlow
          : userFlow // ignore: cast_nullable_to_non_nullable
              as UserFlowEnums,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      platformError: freezed == platformError
          ? _value.platformError
          : platformError // ignore: cast_nullable_to_non_nullable
              as PlatformErrorEnum?,
      appError: freezed == appError
          ? _value.appError
          : appError // ignore: cast_nullable_to_non_nullable
              as AppErrorEnum?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserFlowEnums userFlow,
      String? message,
      PlatformErrorEnum? platformError,
      AppErrorEnum? appError});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userFlow = null,
    Object? message = freezed,
    Object? platformError = freezed,
    Object? appError = freezed,
  }) {
    return _then(_$FailureImpl(
      userFlow: null == userFlow
          ? _value.userFlow
          : userFlow // ignore: cast_nullable_to_non_nullable
              as UserFlowEnums,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      platformError: freezed == platformError
          ? _value.platformError
          : platformError // ignore: cast_nullable_to_non_nullable
              as PlatformErrorEnum?,
      appError: freezed == appError
          ? _value.appError
          : appError // ignore: cast_nullable_to_non_nullable
              as AppErrorEnum?,
    ));
  }
}

/// @nodoc

class _$FailureImpl with DiagnosticableTreeMixin implements _Failure {
  _$FailureImpl(
      {required this.userFlow,
      this.message,
      this.platformError,
      this.appError});

  @override
  final UserFlowEnums userFlow;
  @override
  final String? message;
  @override
  final PlatformErrorEnum? platformError;
  @override
  final AppErrorEnum? appError;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure._(userFlow: $userFlow, message: $message, platformError: $platformError, appError: $appError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure._'))
      ..add(DiagnosticsProperty('userFlow', userFlow))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('platformError', platformError))
      ..add(DiagnosticsProperty('appError', appError));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.userFlow, userFlow) ||
                other.userFlow == userFlow) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.platformError, platformError) ||
                other.platformError == platformError) &&
            (identical(other.appError, appError) ||
                other.appError == appError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userFlow, message, platformError, appError);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);
}

abstract class _Failure implements Failure {
  factory _Failure(
      {required final UserFlowEnums userFlow,
      final String? message,
      final PlatformErrorEnum? platformError,
      final AppErrorEnum? appError}) = _$FailureImpl;

  @override
  UserFlowEnums get userFlow;
  @override
  String? get message;
  @override
  PlatformErrorEnum? get platformError;
  @override
  AppErrorEnum? get appError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
