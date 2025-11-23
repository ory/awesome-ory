// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CreateSettingsFlow extends SettingsEvent {}

final class GetSettingsFlow extends SettingsEvent {
  final String flowId;

  GetSettingsFlow({required this.flowId});
  @override
  List<Object> get props => [flowId];
}

class ChangeSettingsNodeValue extends SettingsEvent {
  final String value;
  final String name;

  ChangeSettingsNodeValue({required this.value, required this.name});
  @override
  List<Object> get props => [value, name];
}

class ResetSettings extends SettingsEvent {}

class UpdateSettingsFlow extends SettingsEvent {
  final UiNodeGroupEnum group;

  UpdateSettingsFlow({required this.group});
  @override
  List<Object> get props => [group];
}
