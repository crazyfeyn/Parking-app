import 'package:location/location.dart';

class LocationService {
  static final Location _location = Location();

  static bool _isServiceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;
  static LocationData? _currentLocation;

  /// Check if location services are enabled.
  static Future<void> _checkService() async {
    _isServiceEnabled = await _location.serviceEnabled();
    print('Service enabled: $_isServiceEnabled');
    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      print('Requested service: $_isServiceEnabled');
      if (!_isServiceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }
  }

  /// Check and request location permissions.
  static Future<void> _checkPermission() async {
    _permissionStatus = await _location.hasPermission();
    print('Permission status: $_permissionStatus');
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      print('Requested permission: $_permissionStatus');
      if (_permissionStatus != PermissionStatus.granted) {
        throw Exception('Location permissions are denied.');
      }
    } else if (_permissionStatus == PermissionStatus.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  }

  /// Get the current location.
  static Future<LocationData> getCurrentLocation() async {
    try {
      // Ensure service and permissions are enabled.
      await _checkService();
      await _checkPermission();

      // Fetch location data.
      print('Fetching current location...');
      _currentLocation = await _location.getLocation();
      print('Location fetched: $_currentLocation');

      if (_currentLocation == null) {
        throw Exception('Failed to get current location.');
      }
      return _currentLocation!;
    } catch (e) {
      print('Error occurred: $e');
      rethrow;
    }
  }
}
