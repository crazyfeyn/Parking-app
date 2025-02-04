import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/payment_screen/presentation/data/models/list_payment_methods.dart';
import 'package:location/location.dart';

abstract class HomeRepositories {
  Future<Either<Failure, LocationData>> getCurrentLocation();
  Future<Either<Failure, List<LocationModel>>> fetchAllLocations();
  Future<Either<Failure, List<LocationModel>>> fetchSearchAllLocations(
      String title);
  Future<Either<Failure, List<VehicleModel>>> fetchVehicleList();
  Future<Either<Failure, void>> createVehicle(VehicleModel vehicleModel);
  Future<Either<Failure, void>> updateVehicle(VehicleModel vehicleModel);
  Future<Either<Failure, List<ListPaymentMethods>>> fetchPaymentMethods();
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
  });
}
