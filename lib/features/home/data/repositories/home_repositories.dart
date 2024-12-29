import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/home/data/datasources/home_datasources.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';
import 'package:flutter_application/features/profile/data/models/vehicle_model.dart';
import 'package:location/location.dart';

class HomeRepositoriesImpl extends HomeRepositories {
  final HomeDatasources homeDatasources;

  HomeRepositoriesImpl({required this.homeDatasources});

  @override
  Future<Either<Failure, List<LocationModel>>> fetchAllLocations() async {
    try {
      final locations = await homeDatasources.fetchAllLocations();
      return Right(locations);
    } catch (e) {
      print('Error fetching locations: $e');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final locationData = await homeDatasources.getCurrentLocation();
      return Right(locationData);
    } catch (e) {
      print('Error getting current location: $e');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<VehicleModel>>> fetchVehicleList() async {
    try {
      final vehicleList = await homeDatasources.fetchVehicleList();
      return Right(vehicleList);
    } catch (e) {
      print('Error fetching vehicle list: $e');
      return Left(CacheFailure());
    }
  }
}
