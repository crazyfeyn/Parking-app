import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';

class ChangePasswordUsecase extends Usecase<void, ChangePasswordParams> {
  final ProfileRepositories profileRepositories;

  ChangePasswordUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, dynamic>> call(ChangePasswordParams params) {
    return profileRepositories.changePassword(
        params.oldPassword, params.newPassword);
  }
}

class ChangePasswordParams {
  String oldPassword;
  String newPassword;

  ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });
}
