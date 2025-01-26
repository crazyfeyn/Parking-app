import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/datasources/home_datasources.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';
import 'package:flutter_application/features/payment_screen/presentation/data/models/list_payment_methods.dart';
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
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> fetchSearchAllLocations(
      String title) async {
    try {
      final locations = await homeDatasources.fetchSearchAllLocations(title);
      return Right(locations);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LocationData>> getCurrentLocation() async {
    try {
      final locationData = await homeDatasources.getCurrentLocation();
      return Right(locationData);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<VehicleModel>>> fetchVehicleList() async {
    try {
      final vehicleList = await homeDatasources.fetchVehicleList();
      return Right(vehicleList);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createVehicle(VehicleModel vehicleModel) async {
    try {
      await homeDatasources.createVehicle(vehicleModel: vehicleModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<LocationModel>>> filterLocations({
    String? city,
    String? state,
    bool? truckAllowed,
    bool? trailerAllowed,
    bool? truckTrailerAllowed,
    bool? repairsAllowed,
    bool? lowboysAllowed,
    bool? oversizedAllowed,
    bool? hazmatAllowed,
    bool? doubleStackAllowed,
    bool? bobtailOnly,
    bool? containersOnly,
    bool? cameras,
    bool? fenced,
    bool? asphalt,
    bool? lights,
    bool? twentyFourHours,
    bool? limitedEntryExitTimes,
    bool? securityAtGate,
    bool? roamingSecurity,
    bool? landingGearSupportRequired,
    bool? laundryMachines,
    bool? freeShowers,
    bool? paidShowers,
    bool? repairShop,
    bool? paidContainerStackingServices,
    bool? trailerSnowScraper,
    bool? truckWash,
    bool? food,
    bool? noTowedVehicles,
  }) async {
    try {
      final filteredLocation = await homeDatasources.fetchBookingsWithFilters(
        city: city,
        state: state,
        truckAllowed: truckAllowed,
        trailerAllowed: trailerAllowed,
        truckTrailerAllowed: truckTrailerAllowed,
        repairsAllowed: repairsAllowed,
        lowboysAllowed: lowboysAllowed,
        oversizedAllowed: oversizedAllowed,
        hazmatAllowed: hazmatAllowed,
        doubleStackAllowed: doubleStackAllowed,
        bobtailOnly: bobtailOnly,
        containersOnly: containersOnly,
        cameras: cameras,
        fenced: fenced,
        asphalt: asphalt,
        lights: lights,
        twentyFourHours: twentyFourHours,
        limitedEntryExitTimes: limitedEntryExitTimes,
        securityAtGate: securityAtGate,
        roamingSecurity: roamingSecurity,
        landingGearSupportRequired: landingGearSupportRequired,
        laundryMachines: laundryMachines,
        freeShowers: freeShowers,
        paidShowers: paidShowers,
        repairShop: repairShop,
        paidContainerStackingServices: paidContainerStackingServices,
        trailerSnowScraper: trailerSnowScraper,
        truckWash: truckWash,
        food: food,
        noTowedVehicles: noTowedVehicles,
      );

      return Right(filteredLocation);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ListPaymentMethods>>>
      fetchPaymentMethods() async {
    try {
      final response = await homeDatasources.fetchPaymentMethods();
      return Right(response);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
