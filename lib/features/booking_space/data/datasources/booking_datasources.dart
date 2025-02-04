import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/booking_model.dart';

class BookingDatasources {
  final Dio dio;

  BookingDatasources({required this.dio});

  Future<Status> bookingFunc(BookingModel booking) async {
    try {
      final response = await dio.post(
        '/bookings/create/',
        data: booking.toJson(),
      );

      if (response.statusCode == 201) {
        return Status.success;
      } else {
        return Status.error;
      }
    } catch (e) {
      return Status.error;
    }
  }

  Future<Status> extendBooking({
    required int id,
    required int duration,
    required int paymentMethodId,
  }) async {
    try {
      final response = await dio.post(
        '/bookings/extend/$id/',
        data: {
          'duration': duration,
          'payment_method': paymentMethodId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Status.success;
      } else {
        return Status.error;
      }
    } catch (e) {
      return Status.error;
    }
  }

  Future<Status> updateBookingVehicle({
    required int bookingId,
    required int vehicleId,
  }) async {
    try {
      final response = await dio.patch(
        '/bookings/booking/$bookingId/vehicle-update/',
        data: {
          "vehicle": vehicleId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Status.success;
      } else {
        return Status.error;
      }
    } catch (e) {
      return Status.error;
    }
  }
}
