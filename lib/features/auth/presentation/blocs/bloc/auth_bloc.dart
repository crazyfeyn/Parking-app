// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/auth/domain/usecases/authicated_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/refresh_user_token_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/reset_pass_user_usecase.dart';
part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginUserUsecase loginUserUsecase;
  RefreshUserTokenUsecase refreshUserTokenUsecase;
  RegisterUserUsecase registerUserUsecase;
  ResetPassUserUsecase resetPassUserUsecase;
  AuthicatedUsecase authicatedUsecase;
  LogOutUsecase logOutUsecase;
  AuthBloc(
    this.loginUserUsecase,
    this.refreshUserTokenUsecase,
    this.registerUserUsecase,
    this.resetPassUserUsecase,
    this.authicatedUsecase,
    this.logOutUsecase,
  ) : super(AuthState()) {
    on<_log>(_logIn);
    on<_logOut>(_logOu);
    on<_initial>(_doint);
    on<_reg>(_register);
    on<_resetPass>(_reset);
    on<_refreshToken>(_refresh);
    on<_authicated>(_auth);
  }

  Future<void> _logOu(_logOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final recponce = await logOutUsecase(null);
    recponce.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

    Future<void> _doint(_initial event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.initial));
    
  }

  Future<void> _logIn(_log event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final recponce = await loginUserUsecase(
        LoginParams(email: event.email, password: event.password));
    recponce.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _register(_reg event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final recponce = await registerUserUsecase(
        RegisterParams(email: event.email, password: event.password));
    recponce.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _reset(_resetPass event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final recponce = await resetPassUserUsecase(event.email);
    recponce.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _refresh(_refreshToken event, Emitter<AuthState> emit) async {
    await refreshUserTokenUsecase.call(null);
  }

  Future<void> _auth(_authicated event, Emitter<AuthState> emit) async {
    final recponce = await authicatedUsecase.call(null);
    print('HELLO FROM BLOC');
    print(recponce);
    if (recponce == true) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }
}
