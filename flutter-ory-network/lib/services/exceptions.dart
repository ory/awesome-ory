// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';

part 'exceptions.freezed.dart';

@freezed
sealed class CustomException<T> with _$CustomException {
  const CustomException._();
  const factory CustomException.sessionRefreshRequired({String? message}) =
      SessionRefreshRequiredException;
  const factory CustomException.badRequest({required T flow}) =
      BadRequestException;
  const factory CustomException.unauthorized() = UnauthorizedException;
  const factory CustomException.flowExpired(
      {required String flowId, String? message}) = FlowExpiredException;
  const factory CustomException.twoFactorAuthRequired({Session? session}) =
      TwoFactorAuthRequiredException;
  const factory CustomException.locationChangeRequired({required String url}) =
      LocationChangeRequiredException;
  const factory CustomException.settingsRedirectRequired(
      {String? settingsFlowId}) = settingsRedirectRequired;
  const factory CustomException.unknown(
      {@Default('An error occured. Please try again later.')
      String message}) = UnknownException;
}
