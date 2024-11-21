import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  static final Location _location = Location();

  static Future<LocationData> getCurrentLocation() async {
    try {
      // Configure location accuracy and interval
      _location.changeSettings(
          accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 10);

      // Wait a bit to get location
      return await Future.any([
        _location.getLocation(),
        Future.delayed(const Duration(seconds: 10),
            () => throw TimeoutException('Location retrieval timed out'))
      ]);
    } catch (e) {
      print('Location retrieval error: $e');
      rethrow;
    }
  }
}
