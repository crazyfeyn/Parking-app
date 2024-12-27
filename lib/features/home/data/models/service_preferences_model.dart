class ServicePreferences {
  final bool truckAllowed;
  final bool trailerAllowed;
  final bool truckTrailerAllowed;
  final bool repairsAllowed;
  final bool lowboysAllowed;
  final bool oversizedAllowed;
  final bool hazmatAllowed;
  final bool doubleStackAllowed;
  final bool bobtailOnly;
  final bool containersOnly;
  final bool cameras;
  final bool fenced;
  final bool asphalt;
  final bool lights;
  final bool twentyFourHours;
  final bool limitedEntryExitTimes;
  final bool securityAtGate;
  final bool roamingSecurity;
  final bool landingGearSupportRequired;
  final bool laundryMachines;
  final bool freeShowers;
  final bool paidShowers;
  final bool repairShop;
  final bool paidContainerStackingServices;
  final bool trailerSnowScraper;
  final bool food;
  final bool noTowedVehicles;
  final String city;
  final String state;

  const ServicePreferences({
    this.truckAllowed = false,
    this.trailerAllowed = false,
    this.truckTrailerAllowed = false,
    this.repairsAllowed = false,
    this.lowboysAllowed = false,
    this.oversizedAllowed = false,
    this.hazmatAllowed = false,
    this.doubleStackAllowed = false,
    this.bobtailOnly = false,
    this.containersOnly = false,
    this.cameras = false,
    this.fenced = false,
    this.asphalt = false,
    this.lights = false,
    this.twentyFourHours = false,
    this.limitedEntryExitTimes = false,
    this.securityAtGate = false,
    this.roamingSecurity = false,
    this.landingGearSupportRequired = false,
    this.laundryMachines = false,
    this.freeShowers = false,
    this.paidShowers = false,
    this.repairShop = false,
    this.paidContainerStackingServices = false,
    this.trailerSnowScraper = false,
    this.food = false,
    this.noTowedVehicles = false,
    this.city = '',
    this.state = '',
  });
}
