// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

part of 'registration_bloc.dart';

@immutable
sealed class RegistrationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CreateRegistrationFlow extends RegistrationEvent {}

final class GetRegistrationFlow extends RegistrationEvent {
  final String flowId;

  GetRegistrationFlow({required this.flowId});
  @override
  List<Object> get props => [flowId];
}

class ExchangeCodesForSessionToken extends RegistrationEvent {
  final String returnToCode;

  ExchangeCodesForSessionToken({required this.returnToCode});
  @override
  List<Object> get props => [returnToCode];
}

class RegisterWithWebAuth extends RegistrationEvent {
  final String url;

  RegisterWithWebAuth({required this.url});
  @override
  List<Object> get props => [url];
}

class ChangeNodeValue extends RegistrationEvent {
  final String value;
  final String name;

  ChangeNodeValue({required this.value, required this.name});
  @override
  List<Object> get props => [value, name];
}

class UpdateRegistrationFlow extends RegistrationEvent {
  final UiNodeGroupEnum group;
  final String name;
  final String value;

  UpdateRegistrationFlow(
      {required this.group, required this.name, required this.value});
  @override
  List<Object> get props => [group, name, value];
}
