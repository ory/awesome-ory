// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/repositories/auth.dart';

import '../../repositories/settings.dart';
import '../../services/exceptions.dart';
import '../auth/auth_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

part 'settings_bloc.freezed.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthBloc authBloc;
  final SettingsRepository repository;
  late SettingsEvent? _previousEvent;
  SettingsBloc({required this.authBloc, required this.repository})
      : super(const SettingsState()) {
    on<CreateSettingsFlow>(_onCreateSettingsFlow);
    on<GetSettingsFlow>(_onGetSettingsFlow);
    on<ChangeSettingsNodeValue>(_onChangeNodeValue, transformer: sequential());
    on<ResetSettings>(_onResetSettings);
    on<UpdateSettingsFlow>(_onUpdateSettingsFlow, transformer: sequential());
  }

  @override
  void onEvent(SettingsEvent event) {
    super.onEvent(event);
    _previousEvent = event;
  }

  void retry() {
    if (_previousEvent != null) {
      add(_previousEvent!);
    }
  }

  _onChangeNodeValue(
      ChangeSettingsNodeValue event, Emitter<SettingsState> emit) {
    if (state.settingsFlow != null) {
      final newSettingsState = repository.changeNodeValue(
          settings: state.settingsFlow!, name: event.name, value: event.value);
      emit(state.copyWith(settingsFlow: newSettingsState, message: null));
    }
  }

  _onResetSettings(ResetSettings event, Emitter<SettingsState> emit) async {
    try {
      if (state.settingsFlow != null) {
        emit(state.copyWith(isLoading: true));
        final settings =
            await repository.getSettingsFlow(flowId: state.settingsFlow!.id);
        List<Condition> updatedConditions = List.from(state.conditions);
        updatedConditions
            .removeWhere((element) => element is SessionRefreshRequested);
        emit(state.copyWith(
            settingsFlow: settings,
            conditions: updatedConditions,
            isLoading: false));
      }
    } on UnauthorizedException catch (_) {
      // change auth status as the user is not authenticated
      authBloc.add(ChangeAuthStatus(status: AuthStatus.unauthenticated));
    } on FlowExpiredException catch (e) {
      // get new settings flow
      add(GetSettingsFlow(flowId: e.flowId));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdateSettingsFlow(
      UpdateSettingsFlow event, Emitter<SettingsState> emit) async {
    try {
      if (state.settingsFlow != null) {
        List<Condition> updatedConditions = List.from(state.conditions);
        updatedConditions
            .removeWhere((element) => element is SessionRefreshRequested);
        emit(state.copyWith(
            isLoading: true, conditions: updatedConditions, message: null));
        final settings = await repository.updateSettingsFlow(
            flowId: state.settingsFlow!.id,
            group: event.group,
            nodes: state.settingsFlow!.ui.nodes.toList());
        emit(state.copyWith(isLoading: false, settingsFlow: settings));
      }
    } on UnauthorizedException catch (_) {
      // change auth status as the user is not authenticated
      authBloc.add(ChangeAuthStatus(status: AuthStatus.unauthenticated));
    } on FlowExpiredException catch (e) {
      // get new settings flow
      add(GetSettingsFlow(flowId: e.flowId));
    } on SessionRefreshRequiredException catch (_) {
      // set session refresh required flag to navigate to login page
      List<Condition> currentConditions =
          List.from(state.conditions, growable: true);
      currentConditions.add(SessionRefreshRequested());
      emit(state.copyWith(conditions: currentConditions, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onCreateSettingsFlow(
      SettingsEvent event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));

      final settingsFlow = await repository.createSettingsFlow();

      emit(state.copyWith(isLoading: false, settingsFlow: settingsFlow));
    } on UnauthorizedException catch (_) {
      // change auth status as the user is not authenticated
      authBloc.add(ChangeAuthStatus(status: AuthStatus.unauthenticated));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onGetSettingsFlow(
      GetSettingsFlow event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final settingsFlow =
          await repository.getSettingsFlow(flowId: event.flowId);
      emit(state.copyWith(isLoading: false, settingsFlow: settingsFlow));
    } on UnauthorizedException catch (_) {
      // change auth status as the user is not authenticated
      authBloc.add(ChangeAuthStatus(status: AuthStatus.unauthenticated));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
