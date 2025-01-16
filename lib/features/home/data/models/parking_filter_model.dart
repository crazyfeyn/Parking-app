class ParkingFilterModel {
  String? city;
  String? state;
  double? miles;
  Map<String, bool> allowedServices;
  Map<String, bool> oneServiceAllowed;
  Map<String, bool> additionalServices;

  ParkingFilterModel({
    this.city,
    this.state,
    this.miles,
    required this.allowedServices,
    required this.oneServiceAllowed,
    required this.additionalServices,
  });

  /// Factory method to create a default instance of `ParkingFilterModel`.
  factory ParkingFilterModel.create() {
    return ParkingFilterModel(
      city: null,
      state: null,
      miles: null,
      allowedServices: {
        'truckAllowed': false,
        'trailerAllowed': false,
        'truckTrailerAllowed': false,
        'repairsAllowed': false,
        'lowboysAllowed': false,
        'oversizedAllowed': false,
        'hazmatAllowed': false,
        'doubleStackAllowed': false,
      },
      oneServiceAllowed: {
        'bobtailOnly': false,
        'containersOnly': false,
      },
      additionalServices: {
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
        'paidContainerStackingServices': false,
        'trailerSnowScraper': false,
        'truckWash': false,
        'food': false,
        'noTowedVehicles': false,
      },
    );
  }

  /// Converts the filter model to a map of query parameters.
  Map<String, dynamic> toQueryParameters() {
    return {
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (miles != null) 'miles': miles,
      ..._convertServiceMapToQueryParams('allowed_services', allowedServices),
      ..._convertServiceMapToQueryParams(
          'one_service_allowed', oneServiceAllowed),
      ..._convertServiceMapToQueryParams(
          'additional_services', additionalServices),
    };
  }

  /// Helper method to convert a service map to query parameters.
  Map<String, dynamic> _convertServiceMapToQueryParams(
      String prefix, Map<String, bool> services) {
    final Map<String, dynamic> params = {};
    services.forEach((key, value) {
      if (value != null) {
        params['$prefix.$key'] = value;
      }
    });
    return params;
  }

  @override
  String toString() {
    return 'ParkingFilterModel(city: $city, state: $state, miles: $miles, allowedServices: $allowedServices, oneServiceAllowed: $oneServiceAllowed, additionalServices: $additionalServices)';
  }
}
