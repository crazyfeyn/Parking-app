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
  final LocationStatus? status; // Made nullable

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
    this.status, // Nullable
  });
}

class LocationImage {
  final int id;
  final String image;

  LocationImage({
    required this.id,
    required this.image,
  });
}

class LocationStatus {
  final int id;
  final String name;

  LocationStatus({
    required this.id,
    required this.name,
  });
}
