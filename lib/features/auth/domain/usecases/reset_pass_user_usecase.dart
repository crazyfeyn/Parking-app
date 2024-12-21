// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class ResetPassUserUsecase extends Usecase<void, String> {
  AuthRepositories authRepositories;
  ResetPassUserUsecase({
    required this.authRepositories,
  });
  @override
  Future<Either<Failure, void>> call(String params) {
    return authRepositories.resetPass(params);
  }
}
