class LocationModel {
  final int id;
  final String name;
  final String description;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String phNumber;
  final String schedule;
  final double weeklyRate;
  final double dailyRate;
  final double monthlyRate;
  final bool twentyFourHours;
  final bool limitedEntryExitTimes;
  final bool lowboysAllowed;
  final bool bobtailOnly;
  final bool containersOnly;
  final bool oversizedAllowed;
  final bool hazmatAllowed;
  final bool doubleStackAllowed;
  final bool securityAtGate;
  final bool roamingSecurity;
  final bool landingGearSupportRequired;
  final bool laundryMachines;
  final bool freeShowers;
  final bool paidShowers;
  final bool repairShop;
  final bool paidContainerStackingServices;
  final bool trailerSnowScraper;
  final bool truckWash;
  final bool food;
  final bool noTowedVehicles;
  final String email;
  final bool truckAllowed;
  final bool trailerAllowed;
  final bool truckTrailerAllowed;
  final bool cameras;
  final bool fenced;
  final bool asphalt;
  final bool lights;
  final bool repairsAllowed;
  final List<LocationImage>? images;
  final double? longitude;
  final double? latitude;
  final bool? bankAccountAdded;
  final int? availableSpots;
  final LocationStatus? status;

  LocationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phNumber,
    required this.schedule,
    required this.weeklyRate,
    required this.dailyRate,
    required this.monthlyRate,
    required this.twentyFourHours,
    required this.limitedEntryExitTimes,
    required this.lowboysAllowed,
    required this.bobtailOnly,
    required this.containersOnly,
    required this.oversizedAllowed,
    required this.hazmatAllowed,
    required this.doubleStackAllowed,
    required this.securityAtGate,
    required this.roamingSecurity,
    required this.landingGearSupportRequired,
    required this.laundryMachines,
    required this.freeShowers,
    required this.paidShowers,
    required this.repairShop,
    required this.paidContainerStackingServices,
    required this.trailerSnowScraper,
    required this.truckWash,
    required this.food,
    required this.noTowedVehicles,
    required this.email,
    required this.truckAllowed,
    required this.trailerAllowed,
    required this.truckTrailerAllowed,
    required this.cameras,
    required this.fenced,
    required this.asphalt,
    required this.lights,
    required this.repairsAllowed,
    this.images,
    this.longitude,
    this.latitude,
    this.bankAccountAdded,
    this.availableSpots,
    this.status,
  });

  // Factory constructor to parse JSON
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      phNumber: json['ph_number'],
      schedule: json['schedule'],
      weeklyRate: (json['weekly_rate'] ?? 0).toDouble(),
      dailyRate: (json['daily_rate'] ?? 0).toDouble(),
      monthlyRate: (json['monthly_rate'] ?? 0).toDouble(),
      twentyFourHours: json['twenty_four_hours'],
      limitedEntryExitTimes: json['limited_entry_exit_times'],
      lowboysAllowed: json['lowboys_allowed'],
      bobtailOnly: json['bobtail_only'],
      containersOnly: json['containers_only'],
      oversizedAllowed: json['oversized_allowed'],
      hazmatAllowed: json['hazmat_allowed'],
      doubleStackAllowed: json['double_stack_allowed'],
      securityAtGate: json['security_at_gate'],
      roamingSecurity: json['roaming_security'],
      landingGearSupportRequired: json['landing_gear_support_required'],
      laundryMachines: json['laundry_machines'],
      freeShowers: json['free_showers'],
      paidShowers: json['paid_showers'],
      repairShop: json['repair_shop'],
      paidContainerStackingServices: json['paid_container_stacking_services'],
      trailerSnowScraper: json['trailer_snow_scraper'],
      truckWash: json['truck_wash'],
      food: json['food'],
      noTowedVehicles: json['no_towed_vehicles'],
      email: json['email'],
      truckAllowed: json['truck_allowed'],
      trailerAllowed: json['trailer_allowed'],
      truckTrailerAllowed: json['truck_trailer_allowed'],
      cameras: json['cameras'],
      fenced: json['fenced'],
      asphalt: json['asphalt'],
      lights: json['lights'],
      repairsAllowed: json['repairs_allowed'],
      images: json['images'] != null
          ? (json['images'] as List)
              .map((image) => LocationImage.fromJson(image))
              .toList()
          : null,
      longitude:
          (json['longitude'] != null) ? double.parse(json['longitude']) : null,
      latitude:
          (json['latitude'] != null) ? double.parse(json['latitude']) : null,
      bankAccountAdded: json['bank_account_details'] != null,
      availableSpots: json['available_spots'],
      status: json['status'] != null
          ? LocationStatus.fromJson(json['status'])
          : null,
    );
  }
}

class LocationImage {
  final int id;
  final String image;

  LocationImage({
    required this.id,
    required this.image,
  });

  // Factory constructor to parse JSON
  factory LocationImage.fromJson(Map<String, dynamic> json) {
    return LocationImage(
      id: json['id'],
      image: json['image'],
    );
  }
}

class LocationStatus {
  final int id;
  final String name;

  LocationStatus({
    required this.id,
    required this.name,
  });

  // Factory constructor to parse JSON
  factory LocationStatus.fromJson(Map<String, dynamic> json) {
    return LocationStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}
