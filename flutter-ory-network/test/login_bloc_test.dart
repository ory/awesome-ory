// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/blocs/auth/auth_bloc.dart';
import 'package:ory_network_flutter/blocs/login/login_bloc.dart';
import 'package:ory_network_flutter/repositories/auth.dart';
import 'package:ory_network_flutter/services/exceptions.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

/// A LoginFlow is a built_value type, so build one rather than mocking it.
LoginFlow buildLoginFlow(String id) => LoginFlow((b) => b
  ..id = id
  ..type = 'native'
  ..expiresAt = DateTime.utc(2030)
  ..issuedAt = DateTime.utc(2030)
  ..requestUrl = 'http://localhost/self-service/login'
  ..ui.action = 'http://localhost/self-service/login'
  ..ui.method = 'POST');

void main() {
  late MockAuthRepository repository;
  late MockAuthBloc authBloc;

  setUp(() {
    repository = MockAuthRepository();
    authBloc = MockAuthBloc();
  });

  group('CreateLoginFlow', () {
    blocTest<LoginBloc, LoginState>(
      'shows a spinner, then the flow it got back from Ory',
      setUp: () {
        when(() => repository.createLoginFlow(
                aal: any(named: 'aal'), refresh: any(named: 'refresh')))
            .thenAnswer((_) async => buildLoginFlow('flow-1'));
      },
      build: () => LoginBloc(authBloc: authBloc, repository: repository),
      act: (bloc) => bloc.add(CreateLoginFlow(aal: 'aal1')),
      expect: () => [
        const LoginState(isLoading: true),
        isA<LoginState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.loginFlow?.id, 'loginFlow.id', 'flow-1'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'surfaces the message from Ory when the flow cannot be created',
      setUp: () {
        when(() => repository.createLoginFlow(
                aal: any(named: 'aal'), refresh: any(named: 'refresh')))
            .thenThrow(const CustomException.unknown(message: 'flow expired'));
      },
      build: () => LoginBloc(authBloc: authBloc, repository: repository),
      act: (bloc) => bloc.add(CreateLoginFlow(aal: 'aal1')),
      expect: () => [
        const LoginState(isLoading: true),
        const LoginState(isLoading: false, message: 'flow expired'),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'stops loading but stays quiet on an unexpected failure',
      setUp: () {
        when(() => repository.createLoginFlow(
                aal: any(named: 'aal'), refresh: any(named: 'refresh')))
            .thenThrow(Exception('the network is down'));
      },
      build: () => LoginBloc(authBloc: authBloc, repository: repository),
      act: (bloc) => bloc.add(CreateLoginFlow(aal: 'aal1')),
      expect: () => [
        const LoginState(isLoading: true),
        const LoginState(isLoading: false),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'asks Ory to refresh the session when a refresh was requested',
      setUp: () {
        when(() => repository.createLoginFlow(
                aal: any(named: 'aal'), refresh: any(named: 'refresh')))
            .thenAnswer((_) async => buildLoginFlow('flow-2'));
      },
      build: () => LoginBloc(
        authBloc: authBloc,
        repository: repository,
        conditions: [SessionRefreshRequested()],
      ),
      act: (bloc) => bloc.add(CreateLoginFlow(aal: 'aal1')),
      verify: (_) {
        verify(() => repository.createLoginFlow(aal: 'aal1', refresh: true))
            .called(1);
      },
    );
  });

  group('GetLoginFlow', () {
    blocTest<LoginBloc, LoginState>(
      'loads an existing flow by id',
      setUp: () {
        when(() => repository.getLoginFlow(flowId: any(named: 'flowId')))
            .thenAnswer((_) async => buildLoginFlow('flow-3'));
      },
      build: () => LoginBloc(authBloc: authBloc, repository: repository),
      act: (bloc) => bloc.add(GetLoginFlow(flowId: 'flow-3')),
      expect: () => [
        const LoginState(isLoading: true),
        isA<LoginState>()
            .having((s) => s.loginFlow?.id, 'loginFlow.id', 'flow-3')
            .having((s) => s.isLoading, 'isLoading', false),
      ],
    );
  });
}
