// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.uninitialized(
      {@Default(AuthStatus.uninitialized) final AuthStatus status,
      @Default([]) List<Condition> conditions,
      @Default(false) bool isLoading,
      String? errorMessage}) = AuthUninitialized;
  const factory AuthState.unauthenticated(
      {@Default(AuthStatus.unauthenticated) final AuthStatus status,
      @Default([]) List<Condition> conditions,
      @Default(false) bool isLoading,
      String? errorMessage}) = AuthUnauthenticated;
  const factory AuthState.authenticated(
      {@Default(AuthStatus.authenticated) final AuthStatus status,
      required Session session,
      @Default([]) List<Condition> conditions,
      @Default(false) bool isLoading,
      String? errorMessage}) = AuthAuthenticated;
  const factory AuthState.aal2Requested(
      {@Default(AuthStatus.aal2Requested) final AuthStatus status,
      @Default([]) List<Condition> conditions,
      @Default(false) bool isLoading,
      String? errorMessage}) = Aal2Requested;

  const factory AuthState.locationChangeRequired(
      {@Default(AuthStatus.locationChangeRequired) final AuthStatus status,
      @Default([]) List<Condition> conditions,
      required String url,
      @Default(false) bool isLoading,
      String? errorMessage}) = LocationChangeRequired;
}

class Condition {}

class RecoveryRequested extends Condition {
  final String settingsFlowId;

  RecoveryRequested({required this.settingsFlowId});
}

class SessionRefreshRequested extends Condition {}
