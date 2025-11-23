// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';

import '../../repositories/auth.dart';
import '../../services/exceptions.dart';
import '../auth/auth_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthBloc authBloc;
  final AuthRepository repository;
  RegistrationBloc({required this.authBloc, required this.repository})
      : super(const RegistrationState()) {
    on<CreateRegistrationFlow>(_onCreateRegistrationFlow);
    on<GetRegistrationFlow>(_onGetRegistrationFlow);
    on<RegisterWithWebAuth>(_onRegisterWithWebAuth);
    on<ExchangeCodesForSessionToken>(_onExchangeCodesForSessionToken);
    on<ChangeNodeValue>(_onChangeNodeValue);
    on<UpdateRegistrationFlow>(_onUpdateRegistrationFlow);
  }

  Future<void> _onCreateRegistrationFlow(
      CreateRegistrationFlow event, Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final flow = await repository.createRegistrationFlow();
      emit(state.copyWith(registrationFlow: flow, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGetRegistrationFlow(
      GetRegistrationFlow event, Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));
      final flow = await repository.getRegistrationFlow(flowId: event.flowId);
      emit(state.copyWith(registrationFlow: flow, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onChangeNodeValue(ChangeNodeValue event, Emitter<RegistrationState> emit) {
    if (state.registrationFlow != null) {
      final newRegistrationState = repository.changeRegistrationNodeValue(
          flow: state.registrationFlow!, name: event.name, value: event.value);
      emit(state.copyWith(
          registrationFlow: newRegistrationState, message: null));
    }
  }

  Future<void> _onRegisterWithWebAuth(
      RegisterWithWebAuth event, Emitter<RegistrationState> emit) async {
    try {
      final code = await repository.getWebAuthCode(url: event.url);
      add(ExchangeCodesForSessionToken(returnToCode: code));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onExchangeCodesForSessionToken(ExchangeCodesForSessionToken event,
      Emitter<RegistrationState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));

      final session = await repository.exchangeCodesForSessionToken(
          flowId: state.registrationFlow?.id,
          initCode: state.registrationFlow?.sessionTokenExchangeCode,
          returnToCode: event.returnToCode);
      authBloc.add(AddSession(session: session));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdateRegistrationFlow(
      UpdateRegistrationFlow event, Emitter<RegistrationState> emit) async {
    try {
      if (state.registrationFlow != null) {
        emit(state.copyWith(isLoading: true, message: null));
        final session = await repository.updateRegistrationFlow(
            flowId: state.registrationFlow!.id,
            group: event.group,
            name: event.name,
            value: event.value,
            nodes: state.registrationFlow!.ui.nodes.toList());
        authBloc.add(AddSession(session: session));
      }
    } on BadRequestException<RegistrationFlow> catch (e) {
      emit(state.copyWith(registrationFlow: e.flow, isLoading: false));
    } on LocationChangeRequiredException catch (e) {
      emit(state.copyWith(isLoading: false));
      add(RegisterWithWebAuth(url: e.url));
    } on FlowExpiredException catch (e) {
      add(GetRegistrationFlow(flowId: e.flowId));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
