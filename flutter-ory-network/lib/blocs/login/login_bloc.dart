// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/widgets/helpers.dart';

import '../../repositories/auth.dart';
import '../../services/exceptions.dart';
import '../auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;
  final AuthRepository repository;
  final List<Condition> conditions;

  LoginBloc(
      {required this.authBloc,
      required this.repository,
      this.conditions = const []})
      : super(LoginState(conditions: conditions)) {
    on<CreateLoginFlow>(_onCreateLoginFlow);
    on<GetLoginFlow>(_onGetLoginFlow);
    on<ExchangeCodesForSessionToken>(_onExchangesCodeForSessionToken);
    on<LoginWithWebAuth>(_onLoginWithWebAuth);
    on<ChangeNodeValue>(_onChangeNodeValue);
    on<UpdateLoginFlow>(_onUpdateLoginFlow);
  }

  Future<void> _onCreateLoginFlow(
      CreateLoginFlow event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final refresh = isSessionRefreshRequired(state.conditions);
      final loginFlow =
          await repository.createLoginFlow(aal: event.aal, refresh: refresh);
      emit(state.copyWith(loginFlow: loginFlow, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGetLoginFlow(
      GetLoginFlow event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final loginFlow = await repository.getLoginFlow(flowId: event.flowId);
      emit(state.copyWith(loginFlow: loginFlow, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLoginWithWebAuth(
      LoginWithWebAuth event, Emitter<LoginState> emit) async {
    try {
      final code = await repository.getWebAuthCode(url: event.url);
      add(ExchangeCodesForSessionToken(returnToCode: code));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onExchangesCodeForSessionToken(
      ExchangeCodesForSessionToken event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));

      final session = await repository.exchangeCodesForSessionToken(
          flowId: state.loginFlow?.id,
          initCode: state.loginFlow?.sessionTokenExchangeCode!,
          returnToCode: event.returnToCode);
      authBloc.add(AddSession(session: session));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onChangeNodeValue(ChangeNodeValue event, Emitter<LoginState> emit) {
    if (state.loginFlow != null) {
      final newLoginState = repository.changeLoginNodeValue(
          flow: state.loginFlow!, name: event.name, value: event.value);
      emit(state.copyWith(loginFlow: newLoginState, message: null));
    }
  }

  _onUpdateLoginFlow(UpdateLoginFlow event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final session = await repository.updateLoginFlow(
          flowId: state.loginFlow!.id,
          group: event.group,
          name: event.name,
          value: event.value,
          nodes: state.loginFlow!.ui.nodes.toList());

      authBloc.add(AddSession(session: session, conditions: state.conditions));
      emit(state.copyWith(isLoading: false));
    } on BadRequestException<LoginFlow> catch (e) {
      emit(state.copyWith(loginFlow: e.flow, isLoading: false));
    } on LocationChangeRequiredException catch (e) {
      emit(state.copyWith(isLoading: false));
      add(LoginWithWebAuth(url: e.url));
    } on UnauthorizedException catch (_) {
      authBloc.add(ChangeAuthStatus(status: AuthStatus.unauthenticated));
    } on FlowExpiredException catch (e) {
      add(GetLoginFlow(flowId: e.flowId));
    } on TwoFactorAuthRequiredException catch (_) {
      authBloc.add(ChangeAuthStatus(
          status: AuthStatus.aal2Requested, conditions: state.conditions));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
