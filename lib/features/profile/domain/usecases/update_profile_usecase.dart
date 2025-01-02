import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';

class UpdateProfileUsecase extends Usecase<void, UpdateProfileParams> {
  final ProfileRepositories profileRepositories;

  UpdateProfileUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) {
    return profileRepositories.updateProfile(
      name: params.name,
      surname: params.surname,
      email: params.email,
    );
  }
}

class UpdateProfileParams {
  final String name;
  final String surname;
  final String email;

  UpdateProfileParams({required this.name,required this.surname,required this.email});
}
