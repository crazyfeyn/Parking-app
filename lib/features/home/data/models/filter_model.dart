// filter_model.dart
import 'package:flutter_application/features/home/domain/usecases/filter_locations_usecase.dart';

class FilterModel {
  String? city;
  String? state;
  bool? truckAllowed;
  bool? trailerAllowed;
  bool? truckTrailerAllowed;
  bool? repairsAllowed;
  bool? lowboysAllowed;
  bool? oversizedAllowed;
  bool? hazmatAllowed;
  bool? doubleStackAllowed;
  bool? bobtailOnly;
  bool? containersOnly;
  bool? cameras;
  bool? fenced;
  bool? asphalt;
  bool? lights;
  bool? twentyFourHours;
  bool? limitedEntryExitTimes;
  bool? securityAtGate;
  bool? roamingSecurity;
  bool? landingGearSupportRequired;
  bool? laundryMachines;
  bool? freeShowers;
  bool? paidShowers;
  bool? repairShop;
  bool? paidContainerStackingServices;
  bool? trailerSnowScraper;
  bool? truckWash;
  bool? food;
  bool? noTowedVehicles;

  // Initialize maps with default values
  Map<String, bool> allowedServices = {
    'Truck': false,
    'Trailer': false,
    'Truck & Trailer': false,
    'Repairs': false,
    'Lowboys': false,
    'Oversized': false,
  };

  Map<String, bool> oneServiceAllowed = {
    'Hazmat': false,
    'Double Stack': false,
    'Bobtail Only': false,
    'Containers Only': false,
  };

  Map<String, bool> additionalServices = {
    'Cameras': false,
    'Fenced': false,
    'Asphalt': false,
    'Lights': false,
    '24 Hours': false,
    'Limited Entry/Exit Times': false,
    'Security at Gate': false,
    'Roaming Security': false,
    'Landing Gear Support Required': false,
    'Laundry Machines': false,
    'Free Showers': false,
    'Paid Showers': false,
    'Repair Shop': false,
    'Paid Container Stacking Services': false,
    'Trailer Snow Scraper': false,
    'Truck Wash': false,
    'Food': false,
    'No Towed Vehicles': false,
  };

  FilterModel({
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
  }) {
    // Initialize the maps based on the passed values
    if (truckAllowed != null) allowedServices['Truck'] = truckAllowed!;
    if (trailerAllowed != null) allowedServices['Trailer'] = trailerAllowed!;
    if (truckTrailerAllowed != null) {
      allowedServices['Truck & Trailer'] = truckTrailerAllowed!;
    }
    if (repairsAllowed != null) allowedServices['Repairs'] = repairsAllowed!;
    if (lowboysAllowed != null) allowedServices['Lowboys'] = lowboysAllowed!;
    if (oversizedAllowed != null) {
      allowedServices['Oversized'] = oversizedAllowed!;
    }

    if (hazmatAllowed != null) oneServiceAllowed['Hazmat'] = hazmatAllowed!;
    if (doubleStackAllowed != null) {
      oneServiceAllowed['Double Stack'] = doubleStackAllowed!;
    }
    if (bobtailOnly != null) oneServiceAllowed['Bobtail Only'] = bobtailOnly!;
    if (containersOnly != null) {
      oneServiceAllowed['Containers Only'] = containersOnly!;
    }

    if (cameras != null) additionalServices['Cameras'] = cameras!;
    if (fenced != null) additionalServices['Fenced'] = fenced!;
    if (asphalt != null) additionalServices['Asphalt'] = asphalt!;
    if (lights != null) additionalServices['Lights'] = lights!;
    if (twentyFourHours != null) {
      additionalServices['24 Hours'] = twentyFourHours!;
    }
    if (limitedEntryExitTimes != null) {
      additionalServices['Limited Entry/Exit Times'] = limitedEntryExitTimes!;
    }
    if (securityAtGate != null) {
      additionalServices['Security at Gate'] = securityAtGate!;
    }
    if (roamingSecurity != null) {
      additionalServices['Roaming Security'] = roamingSecurity!;
    }
    if (landingGearSupportRequired != null) {
      additionalServices['Landing Gear Support Required'] =
          landingGearSupportRequired!;
    }
    if (laundryMachines != null) {
      additionalServices['Laundry Machines'] = laundryMachines!;
    }
    if (freeShowers != null) additionalServices['Free Showers'] = freeShowers!;
    if (paidShowers != null) additionalServices['Paid Showers'] = paidShowers!;
    if (repairShop != null) additionalServices['Repair Shop'] = repairShop!;
    if (paidContainerStackingServices != null) {
      additionalServices['Paid Container Stacking Services'] =
          paidContainerStackingServices!;
    }
    if (trailerSnowScraper != null) {
      additionalServices['Trailer Snow Scraper'] = trailerSnowScraper!;
    }
    if (truckWash != null) additionalServices['Truck Wash'] = truckWash!;
    if (food != null) additionalServices['Food'] = food!;
    if (noTowedVehicles != null) {
      additionalServices['No Towed Vehicles'] = noTowedVehicles!;
    }
  }

