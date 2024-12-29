// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/auth/domain/repositories/auth_repositories.dart';

class ChangePasswordUsecase extends Usecase<void, ChangePassParams> {
  AuthRepositories authRepositories;
  ChangePasswordUsecase({
    required this.authRepositories,
  });
  @override
  Future<Either<Failure, void>> call(ChangePassParams params) {
    return authRepositories.changePass(params.oldPass, params.newPass);
  }
}

class ChangePassParams {
  String oldPass;
  String newPass;
  ChangePassParams({
    required this.oldPass,
    required this.newPass,
  });
}
