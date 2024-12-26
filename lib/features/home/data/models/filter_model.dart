class ParkingFilterModel {
  String? state;
  String? city;
  double miles;
  Map<String, bool> allowedServices;
  Map<String, bool> oneServiceAllowed;
  Map<String, bool> additionalServices;

  ParkingFilterModel._({
    this.state,
    this.city,
    this.miles = 5.0,
  })  : allowedServices = {
          'truckAllowed': false,
          'trailerAllowed': false,
          'truckTrailerAllowed': false,
          'repairsAllowed': false,
          'lowboysAllowed': false,
          'oversizedAllowed': false,
          'hazmatAllowed': false,
          'doubleStackAllowed': false,
        },
        oneServiceAllowed = {
          'bobtailOnly': false,
          'containersOnly': false,
        },
        additionalServices = {
          'cameras': false,
          'fenced': false,
          'asphalt': false,
          'lights': false,
          'twentyFourHours': false,
          'limitedEntryExitTimes': false,
          'securityAtGate': false,
          'roamingSecurity': false,
          'landingGearSupportRequired': false,
          'laundryMachines': false,
          'freeShowers': false,
          'paidShowers': false,
          'repairShop': false,
          'paidContainerStacking': false,
          'trailerSnowScraper': false,
          'truckWash': false,
          'food': false,
          'noTowedVehicles': false,
        };

  static ParkingFilterModel create() {
    return ParkingFilterModel._();
  }
}
