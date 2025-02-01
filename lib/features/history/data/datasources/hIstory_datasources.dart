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

        if (response.data is! List) {
          throw FormatException(
              'Expected List, got ${response.data.runtimeType}');
        }

        List<BookingView> historyBookings = [];

        for (var item in response.data) {
          try {
            BookingView booking = BookingView.fromJson(item);
            if (booking.endDate.isBefore(now)) {
              historyBookings.add(booking);
            }
            // ignore: empty_catches
          } catch (e) {}
        }

        return historyBookings;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
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

        if (response.data is! List) {
          throw FormatException(
              'Expected List, got ${response.data.runtimeType}');
        }

        List<BookingView> currentBookings = [];

        for (var item in response.data) {
          try {
            BookingView booking = BookingView.fromJson(item);
            if (booking.startDate.isAfter(now) ||
                booking.startDate.isAtSameMomentAs(now) ||
                (now.isAfter(booking.startDate) &&
                    now.isBefore(booking.endDate))) {
              currentBookings.add(booking);
            }
            // ignore: empty_catches
          } catch (e) {}
        }

        return currentBookings;
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
