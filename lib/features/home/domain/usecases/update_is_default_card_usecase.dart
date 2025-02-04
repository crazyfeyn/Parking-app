import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';

class UpdateIsDefaultCardUsecase extends Usecase {
  HomeRepositories homeRepositories;
  UpdateIsDefaultCardUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, void>> call(params) {
    return homeRepositories.updateIsDefaultCard(params);
  }
}
