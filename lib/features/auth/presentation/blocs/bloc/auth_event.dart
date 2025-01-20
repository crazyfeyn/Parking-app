part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.logIn(String password,String email) = _log;
  const factory AuthEvent.register(String password,String email,String name,String surname) = _reg;
  const factory AuthEvent.change(String oldPass,String newPass) = _changePass;
  const factory AuthEvent.reset(String email) = _resetPass;
  const factory AuthEvent.logOut() = _logOut;
  const factory AuthEvent.refresh() = _refreshToken;
  const factory AuthEvent.stop() = _stopToken;
  const factory AuthEvent.authicated() = _authicated;
  const factory AuthEvent.doInitial() = _initial;

}