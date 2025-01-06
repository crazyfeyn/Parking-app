import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

class HistoryDatasources {
  final Dio dio;

  HistoryDatasources({required this.dio});

  Future<List<BookingView>> getBookingList() async {
    try {
      final response = await dio.get('bookings/list/');
      if (response.statusCode == 200) {
        List<BookingView> bookingList =
            response.data.map((json) => BookingView.fromJson(json)).toList();

        return bookingList;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  Future<List<BookingView>> getCurrentBookingList() async {
    try {
      // Fetch all bookings from the API
      final response = await dio.get('bookings/list/');

      if (response.statusCode == 200) {
        // Parse the response data into a list of BookingView objects
        List<dynamic> data = response.data;
        List<BookingView> allBookings =
            data.map((json) => BookingView.fromJson(json)).toList();

        // Get the current date and time
        DateTime now = DateTime.now();

        // Filter bookings that are either in progress or in the future
        List<BookingView> currentAndFutureBookings =
            allBookings.where((booking) {
          DateTime startDate = DateTime.parse(booking.startDate);
          DateTime? endDate =
              booking.endDate != null ? DateTime.parse(booking.endDate!) : null;

          // Check if the booking is in progress or in the future
          if (endDate != null) {
            // Booking is in progress or starts in the future
            return now.isBefore(endDate);
          } else {
            // If endDate is null, assume the booking is valid if it starts in the future or is in progress
            return now.isBefore(startDate) || now.isAfter(startDate);
          }
        }).toList();

        return currentAndFutureBookings;
      } else {
        // Handle non-200 status codes
        throw ServerException();
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors (e.g., network issues)
      throw ServerException();
    } catch (e) {
      // Handle any other exceptions
      throw ServerException();
    }
  }
}
