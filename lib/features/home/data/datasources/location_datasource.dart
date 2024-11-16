import 'package:location/location.dart';
import 'dart:async';

class LocationService {
  static final _location = Location();

  static Future<bool> _checkService() async {
    try {
      bool isServiceEnabled = await _location.serviceEnabled();
      print("Initial service status: $isServiceEnabled");
      
      if (!isServiceEnabled) {
        isServiceEnabled = await _location.requestService();
        print("After request service status: $isServiceEnabled");
      }
      return isServiceEnabled;
    } catch (e) {
      print("Error checking service: $e");
      return false;
    }
  }

  static Future<bool> _checkPermission() async {
    try {
      PermissionStatus permissionStatus = await _location.hasPermission();
      print("Initial permission status: $permissionStatus");
      
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _location.requestPermission();
        print("After request permission status: $permissionStatus");
      }
      return permissionStatus == PermissionStatus.granted;
    } catch (e) {
      print("Error checking permission: $e");
      return false;
    }
  }

  static Future<LocationData?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await _checkService();
      if (!serviceEnabled) {
        print("Location service is not enabled");
        return null;
      }

      bool permissionGranted = await _checkPermission();
      if (!permissionGranted) {
        print("Location permission not granted");
        return null;
      }

      print("Getting location...");
      
      // Configure location settings
      await _location.changeSettings(
        accuracy: LocationAccuracy.balanced,
        interval: 1000,
        distanceFilter: 10
      );

      // Create a completer to handle the first location update
      final completer = Completer<LocationData?>();
      
      // Create a timer for timeout
      Timer? timeoutTimer;
      StreamSubscription<LocationData>? subscription;

      // Set timeout
      timeoutTimer = Timer(const Duration(seconds: 15), () {
        print("Location request timed out");
        subscription?.cancel();
        if (!completer.isCompleted) {
          completer.complete(null);
        }
      });

      // Listen to location updates
      subscription = _location.onLocationChanged.listen(
        (LocationData locationData) {
          print("Received location update: ${locationData.latitude}, ${locationData.longitude}");
          timeoutTimer?.cancel();
          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete(locationData);
          }
        },
        onError: (error) {
          print("Location stream error: $error");
          timeoutTimer?.cancel();
          if (!completer.isCompleted) {
            completer.complete(null);
          }
        },
      );

      // Wait for the first location or timeout
      final locationData = await completer.future;

      if (locationData?.latitude == null || locationData?.longitude == null) {
        print("Invalid location data received");
        return null;
      }

      print("Location successfully received: ${locationData?.latitude}, ${locationData?.longitude}");
      return locationData;

    } catch (e) {
      print("Error in getCurrentLocation: $e");
      return null;
    }
  }
}