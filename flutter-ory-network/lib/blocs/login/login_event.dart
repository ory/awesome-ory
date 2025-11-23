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
  final bool refresh;

  CreateLoginFlow({this.refresh = false, required this.aal});
  @override
  List<Object> get props => [refresh, aal];
}

class ChangeNodeValue extends LoginEvent {
  final String value;
  final String name;

  ChangeNodeValue({required this.value, required this.name});
  @override
  List<Object> get props => [value, name];
}

class ExchangeCodesForSessionToken extends LoginEvent {
  final String returnToCode;

  ExchangeCodesForSessionToken({required this.returnToCode});
  @override
  List<Object> get props => [returnToCode];
}

class LoginWithWebAuth extends LoginEvent {
  final String url;

  LoginWithWebAuth({required this.url});
  @override
  List<Object> get props => [url];
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
  final bool recoveryRequested;

  UpdateLoginFlow(
      {required this.group,
      required this.name,
      required this.value,
      this.recoveryRequested = false});
  @override
  List<Object> get props => [group, name, value, recoveryRequested];
}
