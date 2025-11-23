// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'login_bloc.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState(
      {LoginFlow? loginFlow,
      @Default([]) List<Condition> conditions,
      @Default(false) bool isLoading,
      String? message}) = _LoginState;
}
