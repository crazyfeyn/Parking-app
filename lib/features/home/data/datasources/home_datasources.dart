// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:location/location.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';

class HomeDatasources {
  final Dio dio;
  HomeDatasources({
    required this.dio,
  });
  Future<LocationData> getCurrentLocation() async {
    final Location location = Location();
    try {
      final isServiceEnabled = await location.serviceEnabled();
      if (!isServiceEnabled) {
        final serviceRequested = await location.requestService();
        if (!serviceRequested) {
          throw LocationException();
        }
      }

      final permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        final permissionRequested = await location.requestPermission();
        if (permissionRequested != PermissionStatus.granted) {
          throw Exception('Location permissions are denied.');
        }
      } else if (permissionStatus == PermissionStatus.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      final currentLocation = await location.getLocation();
      if (currentLocation.latitude == null ||
          currentLocation.longitude == null) {
        throw Exception('Failed to retrieve location.');
      }

      return currentLocation;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<LocationModel>> fetchAllLocations(String title) async {
    print('TITITITIITLE:$title');
    final response = await dio.get(
      '/locations/list/',
      queryParameters: {
        'search': title,
      },
    );
    print('RECOINCE FROM HOME LIST');
    print(response.data);

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;

      if (data.isEmpty) {
        return [];
      }

      final List<LocationModel> locations = data.map((json) {
        return LocationModel(
          id: json['id'],
          name: json['name'],
          description: json['description'] ?? '',
          address: json['address'] ?? '',
          city: json['city'] ?? '',
          state: json['state'] ?? '',
          zipCode: json['zip_code'] ?? '',
          phNumber: json['ph_number'] ?? '',
          schedule: json['schedule'],
          weeklyRate: double.tryParse(json['weekly_rate'].toString()) ?? 0.0,
          dailyRate: double.tryParse(json['daily_rate'].toString()) ?? 0.0,
          monthlyRate: double.tryParse(json['monthly_rate'].toString()) ?? 0.0,
          twentyFourHours: json['twenty_four_hours'] ?? false,
          limitedEntryExitTimes: json['limited_entry_exit_times'] ?? false,
          lowboysAllowed: json['lowboys_allowed'] ?? false,
          bobtailOnly: json['bobtail_only'] ?? false,
          containersOnly: json['containers_only'] ?? false,
          oversizedAllowed: json['oversized_allowed'] ?? false,
          hazmatAllowed: json['hazmat_allowed'] ?? false,
          doubleStackAllowed: json['double_stack_allowed'] ?? false,
          securityAtGate: json['security_at_gate'] ?? false,
          roamingSecurity: json['roaming_security'] ?? false,
          landingGearSupportRequired:
              json['landing_gear_support_required'] ?? false,
          laundryMachines: json['laundry_machines'] ?? false,
          freeShowers: json['free_showers'] ?? false,
          paidShowers: json['paid_showers'] ?? false,
          repairShop: json['repair_shop'] ?? false,
          paidContainerStackingServices:
              json['paid_container_stacking_services'] ?? false,
          trailerSnowScraper: json['trailer_snow_scraper'] ?? false,
          truckWash: json['truck_wash'] ?? false,
          food: json['food'] ?? false,
          noTowedVehicles: json['no_towed_vehicles'] ?? false,
          email: json['email'] ?? '',
          truckAllowed: json['truck_allowed'] ?? false,
          trailerAllowed: json['trailer_allowed'] ?? false,
          truckTrailerAllowed: json['truck_trailer_allowed'] ?? false,
          cameras: json['cameras'] ?? false,
          fenced: json['fenced'] ?? false,
          asphalt: json['asphalt'] ?? false,
          lights: json['lights'] ?? false,
          repairsAllowed: json['repairs_allowed'] ?? false,
          images: (json['images'] as List<dynamic>?)
              ?.map((imageJson) => LocationImage(
                    id: imageJson['id'],
                    image: imageJson['image'] ?? '',
                  ))
              .toList(),
          longitude: json['longitude'] != null
              ? double.tryParse(json['longitude'].toString())
              : null,
          latitude: json['latitude'] != null
              ? double.tryParse(json['latitude'].toString())
              : null,
          bankAccountAdded: json['bank_account_added'],
          availableSpots: json['available_spots'],
          status: json['status'] != null
              ? LocationStatus(
                  id: json['status']['id'],
                  name: json['status']['name'],
                )
              : null,
        );
      }).toList();

      return locations;
    }
    throw ServerException();
  }

  Future<List<VehicleModel>> fetchVehicleList() async {
    try {
      final response = await dio.get('/bookings/vehicle-list/');
      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => VehicleModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> createVehicle({required VehicleModel vehicleModel}) async {
    try {
      final vehicleData = {
        'unit_number': vehicleModel.unitNumber,
        'year': vehicleModel.year,
        'make': vehicleModel.make,
        'model': vehicleModel.model,
        'plate_number': vehicleModel.plateNumber,
        'user': vehicleModel.user,
        'type': vehicleModel.type,
        'id': UniqueKey().hashCode,
      };

      final response = await dio.post(
        '/bookings/vehicle-create/',
        data: vehicleData,
      );

      if (response.statusCode == 201) {
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
