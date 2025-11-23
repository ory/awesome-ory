// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ory_client/ory_client.dart';

import '../../repositories/auth.dart';
import '../../services/exceptions.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository})
      : super(const AuthState.uninitialized()) {
    on<GetCurrentSessionInformation>(_onGetCurrentSessionInformation);
    on<RequireLocationChange>(_onRequireLocationChange);
    on<AddSession>(_onAddSession);
    on<ChangeAuthStatus>(_onChangeAuthStatus);
    on<LogOut>(_onLogOut);
  }

  _onRequireLocationChange(
      RequireLocationChange event, Emitter<AuthState> emit) {
    emit(AuthState.locationChangeRequired(url: event.url));
  }

  _onAddSession(AddSession event, Emitter<AuthState> emit) {
    emit(AuthState.authenticated(
        session: event.session, conditions: event.conditions));
  }

  _onChangeAuthStatus(ChangeAuthStatus event, Emitter<AuthState> emit) {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        emit(const AuthState.unauthenticated());
      case AuthStatus.aal2Requested:
        emit(AuthState.aal2Requested(conditions: event.conditions));
      default:
        emit(state);
    }
    emit(state.copyWith(status: event.status, isLoading: false));
  }

  Future<void> _onGetCurrentSessionInformation(
      GetCurrentSessionInformation event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final session = await repository.getCurrentSessionInformation();

      emit(AuthState.authenticated(
          session: session, conditions: event.conditions));
    } on UnauthorizedException catch (_) {
      emit(const AuthState.unauthenticated());
    } on TwoFactorAuthRequiredException catch (_) {
      emit(AuthState.aal2Requested(conditions: event.conditions));
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      await repository.logout();

      emit(const AuthState.unauthenticated());
    } on UnauthorizedException catch (_) {
      emit(const AuthState.unauthenticated());
    } on UnknownException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
