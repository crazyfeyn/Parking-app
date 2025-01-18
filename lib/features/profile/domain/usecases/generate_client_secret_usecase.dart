import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/domain/usecases/get_profile_usecase.dart';

class GenerateClientSecretKeyUsecase implements Usecase<String, NoParams> {
  final ProfileRepositories profileRepositories;

  GenerateClientSecretKeyUsecase({required this.profileRepositories});

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await profileRepositories.generateClientSecretKey();
  }
}
