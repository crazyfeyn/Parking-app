// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repositories.dart';

class LogOutUsecase extends Usecase<void, void> {
  AuthRepositoriesImpl authRepositoriesImpl;
  LogOutUsecase({
    required this.authRepositoriesImpl,
  });
  @override
  Future<Either<Failure, void>> call(void params) {
    return authRepositoriesImpl.logOut();
  }
}
