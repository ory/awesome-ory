// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  List<Condition> get conditions => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call(
      {AuthStatus status,
      List<Condition> conditions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conditions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUninitializedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthUninitializedImplCopyWith(_$AuthUninitializedImpl value,
          $Res Function(_$AuthUninitializedImpl) then) =
      __$$AuthUninitializedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      List<Condition> conditions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$AuthUninitializedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUninitializedImpl>
    implements _$$AuthUninitializedImplCopyWith<$Res> {
  __$$AuthUninitializedImplCopyWithImpl(_$AuthUninitializedImpl _value,
      $Res Function(_$AuthUninitializedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conditions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthUninitializedImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthUninitializedImpl implements AuthUninitialized {
  const _$AuthUninitializedImpl(
      {this.status = AuthStatus.uninitialized,
      final List<Condition> conditions = const [],
      this.isLoading = false,
      this.errorMessage})
      : _conditions = conditions;

  @override
  @JsonKey()
  final AuthStatus status;
  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.uninitialized(status: $status, conditions: $conditions, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUninitializedImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_conditions),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUninitializedImplCopyWith<_$AuthUninitializedImpl> get copyWith =>
      __$$AuthUninitializedImplCopyWithImpl<_$AuthUninitializedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) {
    return uninitialized(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) {
    return uninitialized?.call(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized(status, conditions, isLoading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) {
    return uninitialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) {
    return uninitialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) {
    if (uninitialized != null) {
      return uninitialized(this);
    }
    return orElse();
  }
}

abstract class AuthUninitialized implements AuthState {
  const factory AuthUninitialized(
      {final AuthStatus status,
      final List<Condition> conditions,
      final bool isLoading,
      final String? errorMessage}) = _$AuthUninitializedImpl;

  @override
  AuthStatus get status;
  @override
  List<Condition> get conditions;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthUninitializedImplCopyWith<_$AuthUninitializedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthUnauthenticatedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthUnauthenticatedImplCopyWith(_$AuthUnauthenticatedImpl value,
          $Res Function(_$AuthUnauthenticatedImpl) then) =
      __$$AuthUnauthenticatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      List<Condition> conditions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$AuthUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthenticatedImpl>
    implements _$$AuthUnauthenticatedImplCopyWith<$Res> {
  __$$AuthUnauthenticatedImplCopyWithImpl(_$AuthUnauthenticatedImpl _value,
      $Res Function(_$AuthUnauthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conditions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthUnauthenticatedImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthUnauthenticatedImpl implements AuthUnauthenticated {
  const _$AuthUnauthenticatedImpl(
      {this.status = AuthStatus.unauthenticated,
      final List<Condition> conditions = const [],
      this.isLoading = false,
      this.errorMessage})
      : _conditions = conditions;

  @override
  @JsonKey()
  final AuthStatus status;
  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.unauthenticated(status: $status, conditions: $conditions, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthenticatedImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_conditions),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      __$$AuthUnauthenticatedImplCopyWithImpl<_$AuthUnauthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) {
    return unauthenticated(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) {
    return unauthenticated?.call(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(status, conditions, isLoading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated implements AuthState {
  const factory AuthUnauthenticated(
      {final AuthStatus status,
      final List<Condition> conditions,
      final bool isLoading,
      final String? errorMessage}) = _$AuthUnauthenticatedImpl;

  @override
  AuthStatus get status;
  @override
  List<Condition> get conditions;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(_$AuthAuthenticatedImpl value,
          $Res Function(_$AuthAuthenticatedImpl) then) =
      __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      Session session,
      List<Condition> conditions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(_$AuthAuthenticatedImpl _value,
      $Res Function(_$AuthAuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? session = null,
    Object? conditions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthAuthenticatedImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as Session,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl(
      {this.status = AuthStatus.authenticated,
      required this.session,
      final List<Condition> conditions = const [],
      this.isLoading = false,
      this.errorMessage})
      : _conditions = conditions;

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final Session session;
  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.authenticated(status: $status, session: $session, conditions: $conditions, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.session, session) || other.session == session) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      session,
      const DeepCollectionEquality().hash(_conditions),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) {
    return authenticated(status, session, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) {
    return authenticated?.call(
        status, session, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(
          status, session, conditions, isLoading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated(
      {final AuthStatus status,
      required final Session session,
      final List<Condition> conditions,
      final bool isLoading,
      final String? errorMessage}) = _$AuthAuthenticatedImpl;

  @override
  AuthStatus get status;
  Session get session;
  @override
  List<Condition> get conditions;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Aal2RequestedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$Aal2RequestedImplCopyWith(
          _$Aal2RequestedImpl value, $Res Function(_$Aal2RequestedImpl) then) =
      __$$Aal2RequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      List<Condition> conditions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$Aal2RequestedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$Aal2RequestedImpl>
    implements _$$Aal2RequestedImplCopyWith<$Res> {
  __$$Aal2RequestedImplCopyWithImpl(
      _$Aal2RequestedImpl _value, $Res Function(_$Aal2RequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conditions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$Aal2RequestedImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$Aal2RequestedImpl implements Aal2Requested {
  const _$Aal2RequestedImpl(
      {this.status = AuthStatus.aal2Requested,
      final List<Condition> conditions = const [],
      this.isLoading = false,
      this.errorMessage})
      : _conditions = conditions;

  @override
  @JsonKey()
  final AuthStatus status;
  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.aal2Requested(status: $status, conditions: $conditions, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Aal2RequestedImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_conditions),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Aal2RequestedImplCopyWith<_$Aal2RequestedImpl> get copyWith =>
      __$$Aal2RequestedImplCopyWithImpl<_$Aal2RequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) {
    return aal2Requested(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) {
    return aal2Requested?.call(status, conditions, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) {
    if (aal2Requested != null) {
      return aal2Requested(status, conditions, isLoading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) {
    return aal2Requested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) {
    return aal2Requested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) {
    if (aal2Requested != null) {
      return aal2Requested(this);
    }
    return orElse();
  }
}

abstract class Aal2Requested implements AuthState {
  const factory Aal2Requested(
      {final AuthStatus status,
      final List<Condition> conditions,
      final bool isLoading,
      final String? errorMessage}) = _$Aal2RequestedImpl;

  @override
  AuthStatus get status;
  @override
  List<Condition> get conditions;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$Aal2RequestedImplCopyWith<_$Aal2RequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationChangeRequiredImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$LocationChangeRequiredImplCopyWith(
          _$LocationChangeRequiredImpl value,
          $Res Function(_$LocationChangeRequiredImpl) then) =
      __$$LocationChangeRequiredImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthStatus status,
      List<Condition> conditions,
      String url,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$LocationChangeRequiredImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LocationChangeRequiredImpl>
    implements _$$LocationChangeRequiredImplCopyWith<$Res> {
  __$$LocationChangeRequiredImplCopyWithImpl(
      _$LocationChangeRequiredImpl _value,
      $Res Function(_$LocationChangeRequiredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conditions = null,
    Object? url = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$LocationChangeRequiredImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as List<Condition>,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LocationChangeRequiredImpl implements LocationChangeRequired {
  const _$LocationChangeRequiredImpl(
      {this.status = AuthStatus.locationChangeRequired,
      final List<Condition> conditions = const [],
      required this.url,
      this.isLoading = false,
      this.errorMessage})
      : _conditions = conditions;

  @override
  @JsonKey()
  final AuthStatus status;
  final List<Condition> _conditions;
  @override
  @JsonKey()
  List<Condition> get conditions {
    if (_conditions is EqualUnmodifiableListView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditions);
  }

  @override
  final String url;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.locationChangeRequired(status: $status, conditions: $conditions, url: $url, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationChangeRequiredImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_conditions),
      url,
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationChangeRequiredImplCopyWith<_$LocationChangeRequiredImpl>
      get copyWith => __$$LocationChangeRequiredImplCopyWithImpl<
          _$LocationChangeRequiredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        uninitialized,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        unauthenticated,
    required TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)
        authenticated,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)
        aal2Requested,
    required TResult Function(AuthStatus status, List<Condition> conditions,
            String url, bool isLoading, String? errorMessage)
        locationChangeRequired,
  }) {
    return locationChangeRequired(
        status, conditions, url, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult? Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult? Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
  }) {
    return locationChangeRequired?.call(
        status, conditions, url, isLoading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        uninitialized,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        unauthenticated,
    TResult Function(AuthStatus status, Session session,
            List<Condition> conditions, bool isLoading, String? errorMessage)?
        authenticated,
    TResult Function(AuthStatus status, List<Condition> conditions,
            bool isLoading, String? errorMessage)?
        aal2Requested,
    TResult Function(AuthStatus status, List<Condition> conditions, String url,
            bool isLoading, String? errorMessage)?
        locationChangeRequired,
    required TResult orElse(),
  }) {
    if (locationChangeRequired != null) {
      return locationChangeRequired(
          status, conditions, url, isLoading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUninitialized value) uninitialized,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(Aal2Requested value) aal2Requested,
    required TResult Function(LocationChangeRequired value)
        locationChangeRequired,
  }) {
    return locationChangeRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUninitialized value)? uninitialized,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(Aal2Requested value)? aal2Requested,
    TResult? Function(LocationChangeRequired value)? locationChangeRequired,
  }) {
    return locationChangeRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUninitialized value)? uninitialized,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(Aal2Requested value)? aal2Requested,
    TResult Function(LocationChangeRequired value)? locationChangeRequired,
    required TResult orElse(),
  }) {
    if (locationChangeRequired != null) {
      return locationChangeRequired(this);
    }
    return orElse();
  }
}

abstract class LocationChangeRequired implements AuthState {
  const factory LocationChangeRequired(
      {final AuthStatus status,
      final List<Condition> conditions,
      required final String url,
      final bool isLoading,
      final String? errorMessage}) = _$LocationChangeRequiredImpl;

  @override
  AuthStatus get status;
  @override
  List<Condition> get conditions;
  String get url;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$LocationChangeRequiredImplCopyWith<_$LocationChangeRequiredImpl>
      get copyWith => throw _privateConstructorUsedError;
}
