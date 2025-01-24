import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/home/data/models/booking_model.dart';

class BookingDatasources {
  final Dio dio;

  BookingDatasources({required this.dio});

  Future<Status> bookingFunc(BookingModel booking) async {
    try {
      print('000000');
      print(booking.toJson());
      final response = await dio.post(
        '/bookings/create/',
        data: booking.toJson(),
      );
      print('11111');

      if (response.statusCode == 201) {
        print('Booking created successfully: ${response.data}');
        return Status.success;
      } else {
        print('Failed to create booking: ${response.data}');
        return Status.error;
      }
    } catch (e) {
      print('Error creating booking: $e');
      return Status.error;
    }
  }
}
