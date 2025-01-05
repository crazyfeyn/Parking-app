import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:location/location.dart';

abstract class HomeRepositories {
  Future<Either<Failure, LocationData>> getCurrentLocation();
  Future<Either<Failure, List<LocationModel>>> fetchAllLocations();
  Future<Either<Failure, List<LocationModel>>> fetchSearchAllLocations(String title);
  Future<Either<Failure, List<VehicleModel>>> fetchVehicleList();
  Future<Either<Failure, void>> createVehicle(VehicleModel vehicleModel);
}
