import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
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
}
