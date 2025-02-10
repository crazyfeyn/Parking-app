// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/payment_screen/presentation/data/models/list_payment_methods.dart';
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
      } else {}

      final permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        final permissionRequested = await location.requestPermission();
        if (permissionRequested != PermissionStatus.granted) {
          throw Exception('Location permissions are denied.');
        }
      } else if (permissionStatus == PermissionStatus.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      } else {}

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

  Future<List<LocationModel>> fetchAllLocations() async {
    try {
      final response = await dio.get('/locations/active-list/');

      if (response.statusCode == 200) {
        final List<dynamic> data;
        if (response.data is List) {
          data = response.data as List<dynamic>;
        } else if (response.data is Map && response.data['results'] != null) {
          data = response.data['results'] as List<dynamic>;
        } else {
          throw const FormatException('Unexpected response format');
        }

        if (data.isEmpty) {
          return [];
        }

        final List<LocationModel> locations = data.map((json) {
          int id = _parseInteger(json['id'], 'id');

          Map<String, bool> booleanFields = {};
          for (var field in [
            'twenty_four_hours',
            'limited_entry_exit_times',
            'lowboys_allowed',
            'bobtail_only',
            'containers_only',
            'oversized_allowed',
            'hazmat_allowed',
            'double_stack_allowed',
            'security_at_gate',
            'roaming_security',
            'landing_gear_support_required',
            'laundry_machines',
            'free_showers',
            'paid_showers',
            'repair_shop',
            'paid_container_stacking_services',
            'trailer_snow_scraper',
            'truck_wash',
            'food',
            'no_towed_vehicles',
            'truck_allowed',
            'trailer_allowed',
            'truck_trailer_allowed',
            'cameras',
            'fenced',
            'asphalt',
            'lights',
            'repairs_allowed'
          ]) {
            var value = json[field];
            if (value is String) {
              booleanFields[field] = value.toLowerCase() == 'true';
            } else {
              booleanFields[field] = value ?? false;
            }
          }

          return LocationModel(
            id: id,
            name: json['name']?.toString() ?? '',
            description: json['description']?.toString() ?? '',
            address: json['address']?.toString() ?? '',
            city: json['city']?.toString() ?? '',
            state: json['state']?.toString() ?? '',
            zipCode: json['zip_code']?.toString() ?? '',
            phNumber: json['ph_number']?.toString() ?? '',
            schedule: json['schedule']?.toString() ?? '',
            weeklyRate: _parseRate(json['weekly_rate']),
            dailyRate: _parseRate(json['daily_rate']),
            monthlyRate: _parseRate(json['monthly_rate']),
            twentyFourHours: booleanFields['twenty_four_hours']!,
            limitedEntryExitTimes: booleanFields['limited_entry_exit_times']!,
            lowboysAllowed: booleanFields['lowboys_allowed']!,
            bobtailOnly: booleanFields['bobtail_only']!,
            containersOnly: booleanFields['containers_only']!,
            oversizedAllowed: booleanFields['oversized_allowed']!,
            hazmatAllowed: booleanFields['hazmat_allowed']!,
            doubleStackAllowed: booleanFields['double_stack_allowed']!,
            securityAtGate: booleanFields['security_at_gate']!,
            roamingSecurity: booleanFields['roaming_security']!,
            landingGearSupportRequired:
                booleanFields['landing_gear_support_required']!,
            laundryMachines: booleanFields['laundry_machines']!,
            freeShowers: booleanFields['free_showers']!,
            paidShowers: booleanFields['paid_showers']!,
            repairShop: booleanFields['repair_shop']!,
            paidContainerStackingServices:
                booleanFields['paid_container_stacking_services']!,
            trailerSnowScraper: booleanFields['trailer_snow_scraper']!,
            truckWash: booleanFields['truck_wash']!,
            food: booleanFields['food']!,
            noTowedVehicles: booleanFields['no_towed_vehicles']!,
            email: json['email']?.toString() ?? '',
            truckAllowed: booleanFields['truck_allowed']!,
            trailerAllowed: booleanFields['trailer_allowed']!,
            truckTrailerAllowed: booleanFields['truck_trailer_allowed']!,
            cameras: booleanFields['cameras']!,
            fenced: booleanFields['fenced']!,
            asphalt: booleanFields['asphalt']!,
            lights: booleanFields['lights']!,
            repairsAllowed: booleanFields['repairs_allowed']!,
            images: _parseImages(json['images']),
            longitude: _parseCoordinate(json['longitude']),
            latitude: _parseCoordinate(json['latitude']),
            bankAccountAdded: json['bank_account_added'] ?? false,
            availableSpots:
                _parseInteger(json['available_spots'], 'available_spots'),
            status: _parseStatus(json['status']),
          );
        }).toList();

        return locations;
      }

      throw ServerException();
    } catch (e) {
      rethrow;
    }
  }

  double? _parseCoordinate(dynamic value) {
    try {
      if (value == null) return null;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        return double.tryParse(value);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  double _parseRate(dynamic value) {
    try {
      if (value == null) return 0.0;
      if (value is double) return value;
      if (value is int) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed != null) return parsed;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  int _parseInteger(dynamic value, String fieldName) {
    try {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return parsed;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  List<LocationImage>? _parseImages(dynamic imagesJson) {
    if (imagesJson == null) return null;

    try {
      if (imagesJson is! List) return null;

      return imagesJson
          .map((imageJson) => LocationImage(
                id: _parseInteger(imageJson['id'], 'image_id'),
                image: imageJson['image']?.toString() ?? '',
              ))
          .toList();
    } catch (e) {
      return null;
    }
  }

  LocationStatus? _parseStatus(dynamic statusJson) {
    if (statusJson == null) return null;

    try {
      return LocationStatus(
        id: _parseInteger(statusJson['id'], 'status_id'),
        name: statusJson['name']?.toString() ?? '',
      );
    } catch (e) {
      return null;
    }
  }

  Future<List<LocationModel>> fetchSearchAllLocations(String title) async {
    final response = await dio.get(
      '/locations/active-list/',
      queryParameters: {
        'search': title,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['results'] as List<dynamic>;

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
        final List data = response.data['results'];
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

  Future<List<LocationModel>> fetchBookingsWithFilters({
    String? city,
    String? state,
    bool? truckAllowed,
    bool? trailerAllowed,
    bool? truckTrailerAllowed,
    bool? repairsAllowed,
    bool? lowboysAllowed,
    bool? oversizedAllowed,
    bool? hazmatAllowed,
    bool? doubleStackAllowed,
    bool? bobtailOnly,
    bool? containersOnly,
    bool? cameras,
    bool? fenced,
    bool? asphalt,
    bool? lights,
    bool? twentyFourHours,
    bool? limitedEntryExitTimes,
    bool? securityAtGate,
    bool? roamingSecurity,
    bool? landingGearSupportRequired,
    bool? laundryMachines,
    bool? freeShowers,
    bool? paidShowers,
    bool? repairShop,
    bool? paidContainerStackingServices,
    bool? trailerSnowScraper,
    bool? truckWash,
    bool? food,
    bool? noTowedVehicles,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};

      // Add city and state only if they are not null
      if (city != null) queryParameters['city'] = city;
      if (state != null) queryParameters['state'] = state;

      // Add boolean parameters only if they are true
      if (truckAllowed == true) queryParameters['truck_allowed'] = true;
      if (trailerAllowed == true) queryParameters['trailer_allowed'] = true;
      if (truckTrailerAllowed == true) {
        queryParameters['truck_trailer_allowed'] = true;
      }
      if (repairsAllowed == true) queryParameters['repairs_allowed'] = true;
      if (lowboysAllowed == true) queryParameters['lowboys_allowed'] = true;
      if (oversizedAllowed == true) queryParameters['oversized_allowed'] = true;
      if (hazmatAllowed == true) queryParameters['hazmat_allowed'] = true;
      if (doubleStackAllowed == true) {
        queryParameters['double_stack_allowed'] = true;
      }
      if (bobtailOnly == true) queryParameters['bobtail_only'] = true;
      if (containersOnly == true) queryParameters['containers_only'] = true;
      if (cameras == true) queryParameters['cameras'] = true;
      if (fenced == true) queryParameters['fenced'] = true;
      if (asphalt == true) queryParameters['asphalt'] = true;
      if (lights == true) queryParameters['lights'] = true;
      if (twentyFourHours == true) queryParameters['twenty_four_hours'] = true;
      if (limitedEntryExitTimes == true) {
        queryParameters['limited_entry_exit_times'] = true;
      }
      if (securityAtGate == true) queryParameters['security_at_gate'] = true;
      if (roamingSecurity == true) queryParameters['roaming_security'] = true;
      if (landingGearSupportRequired == true) {
        queryParameters['landing_gear_support_required'] = true;
      }
      if (laundryMachines == true) queryParameters['laundry_machines'] = true;
      if (freeShowers == true) queryParameters['free_showers'] = true;
      if (paidShowers == true) queryParameters['paid_showers'] = true;
      if (repairShop == true) queryParameters['repair_shop'] = true;
      if (paidContainerStackingServices == true) {
        queryParameters['paid_container_stacking_services'] = true;
      }
      if (trailerSnowScraper == true) {
        queryParameters['trailer_snow_scraper'] = true;
      }
      if (truckWash == true) queryParameters['truck_wash'] = true;
      if (food == true) queryParameters['food'] = true;
      if (noTowedVehicles == true) queryParameters['no_towed_vehicles'] = true;

      final response = await dio.get(
        '/locations/active-list/',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        if (data.isEmpty) {
          return [];
        }

        final List<LocationModel> bookings = data.map((json) {
          return LocationModel(
            id: json['id'] ?? '',
            name: json['name'] ?? '',
            description: json['description'] ?? '',
            address: json['address'] ?? '',
            city: json['city'] ?? '',
            state: json['state'] ?? '',
            zipCode: json['zip_code'] ?? '',
            phNumber: json['ph_number'] ?? '',
            schedule: json['schedule'] ?? '',
            weeklyRate: double.tryParse(json['weekly_rate'].toString()) ?? 0.0,
            dailyRate: double.tryParse(json['daily_rate'].toString()) ?? 0.0,
            monthlyRate:
                double.tryParse(json['monthly_rate'].toString()) ?? 0.0,
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
                      id: imageJson['id'] ?? '',
                      image: imageJson['image'] ?? '',
                    ))
                .toList(),
            longitude: json['longitude'] != null
                ? double.tryParse(json['longitude'].toString())
                : null,
            latitude: json['latitude'] != null
                ? double.tryParse(json['latitude'].toString())
                : null,
            bankAccountAdded: json['bank_account_added'] ?? false,
            availableSpots: json['available_spots'] ?? 0,
            status: json['status'] != null
                ? LocationStatus(
                    id: json['status']['id'] ?? '',
                    name: json['status']['name'] ?? '',
                  )
                : null,
          );
        }).toList();

        return bookings;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<ListPaymentMethods>> fetchPaymentMethods() async {
    final response = await dio.get('/payments/list-payment-methods/');
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => ListPaymentMethods.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payment methods');
    }
  }

  Future<void> updateVehicle({
    required VehicleModel vehicleData,
  }) async {
    try {
      if (vehicleData.unitNumber.isEmpty ||
          vehicleData.year <= 0 ||
          vehicleData.make.isEmpty ||
          vehicleData.model.isEmpty ||
          vehicleData.plateNumber.isEmpty) {
        throw Exception('Invalid vehicle data');
      }

      final response = await dio.patch(
          '/bookings/vehicle-update/${vehicleData.id}/',
          data: vehicleData.toJson());

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to update vehicle');
      }
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateIsDefaultCard(String id) async {
    try {
      await dio.patch('/payments/update-payment-methods/$id/',
          data: {'is_default': true});
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to update isDefault card');
    }
  }
}
