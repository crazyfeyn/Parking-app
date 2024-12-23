import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:location/location.dart';

class HomeDatasources {
  Future<LocationData> getCurrentLocation() async {
    final Location _location = Location();
    try {
      final isServiceEnabled = await _location.serviceEnabled();
      if (!isServiceEnabled) {
        final serviceRequested = await _location.requestService();
        if (!serviceRequested) {
          throw LocationException();
        }
      }

      final permissionStatus = await _location.hasPermission();
      print(permissionStatus);
      if (permissionStatus == PermissionStatus.denied) {
        final permissionRequested = await _location.requestPermission();
        if (permissionRequested != PermissionStatus.granted) {
          throw Exception('Location permissions are denied.');
        }
      } else if (permissionStatus == PermissionStatus.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      final currentLocation = await _location.getLocation();
      if (currentLocation.latitude == null ||
          currentLocation.longitude == null) {
        throw Exception('Failed to retrieve location.');
      }

      return currentLocation; // Return the location data
    } catch (e) {
      throw ServerException(); // Catch any exceptions
    }
  }

  Future<List<LocationModel>> fetchAllLocations() async {
    try {
      final dioConfig = DioConfig();
      final response = await dioConfig.client.get(
        '${AppConstants.baseseconUrl}locations/list',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        final List<LocationModel> locations = data.map((json) {
          return LocationModel(
            id: json['id'] as int,
            name: json['name'] as String,
            description: json['description'] as String,
            address: json['address'] as String,
            city: json['city'] as String,
            state: json['state'] as String,
            zipCode: json['zip_code'] as String,
            phNumber: json['ph_number'] as String,
            schedule: json['schedule'] as String?,
            weeklyRate: double.parse(json['weekly_rate']),
            dailyRate: double.parse(json['daily_rate']),
            monthlyRate: double.parse(json['monthly_rate']),
            twentyFourHours: json['twenty_four_hours'] as bool,
            limitedEntryExitTimes: json['limited_entry_exit_times'] as bool,
            lowboysAllowed: json['lowboys_allowed'] as bool,
            bobtailOnly: json['bobtail_only'] as bool,
            containersOnly: json['containers_only'] as bool,
            oversizedAllowed: json['oversized_allowed'] as bool,
            hazmatAllowed: json['hazmat_allowed'] as bool,
            doubleStackAllowed: json['double_stack_allowed'] as bool,
            securityAtGate: json['security_at_gate'] as bool,
            roamingSecurity: json['roaming_security'] as bool,
            landingGearSupportRequired:
                json['landing_gear_support_required'] as bool,
            laundryMachines: json['laundry_machines'] as bool,
            freeShowers: json['free_showers'] as bool,
            paidShowers: json['paid_showers'] as bool,
            repairShop: json['repair_shop'] as bool,
            paidContainerStackingServices:
                json['paid_container_stacking_services'] as bool,
            trailerSnowScraper: json['trailer_snow_scraper'] as bool,
            truckWash: json['truck_wash'] as bool,
            food: json['food'] as bool,
            noTowedVehicles: json['no_towed_vehicles'] as bool,
            email: json['email'] as String,
            truckAllowed: json['truck_allowed'] as bool,
            trailerAllowed: json['trailer_allowed'] as bool,
            truckTrailerAllowed: json['truck_trailer_allowed'] as bool,
            cameras: json['cameras'] as bool,
            fenced: json['fenced'] as bool,
            asphalt: json['asphalt'] as bool,
            lights: json['lights'] as bool,
            repairsAllowed: json['repairs_allowed'] as bool,
            images: (json['images'] as List<dynamic>?)
                ?.map((imageJson) => LocationImage(
                      id: imageJson['id'] as int,
                      image: imageJson['image'] as String,
                    ))
                .toList(),
            longitude: json['longitude'] != null
                ? double.parse(json['longitude'])
                : null,
            latitude: json['latitude'] != null
                ? double.parse(json['latitude'])
                : null,
            bankAccountAdded: json['bank_account_added'] as String?,
            availableSpots: json['available_spots'] as String?,
            status: LocationStatus(
              id: json['status']['id'] as int,
              name: json['status']['name'] as String,
            ),
          );
        }).toList();

        print('Spots fetched: $locations');
        return locations;
      } else {
        print('Error fetching spots: ${response.statusCode} ${response.data}');
        return [];
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      return [];
    } catch (e) {
      print('General error: $e');
      return [];
    }
  }
}
