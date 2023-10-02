// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CreateLoginFlow extends LoginEvent {
  final String aal;

  CreateLoginFlow({required this.aal});
  @override
  List<Object> get props => [aal];
}

class ChangeNodeValue extends LoginEvent {
  final String value;
  final String name;

  ChangeNodeValue({required this.value, required this.name});
  @override
  List<Object> get props => [value, name];
}

class GetLoginFlow extends LoginEvent {
  final String flowId;

  GetLoginFlow({required this.flowId});
  @override
  List<Object> get props => [flowId];
}

class UpdateLoginFlow extends LoginEvent {
  final UiNodeGroupEnum group;
  final String name;
  final String value;

  UpdateLoginFlow(
      {required this.group, required this.name, required this.value});
  @override
  List<Object> get props => [group, name, value];
}
