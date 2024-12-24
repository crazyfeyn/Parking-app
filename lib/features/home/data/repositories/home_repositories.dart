import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/home/data/datasources/home_datasources.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';
import 'package:location/location.dart';

class HomeRepositoriesImpl extends HomeRepositories {
  final HomeDatasources homeDatasources;

  HomeRepositoriesImpl({required this.homeDatasources});

  @override
  Future<Either<Failure, List<LocationModel>>> fetchAllLocations() async {
    try {
      return _fetchAllLocations(await homeDatasources.fetchAllLocations());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final locationData = await homeDatasources.getCurrentLocation();
      return _getCurrentLocation(locationData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<LocationModel>>> _fetchAllLocations(
      List<LocationModel> locationList) async {
    try {
      return Right(locationList);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, LocationData>> _getCurrentLocation(
      LocationData locationData) async {
    try {
      return Right(locationData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
