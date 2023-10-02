// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class ChangeAuthStatus extends AuthEvent {
  final AuthStatus status;

  ChangeAuthStatus({required this.status});
  @override
  List<Object> get props => [status];
}

final class GetCurrentSessionInformation extends AuthEvent {}

final class LogOut extends AuthEvent {}
