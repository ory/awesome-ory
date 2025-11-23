// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recovery_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecoveryState {
  RecoveryFlow? get recoveryFlow => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;
  String? get settingsFlowId => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecoveryStateCopyWith<RecoveryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecoveryStateCopyWith<$Res> {
  factory $RecoveryStateCopyWith(
          RecoveryState value, $Res Function(RecoveryState) then) =
      _$RecoveryStateCopyWithImpl<$Res, RecoveryState>;
  @useResult
  $Res call(
      {RecoveryFlow? recoveryFlow,
      dynamic isLoading,
      String? settingsFlowId,
      String? message});
}

/// @nodoc
class _$RecoveryStateCopyWithImpl<$Res, $Val extends RecoveryState>
    implements $RecoveryStateCopyWith<$Res> {
  _$RecoveryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recoveryFlow = freezed,
    Object? isLoading = freezed,
    Object? settingsFlowId = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      recoveryFlow: freezed == recoveryFlow
          ? _value.recoveryFlow
          : recoveryFlow // ignore: cast_nullable_to_non_nullable
              as RecoveryFlow?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      settingsFlowId: freezed == settingsFlowId
          ? _value.settingsFlowId
          : settingsFlowId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecoveryStateImplCopyWith<$Res>
    implements $RecoveryStateCopyWith<$Res> {
  factory _$$RecoveryStateImplCopyWith(
          _$RecoveryStateImpl value, $Res Function(_$RecoveryStateImpl) then) =
      __$$RecoveryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecoveryFlow? recoveryFlow,
      dynamic isLoading,
      String? settingsFlowId,
      String? message});
}

/// @nodoc
class __$$RecoveryStateImplCopyWithImpl<$Res>
    extends _$RecoveryStateCopyWithImpl<$Res, _$RecoveryStateImpl>
    implements _$$RecoveryStateImplCopyWith<$Res> {
  __$$RecoveryStateImplCopyWithImpl(
      _$RecoveryStateImpl _value, $Res Function(_$RecoveryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recoveryFlow = freezed,
    Object? isLoading = freezed,
    Object? settingsFlowId = freezed,
    Object? message = freezed,
  }) {
    return _then(_$RecoveryStateImpl(
      recoveryFlow: freezed == recoveryFlow
          ? _value.recoveryFlow
          : recoveryFlow // ignore: cast_nullable_to_non_nullable
              as RecoveryFlow?,
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
      settingsFlowId: freezed == settingsFlowId
          ? _value.settingsFlowId
          : settingsFlowId // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RecoveryStateImpl implements _RecoveryState {
  const _$RecoveryStateImpl(
      {this.recoveryFlow,
      this.isLoading = false,
      this.settingsFlowId,
      this.message});

  @override
  final RecoveryFlow? recoveryFlow;
  @override
  @JsonKey()
  final dynamic isLoading;
  @override
  final String? settingsFlowId;
  @override
  final String? message;

  @override
  String toString() {
    return 'RecoveryState(recoveryFlow: $recoveryFlow, isLoading: $isLoading, settingsFlowId: $settingsFlowId, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecoveryStateImpl &&
            (identical(other.recoveryFlow, recoveryFlow) ||
                other.recoveryFlow == recoveryFlow) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            (identical(other.settingsFlowId, settingsFlowId) ||
                other.settingsFlowId == settingsFlowId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recoveryFlow,
      const DeepCollectionEquality().hash(isLoading), settingsFlowId, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecoveryStateImplCopyWith<_$RecoveryStateImpl> get copyWith =>
      __$$RecoveryStateImplCopyWithImpl<_$RecoveryStateImpl>(this, _$identity);
}

abstract class _RecoveryState implements RecoveryState {
  const factory _RecoveryState(
      {final RecoveryFlow? recoveryFlow,
      final dynamic isLoading,
      final String? settingsFlowId,
      final String? message}) = _$RecoveryStateImpl;

  @override
  RecoveryFlow? get recoveryFlow;
  @override
  dynamic get isLoading;
  @override
  String? get settingsFlowId;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$RecoveryStateImplCopyWith<_$RecoveryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
