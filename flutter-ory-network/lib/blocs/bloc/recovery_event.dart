// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'recovery_bloc.dart';

@immutable
sealed class RecoveryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateRecoveryFlow extends RecoveryEvent {}

class GetRecoveryFlow extends RecoveryEvent {
  final String flowId;
  GetRecoveryFlow({required this.flowId});
  @override
  List<Object> get props => [flowId];
}

class UpdateRecoveryFlow extends RecoveryEvent {
  final UiNodeGroupEnum group;
  final String name;
  final String value;

  UpdateRecoveryFlow(
      {required this.group, required this.name, required this.value});
  @override
  List<Object> get props => [group, name, value];
}

class ChangeNodeValue extends RecoveryEvent {
  final String value;
  final String name;

  ChangeNodeValue({required this.value, required this.name});
  @override
  List<Object> get props => [value, name];
}
