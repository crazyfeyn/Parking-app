import 'package:dio/dio.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

class BookingDatasources {
  final Dio dio;

  BookingDatasources({required this.dio});

  Future<void> bookingFunc(BookingView booking) async {
    try {
      final response = await dio.post(
        '/bookings/create/',
        data: booking.toJson(),
      );

      if (response.statusCode == 201) {
        print('Booking created successfully: ${response.data}');
      } else {
        print('Failed to create booking: ${response.data}');
      }
    } catch (e) {
      print('Error creating booking: $e');
    }
  }
}
