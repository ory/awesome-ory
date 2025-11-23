// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'settings_bloc.dart';

@freezed
sealed class SettingsState with _$SettingsState {
  const factory SettingsState(
      {SettingsFlow? settingsFlow,
      @Default(false) bool isLoading,
      @Default([]) List<Condition> conditions,
      String? message}) = _SettingsState;
}
