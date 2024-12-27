import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/data/models/profile_model.dart';

class GetProfileUsecase extends Usecase<ProfileModel, NoParams> {
  final ProfileRepositories profileRepositories;

  GetProfileUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, ProfileModel>> call(NoParams params) {
    return profileRepositories.getProfile();
  }
}

class NoParams {}
