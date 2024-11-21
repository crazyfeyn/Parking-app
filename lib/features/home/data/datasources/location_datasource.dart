import 'package:location/location.dart';

class LocationService {
  static final Location _location = Location();

  static Future<LocationData> getCurrentLocation() async {
    try {
      print('Checking location service...');
      final isServiceEnabled = await _location.serviceEnabled();
      print('Location service enabled: $isServiceEnabled');

      if (!isServiceEnabled) {
        print('Requesting location service...');
        final serviceRequested = await _location.requestService();
        print('Service request result: $serviceRequested');
        if (!serviceRequested) {
          throw Exception('Location services are disabled.');
        }
      }

      print('Checking location permissions...');
      final permissionStatus = await _location.hasPermission();
      print('Permission status: $permissionStatus');

      if (permissionStatus == PermissionStatus.denied) {
        print('Requesting location permission...');
        final permissionRequested = await _location.requestPermission();
        print('Permission request result: $permissionRequested');
        if (permissionRequested != PermissionStatus.granted) {
          throw Exception('Location permissions are denied.');
        }
      } else if (permissionStatus == PermissionStatus.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      print('Attempting to get current location...');
      final currentLocation = await _location.getLocation();
      print('Current location received: $currentLocation');

      if (currentLocation.latitude == null || currentLocation.longitude == null) {
        throw Exception('Failed to retrieve location.');
      }

      print('Latitude: ${currentLocation.latitude}');
      print('Longitude: ${currentLocation.longitude}');

      return currentLocation;
    } on Exception catch (e) {
      print('Detailed Error in LocationService: $e');

      // Handle specific errors
      if (e.toString().contains('Location services are disabled')) {
        throw Exception('Please enable location services in your device settings.');
      }
      if (e.toString().contains('Location permissions are denied')) {
        throw Exception('Please grant location permissions to the app.');
      }

      // Re-throw any other unhandled exceptions
      rethrow;
    } catch (e) {
      print('Unexpected Error: $e');
      throw Exception('An unexpected error occurred while fetching location.');
    }
  }
}