  Map<String, dynamic> toQueryParameters() {
    return {
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (truckAllowed != null) 'truck_allowed': truckAllowed,
      if (trailerAllowed != null) 'trailer_allowed': trailerAllowed,
      if (truckTrailerAllowed != null)
        'truck_trailer_allowed': truckTrailerAllowed,
      if (repairsAllowed != null) 'repairs_allowed': repairsAllowed,
      if (lowboysAllowed != null) 'lowboys_allowed': lowboysAllowed,
      if (oversizedAllowed != null) 'oversized_allowed': oversizedAllowed,
      if (hazmatAllowed != null) 'hazmat_allowed': hazmatAllowed,
      if (doubleStackAllowed != null)
        'double_stack_allowed': doubleStackAllowed,
      if (bobtailOnly != null) 'bobtail_only': bobtailOnly,
      if (containersOnly != null) 'containers_only': containersOnly,
      if (cameras != null) 'cameras': cameras,
      if (fenced != null) 'fenced': fenced,
      if (asphalt != null) 'asphalt': asphalt,
      if (lights != null) 'lights': lights,
      if (twentyFourHours != null) 'twenty_four_hours': twentyFourHours,
      if (limitedEntryExitTimes != null)
        'limited_entry_exit_times': limitedEntryExitTimes,
      if (securityAtGate != null) 'security_at_gate': securityAtGate,
      if (roamingSecurity != null) 'roaming_security': roamingSecurity,
      if (landingGearSupportRequired != null)
        'landing_gear_support_required': landingGearSupportRequired,
      if (laundryMachines != null) 'laundry_machines': laundryMachines,
      if (freeShowers != null) 'free_showers': freeShowers,
      if (paidShowers != null) 'paid_showers': paidShowers,
      if (repairShop != null) 'repair_shop': repairShop,
      if (paidContainerStackingServices != null)
        'paid_container_stacking_services': paidContainerStackingServices,
      if (trailerSnowScraper != null)
        'trailer_snow_scraper': trailerSnowScraper,
      if (truckWash != null) 'truck_wash': truckWash,
      if (food != null) 'food': food,
      if (noTowedVehicles != null) 'no_towed_vehicles': noTowedVehicles,
    };
  }

  FilterLocationsParams toFilterLocationsParams() {
    return FilterLocationsParams(
      city: city,
      state: state,
      truckAllowed: allowedServices['Truck'],
      trailerAllowed: allowedServices['Trailer'],
      truckTrailerAllowed: allowedServices['Truck & Trailer'],
      repairsAllowed: allowedServices['Repairs'],
      lowboysAllowed: allowedServices['Lowboys'],
      oversizedAllowed: allowedServices['Oversized'],
      hazmatAllowed: oneServiceAllowed['Hazmat'],
      doubleStackAllowed: oneServiceAllowed['Double Stack'],
      bobtailOnly: oneServiceAllowed['Bobtail Only'],
      containersOnly: oneServiceAllowed['Containers Only'],
      cameras: additionalServices['Cameras'],
      fenced: additionalServices['Fenced'],
      asphalt: additionalServices['Asphalt'],
      lights: additionalServices['Lights'],
      twentyFourHours: additionalServices['24 Hours'],
      limitedEntryExitTimes: additionalServices['Limited Entry/Exit Times'],
      securityAtGate: additionalServices['Security at Gate'],
      roamingSecurity: additionalServices['Roaming Security'],
      landingGearSupportRequired:
          additionalServices['Landing Gear Support Required'],
      laundryMachines: additionalServices['Laundry Machines'],
      freeShowers: additionalServices['Free Showers'],
      paidShowers: additionalServices['Paid Showers'],
      repairShop: additionalServices['Repair Shop'],
      paidContainerStackingServices:
          additionalServices['Paid Container Stacking Services'],
      trailerSnowScraper: additionalServices['Trailer Snow Scraper'],
      truckWash: additionalServices['Truck Wash'],
      food: additionalServices['Food'],
      noTowedVehicles: additionalServices['No Towed Vehicles'],
    );
  }
}
