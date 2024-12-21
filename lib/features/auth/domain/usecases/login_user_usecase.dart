// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class LoginUserUsecase extends Usecase<void, LoginParams> {
  AuthRepositories authRepositories;
  LoginUserUsecase({
    required this.authRepositories,
  });
  @override
  Future<Either<Failure, void>> call(LoginParams params) {
    return authRepositories.logIn(params.password, params.email);
  }
}

class LoginParams {
  String email;
  String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}
