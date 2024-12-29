import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';

class GetProfileUsecase extends Usecase<ProfileEntity, NoParams> {
  final ProfileRepositories profileRepositories;

  GetProfileUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) {
    return profileRepositories.getProfile();
  }
}

class NoParams {}
