// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomException<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomExceptionCopyWith<T, $Res> {
  factory $CustomExceptionCopyWith(
          CustomException<T> value, $Res Function(CustomException<T>) then) =
      _$CustomExceptionCopyWithImpl<T, $Res, CustomException<T>>;
}

/// @nodoc
class _$CustomExceptionCopyWithImpl<T, $Res, $Val extends CustomException<T>>
    implements $CustomExceptionCopyWith<T, $Res> {
  _$CustomExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SessionRefreshRequiredExceptionImplCopyWith<T, $Res> {
  factory _$$SessionRefreshRequiredExceptionImplCopyWith(
          _$SessionRefreshRequiredExceptionImpl<T> value,
          $Res Function(_$SessionRefreshRequiredExceptionImpl<T>) then) =
      __$$SessionRefreshRequiredExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SessionRefreshRequiredExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$SessionRefreshRequiredExceptionImpl<T>>
    implements _$$SessionRefreshRequiredExceptionImplCopyWith<T, $Res> {
  __$$SessionRefreshRequiredExceptionImplCopyWithImpl(
      _$SessionRefreshRequiredExceptionImpl<T> _value,
      $Res Function(_$SessionRefreshRequiredExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$SessionRefreshRequiredExceptionImpl<T>(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SessionRefreshRequiredExceptionImpl<T>
    extends SessionRefreshRequiredException<T> with DiagnosticableTreeMixin {
  const _$SessionRefreshRequiredExceptionImpl({this.message}) : super._();

  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.sessionRefreshRequired(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CustomException<$T>.sessionRefreshRequired'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRefreshRequiredExceptionImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRefreshRequiredExceptionImplCopyWith<T,
          _$SessionRefreshRequiredExceptionImpl<T>>
      get copyWith => __$$SessionRefreshRequiredExceptionImplCopyWithImpl<T,
          _$SessionRefreshRequiredExceptionImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return sessionRefreshRequired(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return sessionRefreshRequired?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (sessionRefreshRequired != null) {
      return sessionRefreshRequired(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return sessionRefreshRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return sessionRefreshRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (sessionRefreshRequired != null) {
      return sessionRefreshRequired(this);
    }
    return orElse();
  }
}

abstract class SessionRefreshRequiredException<T> extends CustomException<T> {
  const factory SessionRefreshRequiredException({final String? message}) =
      _$SessionRefreshRequiredExceptionImpl<T>;
  const SessionRefreshRequiredException._() : super._();

  String? get message;
  @JsonKey(ignore: true)
  _$$SessionRefreshRequiredExceptionImplCopyWith<T,
          _$SessionRefreshRequiredExceptionImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BadRequestExceptionImplCopyWith<T, $Res> {
  factory _$$BadRequestExceptionImplCopyWith(_$BadRequestExceptionImpl<T> value,
          $Res Function(_$BadRequestExceptionImpl<T>) then) =
      __$$BadRequestExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T flow});
}

/// @nodoc
class __$$BadRequestExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res, _$BadRequestExceptionImpl<T>>
    implements _$$BadRequestExceptionImplCopyWith<T, $Res> {
  __$$BadRequestExceptionImplCopyWithImpl(_$BadRequestExceptionImpl<T> _value,
      $Res Function(_$BadRequestExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flow = freezed,
  }) {
    return _then(_$BadRequestExceptionImpl<T>(
      flow: freezed == flow
          ? _value.flow
          : flow // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$BadRequestExceptionImpl<T> extends BadRequestException<T>
    with DiagnosticableTreeMixin {
  const _$BadRequestExceptionImpl({required this.flow}) : super._();

  @override
  final T flow;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.badRequest(flow: $flow)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomException<$T>.badRequest'))
      ..add(DiagnosticsProperty('flow', flow));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadRequestExceptionImpl<T> &&
            const DeepCollectionEquality().equals(other.flow, flow));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(flow));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadRequestExceptionImplCopyWith<T, _$BadRequestExceptionImpl<T>>
      get copyWith => __$$BadRequestExceptionImplCopyWithImpl<T,
          _$BadRequestExceptionImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return badRequest(flow);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return badRequest?.call(flow);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(flow);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return badRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return badRequest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(this);
    }
    return orElse();
  }
}

abstract class BadRequestException<T> extends CustomException<T> {
  const factory BadRequestException({required final T flow}) =
      _$BadRequestExceptionImpl<T>;
  const BadRequestException._() : super._();

  T get flow;
  @JsonKey(ignore: true)
  _$$BadRequestExceptionImplCopyWith<T, _$BadRequestExceptionImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedExceptionImplCopyWith<T, $Res> {
  factory _$$UnauthorizedExceptionImplCopyWith(
          _$UnauthorizedExceptionImpl<T> value,
          $Res Function(_$UnauthorizedExceptionImpl<T>) then) =
      __$$UnauthorizedExceptionImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UnauthorizedExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$UnauthorizedExceptionImpl<T>>
    implements _$$UnauthorizedExceptionImplCopyWith<T, $Res> {
  __$$UnauthorizedExceptionImplCopyWithImpl(
      _$UnauthorizedExceptionImpl<T> _value,
      $Res Function(_$UnauthorizedExceptionImpl<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnauthorizedExceptionImpl<T> extends UnauthorizedException<T>
    with DiagnosticableTreeMixin {
  const _$UnauthorizedExceptionImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.unauthorized()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'CustomException<$T>.unauthorized'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedExceptionImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedException<T> extends CustomException<T> {
  const factory UnauthorizedException() = _$UnauthorizedExceptionImpl<T>;
  const UnauthorizedException._() : super._();
}

/// @nodoc
abstract class _$$FlowExpiredExceptionImplCopyWith<T, $Res> {
  factory _$$FlowExpiredExceptionImplCopyWith(
          _$FlowExpiredExceptionImpl<T> value,
          $Res Function(_$FlowExpiredExceptionImpl<T>) then) =
      __$$FlowExpiredExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String flowId, String? message});
}

/// @nodoc
class __$$FlowExpiredExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$FlowExpiredExceptionImpl<T>>
    implements _$$FlowExpiredExceptionImplCopyWith<T, $Res> {
  __$$FlowExpiredExceptionImplCopyWithImpl(_$FlowExpiredExceptionImpl<T> _value,
      $Res Function(_$FlowExpiredExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flowId = null,
    Object? message = freezed,
  }) {
    return _then(_$FlowExpiredExceptionImpl<T>(
      flowId: null == flowId
          ? _value.flowId
          : flowId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FlowExpiredExceptionImpl<T> extends FlowExpiredException<T>
    with DiagnosticableTreeMixin {
  const _$FlowExpiredExceptionImpl({required this.flowId, this.message})
      : super._();

  @override
  final String flowId;
  @override
  final String? message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.flowExpired(flowId: $flowId, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomException<$T>.flowExpired'))
      ..add(DiagnosticsProperty('flowId', flowId))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlowExpiredExceptionImpl<T> &&
            (identical(other.flowId, flowId) || other.flowId == flowId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, flowId, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FlowExpiredExceptionImplCopyWith<T, _$FlowExpiredExceptionImpl<T>>
      get copyWith => __$$FlowExpiredExceptionImplCopyWithImpl<T,
          _$FlowExpiredExceptionImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return flowExpired(flowId, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return flowExpired?.call(flowId, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (flowExpired != null) {
      return flowExpired(flowId, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return flowExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return flowExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (flowExpired != null) {
      return flowExpired(this);
    }
    return orElse();
  }
}

abstract class FlowExpiredException<T> extends CustomException<T> {
  const factory FlowExpiredException(
      {required final String flowId,
      final String? message}) = _$FlowExpiredExceptionImpl<T>;
  const FlowExpiredException._() : super._();

  String get flowId;
  String? get message;
  @JsonKey(ignore: true)
  _$$FlowExpiredExceptionImplCopyWith<T, _$FlowExpiredExceptionImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TwoFactorAuthRequiredExceptionImplCopyWith<T, $Res> {
  factory _$$TwoFactorAuthRequiredExceptionImplCopyWith(
          _$TwoFactorAuthRequiredExceptionImpl<T> value,
          $Res Function(_$TwoFactorAuthRequiredExceptionImpl<T>) then) =
      __$$TwoFactorAuthRequiredExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Session? session});
}

/// @nodoc
class __$$TwoFactorAuthRequiredExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$TwoFactorAuthRequiredExceptionImpl<T>>
    implements _$$TwoFactorAuthRequiredExceptionImplCopyWith<T, $Res> {
  __$$TwoFactorAuthRequiredExceptionImplCopyWithImpl(
      _$TwoFactorAuthRequiredExceptionImpl<T> _value,
      $Res Function(_$TwoFactorAuthRequiredExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = freezed,
  }) {
    return _then(_$TwoFactorAuthRequiredExceptionImpl<T>(
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as Session?,
    ));
  }
}

/// @nodoc

class _$TwoFactorAuthRequiredExceptionImpl<T>
    extends TwoFactorAuthRequiredException<T> with DiagnosticableTreeMixin {
  const _$TwoFactorAuthRequiredExceptionImpl({this.session}) : super._();

  @override
  final Session? session;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.twoFactorAuthRequired(session: $session)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CustomException<$T>.twoFactorAuthRequired'))
      ..add(DiagnosticsProperty('session', session));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TwoFactorAuthRequiredExceptionImpl<T> &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TwoFactorAuthRequiredExceptionImplCopyWith<T,
          _$TwoFactorAuthRequiredExceptionImpl<T>>
      get copyWith => __$$TwoFactorAuthRequiredExceptionImplCopyWithImpl<T,
          _$TwoFactorAuthRequiredExceptionImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return twoFactorAuthRequired(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return twoFactorAuthRequired?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (twoFactorAuthRequired != null) {
      return twoFactorAuthRequired(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return twoFactorAuthRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return twoFactorAuthRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (twoFactorAuthRequired != null) {
      return twoFactorAuthRequired(this);
    }
    return orElse();
  }
}

abstract class TwoFactorAuthRequiredException<T> extends CustomException<T> {
  const factory TwoFactorAuthRequiredException({final Session? session}) =
      _$TwoFactorAuthRequiredExceptionImpl<T>;
  const TwoFactorAuthRequiredException._() : super._();

  Session? get session;
  @JsonKey(ignore: true)
  _$$TwoFactorAuthRequiredExceptionImplCopyWith<T,
          _$TwoFactorAuthRequiredExceptionImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationChangeRequiredExceptionImplCopyWith<T, $Res> {
  factory _$$LocationChangeRequiredExceptionImplCopyWith(
          _$LocationChangeRequiredExceptionImpl<T> value,
          $Res Function(_$LocationChangeRequiredExceptionImpl<T>) then) =
      __$$LocationChangeRequiredExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String url});
}

/// @nodoc
class __$$LocationChangeRequiredExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$LocationChangeRequiredExceptionImpl<T>>
    implements _$$LocationChangeRequiredExceptionImplCopyWith<T, $Res> {
  __$$LocationChangeRequiredExceptionImplCopyWithImpl(
      _$LocationChangeRequiredExceptionImpl<T> _value,
      $Res Function(_$LocationChangeRequiredExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
  }) {
    return _then(_$LocationChangeRequiredExceptionImpl<T>(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationChangeRequiredExceptionImpl<T>
    extends LocationChangeRequiredException<T> with DiagnosticableTreeMixin {
  const _$LocationChangeRequiredExceptionImpl({required this.url}) : super._();

  @override
  final String url;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.locationChangeRequired(url: $url)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CustomException<$T>.locationChangeRequired'))
      ..add(DiagnosticsProperty('url', url));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationChangeRequiredExceptionImpl<T> &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationChangeRequiredExceptionImplCopyWith<T,
          _$LocationChangeRequiredExceptionImpl<T>>
      get copyWith => __$$LocationChangeRequiredExceptionImplCopyWithImpl<T,
          _$LocationChangeRequiredExceptionImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return locationChangeRequired(url);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return locationChangeRequired?.call(url);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (locationChangeRequired != null) {
      return locationChangeRequired(url);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return locationChangeRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return locationChangeRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (locationChangeRequired != null) {
      return locationChangeRequired(this);
    }
    return orElse();
  }
}

abstract class LocationChangeRequiredException<T> extends CustomException<T> {
  const factory LocationChangeRequiredException({required final String url}) =
      _$LocationChangeRequiredExceptionImpl<T>;
  const LocationChangeRequiredException._() : super._();

  String get url;
  @JsonKey(ignore: true)
  _$$LocationChangeRequiredExceptionImplCopyWith<T,
          _$LocationChangeRequiredExceptionImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$settingsRedirectRequiredImplCopyWith<T, $Res> {
  factory _$$settingsRedirectRequiredImplCopyWith(
          _$settingsRedirectRequiredImpl<T> value,
          $Res Function(_$settingsRedirectRequiredImpl<T>) then) =
      __$$settingsRedirectRequiredImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String? settingsFlowId});
}

/// @nodoc
class __$$settingsRedirectRequiredImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res,
        _$settingsRedirectRequiredImpl<T>>
    implements _$$settingsRedirectRequiredImplCopyWith<T, $Res> {
  __$$settingsRedirectRequiredImplCopyWithImpl(
      _$settingsRedirectRequiredImpl<T> _value,
      $Res Function(_$settingsRedirectRequiredImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settingsFlowId = freezed,
  }) {
    return _then(_$settingsRedirectRequiredImpl<T>(
      settingsFlowId: freezed == settingsFlowId
          ? _value.settingsFlowId
          : settingsFlowId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$settingsRedirectRequiredImpl<T> extends settingsRedirectRequired<T>
    with DiagnosticableTreeMixin {
  const _$settingsRedirectRequiredImpl({this.settingsFlowId}) : super._();

  @override
  final String? settingsFlowId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.settingsRedirectRequired(settingsFlowId: $settingsFlowId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CustomException<$T>.settingsRedirectRequired'))
      ..add(DiagnosticsProperty('settingsFlowId', settingsFlowId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$settingsRedirectRequiredImpl<T> &&
            (identical(other.settingsFlowId, settingsFlowId) ||
                other.settingsFlowId == settingsFlowId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, settingsFlowId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$settingsRedirectRequiredImplCopyWith<T, _$settingsRedirectRequiredImpl<T>>
      get copyWith => __$$settingsRedirectRequiredImplCopyWithImpl<T,
          _$settingsRedirectRequiredImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return settingsRedirectRequired(settingsFlowId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return settingsRedirectRequired?.call(settingsFlowId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (settingsRedirectRequired != null) {
      return settingsRedirectRequired(settingsFlowId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return settingsRedirectRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return settingsRedirectRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (settingsRedirectRequired != null) {
      return settingsRedirectRequired(this);
    }
    return orElse();
  }
}

abstract class settingsRedirectRequired<T> extends CustomException<T> {
  const factory settingsRedirectRequired({final String? settingsFlowId}) =
      _$settingsRedirectRequiredImpl<T>;
  const settingsRedirectRequired._() : super._();

  String? get settingsFlowId;
  @JsonKey(ignore: true)
  _$$settingsRedirectRequiredImplCopyWith<T, _$settingsRedirectRequiredImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownExceptionImplCopyWith<T, $Res> {
  factory _$$UnknownExceptionImplCopyWith(_$UnknownExceptionImpl<T> value,
          $Res Function(_$UnknownExceptionImpl<T>) then) =
      __$$UnknownExceptionImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownExceptionImplCopyWithImpl<T, $Res>
    extends _$CustomExceptionCopyWithImpl<T, $Res, _$UnknownExceptionImpl<T>>
    implements _$$UnknownExceptionImplCopyWith<T, $Res> {
  __$$UnknownExceptionImplCopyWithImpl(_$UnknownExceptionImpl<T> _value,
      $Res Function(_$UnknownExceptionImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UnknownExceptionImpl<T>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UnknownExceptionImpl<T> extends UnknownException<T>
    with DiagnosticableTreeMixin {
  const _$UnknownExceptionImpl(
      {this.message = 'An error occured. Please try again later.'})
      : super._();

  @override
  @JsonKey()
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CustomException<$T>.unknown(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CustomException<$T>.unknown'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownExceptionImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownExceptionImplCopyWith<T, _$UnknownExceptionImpl<T>> get copyWith =>
      __$$UnknownExceptionImplCopyWithImpl<T, _$UnknownExceptionImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? message) sessionRefreshRequired,
    required TResult Function(T flow) badRequest,
    required TResult Function() unauthorized,
    required TResult Function(String flowId, String? message) flowExpired,
    required TResult Function(Session? session) twoFactorAuthRequired,
    required TResult Function(String url) locationChangeRequired,
    required TResult Function(String? settingsFlowId) settingsRedirectRequired,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String? message)? sessionRefreshRequired,
    TResult? Function(T flow)? badRequest,
    TResult? Function()? unauthorized,
    TResult? Function(String flowId, String? message)? flowExpired,
    TResult? Function(Session? session)? twoFactorAuthRequired,
    TResult? Function(String url)? locationChangeRequired,
    TResult? Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? message)? sessionRefreshRequired,
    TResult Function(T flow)? badRequest,
    TResult Function()? unauthorized,
    TResult Function(String flowId, String? message)? flowExpired,
    TResult Function(Session? session)? twoFactorAuthRequired,
    TResult Function(String url)? locationChangeRequired,
    TResult Function(String? settingsFlowId)? settingsRedirectRequired,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionRefreshRequiredException<T> value)
        sessionRefreshRequired,
    required TResult Function(BadRequestException<T> value) badRequest,
    required TResult Function(UnauthorizedException<T> value) unauthorized,
    required TResult Function(FlowExpiredException<T> value) flowExpired,
    required TResult Function(TwoFactorAuthRequiredException<T> value)
        twoFactorAuthRequired,
    required TResult Function(LocationChangeRequiredException<T> value)
        locationChangeRequired,
    required TResult Function(settingsRedirectRequired<T> value)
        settingsRedirectRequired,
    required TResult Function(UnknownException<T> value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult? Function(BadRequestException<T> value)? badRequest,
    TResult? Function(UnauthorizedException<T> value)? unauthorized,
    TResult? Function(FlowExpiredException<T> value)? flowExpired,
    TResult? Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult? Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult? Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult? Function(UnknownException<T> value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionRefreshRequiredException<T> value)?
        sessionRefreshRequired,
    TResult Function(BadRequestException<T> value)? badRequest,
    TResult Function(UnauthorizedException<T> value)? unauthorized,
    TResult Function(FlowExpiredException<T> value)? flowExpired,
    TResult Function(TwoFactorAuthRequiredException<T> value)?
        twoFactorAuthRequired,
    TResult Function(LocationChangeRequiredException<T> value)?
        locationChangeRequired,
    TResult Function(settingsRedirectRequired<T> value)?
        settingsRedirectRequired,
    TResult Function(UnknownException<T> value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownException<T> extends CustomException<T> {
  const factory UnknownException({final String message}) =
      _$UnknownExceptionImpl<T>;
  const UnknownException._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$UnknownExceptionImplCopyWith<T, _$UnknownExceptionImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
