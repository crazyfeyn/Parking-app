part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState(
    {
      @Default(Status.initial) Status status,
      @Default(Status2.initial) Status2 status2,
      @Default(Status3.initial) Status3 status3,



    }
  ) = _AuthState;
}
