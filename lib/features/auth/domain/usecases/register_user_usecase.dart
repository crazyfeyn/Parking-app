// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUserUsecase extends Usecase<void, RegisterParams> {
  AuthRepositories authRepositories;
  RegisterUserUsecase({
    required this.authRepositories,
  });
  @override
  Future<Either<Failure, void>> call(RegisterParams params) {
    return authRepositories.register(params.password, params.email);
  }
}

class RegisterParams {
  String email;
  String password;
  RegisterParams({
    required this.email,
    required this.password,
  });
}
