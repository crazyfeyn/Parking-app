import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

class HistoryDatasources {
  final Dio dio;

  HistoryDatasources({required this.dio});

  Future<List<BookingView>> getBookingList() async {
    try {
      final response = await dio.get('/bookings/list/');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => BookingView.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }

  Future<List<BookingView>> getCurrentBookingList() async {
    try {
      final response = await dio.get('/bookings/list/');

      if (response.statusCode == 200) {
        List<BookingView> allBookings = (response.data as List)
            .map((json) => BookingView.fromJson(json))
            .toList();

        DateTime now = DateTime.now();

        return allBookings.where((booking) {
          return now.isAtSameMomentAs(booking.startDate) ||
              now.isAfter(booking.startDate) && now.isBefore(booking.endDate);
        }).toList();
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
