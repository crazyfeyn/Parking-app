import 'package:dartz/dartz.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/core/usecases/usecase.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';

class FilterLocationsUsecase
    extends Usecase<List<LocationModel>, FilterLocationsParams> {
  final HomeRepositories homeRepositories;
  FilterLocationsUsecase({required this.homeRepositories});

  @override
  Future<Either<Failure, List<LocationModel>>> call(
      FilterLocationsParams params) {
    return homeRepositories.filterLocations(
      city: params.city,
      state: params.state,
      truckAllowed: params.truckAllowed,
      trailerAllowed: params.trailerAllowed,
      truckTrailerAllowed: params.truckTrailerAllowed,
      repairsAllowed: params.repairsAllowed,
      lowboysAllowed: params.lowboysAllowed,
      oversizedAllowed: params.oversizedAllowed,
      hazmatAllowed: params.hazmatAllowed,
      doubleStackAllowed: params.doubleStackAllowed,
      bobtailOnly: params.bobtailOnly,
      containersOnly: params.containersOnly,
      cameras: params.cameras,
      fenced: params.fenced,
      asphalt: params.asphalt,
      lights: params.lights,
      twentyFourHours: params.twentyFourHours,
      limitedEntryExitTimes: params.limitedEntryExitTimes,
      securityAtGate: params.securityAtGate,
      roamingSecurity: params.roamingSecurity,
      landingGearSupportRequired: params.landingGearSupportRequired,
      laundryMachines: params.laundryMachines,
      freeShowers: params.freeShowers,
      paidShowers: params.paidShowers,
      repairShop: params.repairShop,
      paidContainerStackingServices: params.paidContainerStackingServices,
      trailerSnowScraper: params.trailerSnowScraper,
      truckWash: params.truckWash,
      food: params.food,
      noTowedVehicles: params.noTowedVehicles,
    );
  }
}

class FilterLocationsParams {
  final String? city;
  final String? state;
  final bool? truckAllowed;
  final bool? trailerAllowed;
  final bool? truckTrailerAllowed;
  final bool? repairsAllowed;
  final bool? lowboysAllowed;
  final bool? oversizedAllowed;
  final bool? hazmatAllowed;
  final bool? doubleStackAllowed;
  final bool? bobtailOnly;
  final bool? containersOnly;
  final bool? cameras;
  final bool? fenced;
  final bool? asphalt;
  final bool? lights;
  final bool? twentyFourHours;
  final bool? limitedEntryExitTimes;
  final bool? securityAtGate;
  final bool? roamingSecurity;
  final bool? landingGearSupportRequired;
  final bool? laundryMachines;
  final bool? freeShowers;
  final bool? paidShowers;
  final bool? repairShop;
  final bool? paidContainerStackingServices;
  final bool? trailerSnowScraper;
  final bool? truckWash;
  final bool? food;
  final bool? noTowedVehicles;

  FilterLocationsParams({
    this.city,
    this.state,
    this.truckAllowed,
    this.trailerAllowed,
    this.truckTrailerAllowed,
    this.repairsAllowed,
    this.lowboysAllowed,
    this.oversizedAllowed,
    this.hazmatAllowed,
    this.doubleStackAllowed,
    this.bobtailOnly,
    this.containersOnly,
    this.cameras,
    this.fenced,
    this.asphalt,
    this.lights,
    this.twentyFourHours,
    this.limitedEntryExitTimes,
    this.securityAtGate,
    this.roamingSecurity,
    this.landingGearSupportRequired,
    this.laundryMachines,
    this.freeShowers,
    this.paidShowers,
    this.repairShop,
    this.paidContainerStackingServices,
    this.trailerSnowScraper,
    this.truckWash,
    this.food,
    this.noTowedVehicles,
  });
}
