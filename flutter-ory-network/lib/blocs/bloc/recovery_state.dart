// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'recovery_bloc.dart';

@freezed
sealed class RecoveryState with _$RecoveryState {
  const factory RecoveryState(
      {RecoveryFlow? recoveryFlow,
      @Default(false) isLoading,
      String? settingsFlowId,
      String? message}) = _RecoveryState;
}
