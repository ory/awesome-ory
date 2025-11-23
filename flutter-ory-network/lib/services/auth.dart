// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:one_of/one_of.dart';
import 'package:ory_client/ory_client.dart';
import 'exceptions.dart';
import 'storage.dart';

class AuthService {
  final _storage = SecureStorage();
  final FrontendApi _ory;
  AuthService(Dio dio) : _ory = OryClient(dio: dio).getFrontendApi();

  /// Get current session information
  Future<Session> getCurrentSessionInformation() async {
    try {
      final token = await _storage.getToken();
      final response = await _ory.toSession(xSessionToken: token);

      if (response.data != null) {
        // return session
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else if (e.response?.statusCode == 403) {
        if (e.response?.data['error']['id'] == 'session_aal2_required') {
          throw const CustomException.twoFactorAuthRequired();
        } else {
          throw _handleUnknownException(e.response?.data);
        }
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Create login flow
  Future<LoginFlow> createLoginFlow(
      {required String aal, required bool refresh}) async {
    try {
      final token = await _storage.getToken();
      final response = await _ory.createNativeLoginFlow(
          aal: aal,
          refresh: refresh,
          xSessionToken: token,
          returnSessionTokenExchangeCode: true,
          returnTo: 'ory://flutter-ory-network');
      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      throw _handleUnknownException(e.response?.data);
    }
  }

  /// Create registration flow
  Future<RegistrationFlow> createRegistrationFlow() async {
    try {
      final response = await _ory.createNativeRegistrationFlow(
          returnSessionTokenExchangeCode: true,
          returnTo: 'ory://flutter-ory-network');
      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      throw _handleUnknownException(e.response?.data);
    }
  }

  /// Create recovery flow
  Future<RecoveryFlow> createRecoveryFlow() async {
    try {
      final response = await _ory.createNativeRecoveryFlow();
      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      throw _handleUnknownException(e.response?.data);
    }
  }

  /// Update login flow with [flowId] for [group] with [value]
  Future<Session> updateLoginFlow(
      {required String flowId,
      required UiNodeGroupEnum group,
      required Map value}) async {
    try {
      final token = await _storage.getToken();
      final OneOf oneOf;

      // create update body depending on method
      switch (group) {
        case UiNodeGroupEnum.password:
          oneOf = OneOf.fromValue1(
              value: UpdateLoginFlowWithPasswordMethod((b) => b
                ..method = group.name
                ..identifier = value['identifier']
                ..password = value['password']));
        case UiNodeGroupEnum.lookupSecret:
          oneOf = OneOf.fromValue1(
              value: UpdateLoginFlowWithLookupSecretMethod((b) => b
                // use pre-defined string as enum value doesn't include an underscore
                ..method = 'lookup_secret'
                ..lookupSecret = value['lookup_secret']));
        case UiNodeGroupEnum.totp:
          oneOf = OneOf.fromValue1(
              value: UpdateLoginFlowWithTotpMethod((b) => b
                ..method = group.name
                ..totpCode = value['totp_code']));
        case UiNodeGroupEnum.oidc:
          oneOf = OneOf.fromValue1(
              value: UpdateLoginFlowWithOidcMethod((b) => b
                ..method = group.name
                ..provider = value['provider']
                ..idToken = value['id_token']
                ..idTokenNonce = value['nonce']));
        case UiNodeGroupEnum.code:
          oneOf = OneOf.fromValue1(
              value: UpdateLoginFlowWithCodeMethod((b) => b
                ..csrfToken = ''
                ..method = group.name
                ..identifier = value['identifier']
                ..code = value['resend'] != null ? null : value['code']
                ..resend = value['resend']));

        // if method is not implemented, throw exception
        default:
          throw const CustomException.unknown();
      }

      final response = await _ory.updateLoginFlow(
          flow: flowId,
          xSessionToken: token,
          updateLoginFlowBody: UpdateLoginFlowBody((b) => b..oneOf = oneOf));

      if (response.data?.session != null) {
        // save session token after successful login
        await _storage.persistToken(response.data!.sessionToken!);
        if (response.data!.session.identity != null) {
          return response.data!.session;
        } else {
          // identity is null, aal2 is required
          throw const CustomException.twoFactorAuthRequired();
        }
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else if (e.response?.statusCode == 400) {
        final loginFlow = standardSerializers.deserializeWith(
            LoginFlow.serializer, e.response?.data);
        if (loginFlow != null) {
          throw CustomException<LoginFlow>.badRequest(flow: loginFlow);
        } else {
          throw const CustomException.unknown();
        }
      } else if (e.response?.statusCode == 410) {
        // settings flow expired, use new flow id
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else if (e.response?.statusCode == 422) {
        final error = e.response?.data['error'];
        if (error['id'] == 'browser_location_change_required') {
          throw CustomException.locationChangeRequired(
              url: e.response?.data['redirect_browser_to']);
        }
        throw const CustomException.unknown();
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Get login flow with [flowId]
  Future<LoginFlow> getLoginFlow({required String flowId}) async {
    try {
      final response = await _ory.getLoginFlow(id: flowId);

      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else if (e.response?.statusCode == 410) {
        // settings flow expired, use new flow id and add error message
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Get registration flow with [flowId]
  Future<RegistrationFlow> getRegistrationFlow({required String flowId}) async {
    try {
      final response = await _ory.getRegistrationFlow(id: flowId);

      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      throw _handleUnknownException(e.response?.data);
    }
  }

  /// When using oidc flow with [flowId], excange [initCode] and [returnToCode] for a session token
  Future<Session> exchangeCodesForSessionToken(
      {required String flowId,
      required String initCode,
      required String returnToCode}) async {
    try {
      final response = await _ory.exchangeSessionToken(
          initCode: initCode, returnToCode: returnToCode);

      if (response.data?.session != null) {
        // save session token after successful login
        await _storage.persistToken(response.data!.sessionToken!);
        return response.data!.session;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      throw _handleUnknownException(e.response?.data);
    }
  }

  /// Update registration flow with [flowId] for [group] with [value]
  Future<Session> updateRegistrationFlow(
      {required String flowId,
      required UiNodeGroupEnum group,
      required Map value}) async {
    try {
      final OneOf oneOf;

      // create update body depending on method
      switch (group) {
        case UiNodeGroupEnum.password:
          oneOf = OneOf.fromValue1(
              value: UpdateRegistrationFlowWithPasswordMethod((b) => b
                ..method = group.name
                ..traits = JsonObject(value['traits'])
                ..password = value['password']));
        case UiNodeGroupEnum.oidc:
          oneOf = OneOf.fromValue1(
              value: UpdateRegistrationFlowWithOidcMethod((b) => b
                ..method = group.name
                ..provider = value['provider']
                ..idToken = value['id_token']
                ..idTokenNonce = value['nonce']));
        case UiNodeGroupEnum.code:
          oneOf = OneOf.fromValue1(
              value: UpdateRegistrationFlowWithCodeMethod((b) => b
                ..csrfToken = ''
                ..method = group.name
                ..traits = JsonObject(value['traits'])
                ..code = value['resend'] != null ? null : value['code']
                ..resend = value['resend']));

        // if method is not implemented, throw exception
        default:
          throw const CustomException.unknown();
      }

      final response = await _ory.updateRegistrationFlow(
          flow: flowId,
          updateRegistrationFlowBody:
              UpdateRegistrationFlowBody((b) => b..oneOf = oneOf));

      if (response.data?.session != null) {
        // save session token after successful login
        await _storage.persistToken(response.data!.sessionToken!);
        return response.data!.session!;
      } else {
        throw const CustomException.unknown();
      }
      // dio throws exception 200 when logging in with google
    } on DioException catch (e) {
      // user tried to register with social sign in using already existing account
      if (e.response?.statusCode == 200) {
        final successfulLogin = standardSerializers.deserializeWith(
            SuccessfulNativeLogin.serializer, e.response?.data);
        if (successfulLogin?.session != null) {
          // save session token after successful login
          await _storage.persistToken(successfulLogin!.sessionToken!);
          return successfulLogin.session;
        } else {
          throw const CustomException.unknown();
        }
      } else if (e.response?.statusCode == 400) {
        final registrationFlow = standardSerializers.deserializeWith(
            RegistrationFlow.serializer, e.response?.data);
        if (registrationFlow != null) {
          throw CustomException<RegistrationFlow>.badRequest(
              flow: registrationFlow);
        } else {
          throw const CustomException.unknown();
        }
      } else if (e.response?.statusCode == 410) {
        // settings flow expired, use new flow id and add error message
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else if (e.response?.statusCode == 422) {
        final error = e.response?.data['error'];
        if (error['id'] == 'browser_location_change_required') {
          throw CustomException.locationChangeRequired(
              url: e.response?.data['redirect_browser_to']);
        }
        throw const CustomException.unknown();
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    } catch (e) {
      throw const CustomException.unknown();
    }
  }

  /// Update recovery flow with [flowId] and [value] as body
  Future<RecoveryFlow> updateRecoveryFlow(
      {required String flowId, required Map value}) async {
    try {
      final oneOf = OneOf.fromValue1(
          value: UpdateRecoveryFlowWithCodeMethod((b) => b
            ..method = UpdateRecoveryFlowWithCodeMethodMethodEnum.code
            ..email = value['email']
            ..code = value['code']));

      final response = await _ory.updateRecoveryFlow(
          flow: flowId,
          updateRecoveryFlowBody:
              UpdateRecoveryFlowBody((b) => b..oneOf = oneOf));
      if (response.data != null) {
        if (response.data!.continueWith != null) {
          // get session token from actions
          final sessionTokenAction = response.data!.continueWith!.firstWhere(
              (element) =>
                  element.oneOf.isType(ContinueWithSetOrySessionToken));
          final token =
              (sessionTokenAction.oneOf.value as ContinueWithSetOrySessionToken)
                  .orySessionToken;
          // save session token
          await _storage.persistToken(token);
          // get flow id to redirect to settings and let the user change the password
          final settingsFlowAction = response.data!.continueWith!.firstWhere(
              (element) => element.oneOf.isType(ContinueWithSettingsUi));
          final settingsFlowId =
              (settingsFlowAction.oneOf.value as ContinueWithSettingsUi)
                  .flow
                  .id;
          throw CustomException.settingsRedirectRequired(
              settingsFlowId: settingsFlowId);
        }
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final recoveryFlow = standardSerializers.deserializeWith(
            RecoveryFlow.serializer, e.response?.data);
        if (recoveryFlow != null) {
          throw CustomException<RecoveryFlow>.badRequest(flow: recoveryFlow);
        } else {
          throw const CustomException.unknown();
        }
      } else if (e.response?.statusCode == 410) {
        // recovery flow expired, use new flow id and add error message
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    } on CustomException catch (_) {
      rethrow;
    } catch (e) {
      throw const CustomException.unknown();
    }
  }

  Future<void> logout() async {
    try {
      final token = await _storage.getToken();

      final PerformNativeLogoutBody logoutBody =
          PerformNativeLogoutBody((b) => b..sessionToken = token);
      final response =
          await _ory.performNativeLogout(performNativeLogoutBody: logoutBody);
      if (response.statusCode == 204) {
        await _storage.deleteToken();
        return;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Create settings flow
  Future<SettingsFlow> createSettingsFlow() async {
    try {
      final token = await _storage.getToken();
      final response =
          await _ory.createNativeSettingsFlow(xSessionToken: token);

      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Get settings flow with [flowId]
  Future<SettingsFlow> getSettingsFlow({required String flowId}) async {
    try {
      final token = await _storage.getToken();
      final response =
          await _ory.getSettingsFlow(id: flowId, xSessionToken: token);

      if (response.data != null) {
        // return flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else if (e.response?.statusCode == 410) {
        // settings flow expired, use new flow id
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Update settings flow with [flowId] for [group] with [value]
  Future<SettingsFlow> updateSettingsFlow(
      {required String flowId,
      required UiNodeGroupEnum group,
      required Map value}) async {
    try {
      final token = await _storage.getToken();
      final OneOf oneOf;

      // create update body depending on method
      switch (group) {
        case UiNodeGroupEnum.password:
          oneOf = OneOf.fromValue1(
              value: UpdateSettingsFlowWithPasswordMethod((b) => b
                ..method = group.name
                ..password = value['password']));
        case UiNodeGroupEnum.profile:
          oneOf = OneOf.fromValue1(
              value: UpdateSettingsFlowWithProfileMethod((b) => b
                ..method = group.name
                ..traits = JsonObject(value['traits'])));
        case UiNodeGroupEnum.lookupSecret:
          oneOf = OneOf.fromValue1(
              value: UpdateSettingsFlowWithLookupMethod((b) => b
                ..method = group.name
                ..lookupSecretConfirm =
                    getBoolValue(value['lookup_secret_confirm'])
                ..lookupSecretDisable =
                    getBoolValue(value['lookup_secret_disable'])
                ..lookupSecretReveal =
                    getBoolValue(value['lookup_secret_reveal'])
                ..lookupSecretRegenerate =
                    getBoolValue(value['lookup_secret_regenerate'])));
        case UiNodeGroupEnum.totp:
          oneOf = OneOf.fromValue1(
              value: UpdateSettingsFlowWithTotpMethod((b) => b
                ..method = group.name
                ..totpCode = value['totp_code']
                ..totpUnlink = getBoolValue(value['totp_unlink'])));
        // if method is not implemented, throw exception
        default:
          throw const CustomException.unknown();
      }

      final response = await _ory.updateSettingsFlow(
          flow: flowId,
          xSessionToken: token,
          updateSettingsFlowBody:
              UpdateSettingsFlowBody((b) => b..oneOf = oneOf));

      if (response.data != null) {
        // return updated settings flow
        return response.data!;
      } else {
        throw const CustomException.unknown();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await _storage.deleteToken();
        throw const CustomException.unauthorized();
      } else if (e.response?.statusCode == 403) {
        throw const CustomException.sessionRefreshRequired();
      } else if (e.response?.statusCode == 410) {
        // settings flow expired, use new flow id and add error message
        throw CustomException.flowExpired(
            flowId: e.response?.data['use_flow_id']);
      } else {
        throw _handleUnknownException(e.response?.data);
      }
    }
  }

  /// Get bool value of string [value]
  bool? getBoolValue(String? value) {
    if (value == null) {
      return null;
    } else {
      return value == 'true' ? true : false;
    }
  }

  CustomException _handleUnknownException(Map? response) {
    // use human-readable reason if response contains it, otherwise use default value
    if (response != null &&
        response.containsKey('error') &&
        (response['error'] as Map).containsKey('reason')) {
      return CustomException.unknown(message: response['error']['reason']);
    } else {
      return const CustomException.unknown();
    }
  }
}
