// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ChangeAuthStatus extends AuthEvent {
  final AuthStatus status;
  final List<Condition> conditions;
  final Session? session;

  ChangeAuthStatus(
      {required this.status, this.session, this.conditions = const []});
  @override
  List<Object?> get props => [status, session, conditions];
}

final class GetCurrentSessionInformation extends AuthEvent {
  final List<Condition> conditions;

  GetCurrentSessionInformation({this.conditions = const []});

  @override
  List<Object?> get props => [conditions];
}

final class RequireLocationChange extends AuthEvent {
  final String url;

  RequireLocationChange({required this.url});
  @override
  List<Object> get props => [url];
}

final class AddSession extends AuthEvent {
  final Session session;
  final List<Condition> conditions;

  AddSession({required this.session, this.conditions = const []});
  @override
  List<Object> get props => [session, conditions];
}

final class LogOut extends AuthEvent {}
