import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';

class FetchLocationsUsecase extends Usecase<List<LocationModel>, String> {
  HomeRepositories homeRepositories;

  FetchLocationsUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, List<LocationModel>>> call(params) {
    return homeRepositories.fetchAllLocations(params);
  }
}
