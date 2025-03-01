// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/auth/domain/usecases/authicated_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/refresh_user_token_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/reset_pass_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/start_refresh_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/stop_refresh_usecase.dart';

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
  ChangePasswordUsecase changePasswordUsecase;
  StopRefreshUsecase stopRefreshUsecase;
  StartRefreshUsecase startRefreshUsecase;
  AuthBloc(
    this.loginUserUsecase,
    this.refreshUserTokenUsecase,
    this.registerUserUsecase,
    this.resetPassUserUsecase,
    this.authicatedUsecase,
    this.logOutUsecase,
    this.changePasswordUsecase,
    this.stopRefreshUsecase,
    this.startRefreshUsecase,
  ) : super(AuthState()) {
    on<_log>(_logIn);
    on<_logOut>(_logOu);
    on<_initial>(_doint);
    on<_reg>(_register);
    on<_resetPass>(_reset);
    on<_refreshToken>(_refresh);
    on<_authicated>(_auth);
    on<_changePass>(_change);
    on<_stopToken>(_stop);
    on<_startToken>(_start);
  }

  Future<void> _change(_changePass event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final recponce = await changePasswordUsecase(
        ChangePassParams(oldPass: event.oldPass, newPass: event.newPass));
    recponce.fold((error) {
      if (error is NetworkFailure) {
        emit(
          state.copyWith(status: Status.errorNetwork),
        );
      } else {
        emit(
          state.copyWith(status: Status.error),
        );
      }
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _stop(_stopToken event, Emitter<AuthState> emit) async {
    await stopRefreshUsecase.call();
  }

  Future<void> _start(_startToken event, Emitter<AuthState> emit) async {
    await startRefreshUsecase.call();
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
    final response = await loginUserUsecase(
      LoginParams(email: event.email, password: event.password),
    );

    response.fold((error) {
      emit(
        state.copyWith(
            status:
                error is NetworkFailure ? Status.errorNetwork : Status.error),
      );
    }, (data) {
      emit(state.copyWith(status: Status.success));
    });

    // Сбрасываем состояние после успеха/ошибки
    emit(state.copyWith(status: Status.initial));
  }

  Future<void> _register(_reg event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final recponce = await registerUserUsecase(RegisterParams(
        email: event.email,
        password: event.password,
        name: event.name,
        surname: event.surname));
    recponce.fold((error) {
      if (error is NetworkFailure) {
        emit(
          state.copyWith(status: Status.errorNetwork),
        );
      } else {
        emit(
          state.copyWith(status: Status.error),
        );
      }
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _reset(_resetPass event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status2: Status2.loading));

    final recponce = await resetPassUserUsecase(event.email);
    recponce.fold((error) {
      if (error is NetworkFailure) {
        emit(
          state.copyWith(status2: Status2.errorNetwork),
        );
      } else {
        emit(
          state.copyWith(status2: Status2.error),
        );
      }
    }, (data) {
      emit(
        state.copyWith(status2: Status2.success),
      );
    });
  }

  Future<void> _refresh(_refreshToken event, Emitter<AuthState> emit) async {
    await refreshUserTokenUsecase.call(null);
  }

  Future<void> _auth(_authicated event, Emitter<AuthState> emit) async {
    final recponce = await authicatedUsecase.call(null);
    if (recponce == true) {
      emit(state.copyWith(status: Status.success));
    } else {
      emit(state.copyWith(status: Status.error));
    }
  }
}
