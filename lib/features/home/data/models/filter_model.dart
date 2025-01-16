class FilterModel {
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
  });

  /// Converts the filter model to a map of query parameters.
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
}
