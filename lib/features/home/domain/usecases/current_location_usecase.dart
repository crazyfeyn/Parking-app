import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';

class CurrentLocationUsecase extends Usecase {
  HomeRepositories homeRepositories;
  CurrentLocationUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return homeRepositories.getCurrentLocation();
  }
}
