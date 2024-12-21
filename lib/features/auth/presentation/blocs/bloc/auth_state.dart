part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState(
    {
      @Default(Status.initial) Status status,
    }
  ) = _AuthState;
}
