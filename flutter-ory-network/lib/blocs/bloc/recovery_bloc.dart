// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/repositories/auth.dart';

import '../../services/exceptions.dart';

part 'recovery_event.dart';
part 'recovery_state.dart';
part 'recovery_bloc.freezed.dart';

class RecoveryBloc extends Bloc<RecoveryEvent, RecoveryState> {
  final AuthRepository repository;
  RecoveryBloc({required this.repository}) : super(const RecoveryState()) {
    on<CreateRecoveryFlow>(_onCreateRecoveryFlow);
    on<ChangeNodeValue>(_onChangeNodeValue);
    // on<GetRecoveryFlow>(_onGetRecoveryFlow);
    on<UpdateRecoveryFlow>(_onUpdateRecoveryFlow);
  }

  Future<void> _onCreateRecoveryFlow(
      CreateRecoveryFlow event, Emitter<RecoveryState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, message: null));

      final recoveryFlow = await repository.createRecoveryFlow();

      emit(state.copyWith(recoveryFlow: recoveryFlow, isLoading: false));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, message: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  _onChangeNodeValue(ChangeNodeValue event, Emitter<RecoveryState> emit) {
    if (state.recoveryFlow != null) {
      final newRecoveryState = repository.changeRecoveryNodeValue(
          flow: state.recoveryFlow!, name: event.name, value: event.value);
      emit(state.copyWith(recoveryFlow: newRecoveryState, message: null));
    }
  }

  Future<void> _onUpdateRecoveryFlow(
      UpdateRecoveryFlow event, Emitter<RecoveryState> emit) async {
    try {
      if (state.recoveryFlow != null) {
        emit(state.copyWith(isLoading: true, message: null));
        final recoveryFlow = await repository.updateRecoveryFlow(
            flowId: state.recoveryFlow!.id,
            group: event.group,
            name: event.name,
            value: event.value,
            nodes: state.recoveryFlow!.ui.nodes.toList());
        emit(state.copyWith(recoveryFlow: recoveryFlow, isLoading: false));
      }
    } on BadRequestException<RecoveryFlow> catch (e) {
      emit(state.copyWith(recoveryFlow: e.flow, isLoading: false));
    } on settingsRedirectRequired catch (e) {
      emit(state.copyWith(settingsFlowId: e.settingsFlowId));
    }
  }
}
