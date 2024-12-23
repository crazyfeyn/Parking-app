import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';

class FetchLocationsUsecase extends Usecase {
  HomeRepositories homeRepositories;

  FetchLocationsUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return homeRepositories.fetchAllLocations();
  }
}
