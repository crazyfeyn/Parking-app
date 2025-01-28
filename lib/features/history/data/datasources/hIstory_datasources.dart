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
        DateTime now = DateTime.now();

        List<BookingView> historyBookings = (response.data as List)
            .map((json) => BookingView.fromJson(json))
            .where((booking) => booking.endDate.isBefore(now))
            .toList();

        return historyBookings;
      } else {
        throw ServerException();
      }
    } on DioException {
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }

  Future<List<BookingView>> getCurrentBookingList() async {
    try {
      final response = await dio.get('/bookings/list/');

      if (response.statusCode == 200) {
        DateTime now = DateTime.now();

        List<BookingView> currentBookings = (response.data as List)
            .map((json) => BookingView.fromJson(json))
            .where((booking) {
          return booking.startDate.isAfter(now) ||
              booking.startDate.isAtSameMomentAs(now) ||
              (now.isAfter(booking.startDate) && now.isBefore(booking.endDate));
        }).toList();

        return currentBookings;
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
