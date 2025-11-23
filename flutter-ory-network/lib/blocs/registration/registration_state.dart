// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'registration_bloc.dart';

@freezed
sealed class RegistrationState with _$RegistrationState {
  const factory RegistrationState(
      {RegistrationFlow? registrationFlow,
      @Default(false) bool isLoading,
      String? message}) = _RegistrationState;
}
