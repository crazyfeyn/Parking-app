import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';

class HistoryDatasources {
  final Dio dio;

  HistoryDatasources({required this.dio});

  Future<BookingView> getBookingList() async {
    try {
      final response = await dio.get('bookings/list/');
      if (response.statusCode == 200) {
        BookingView bookingList = BookingView.fromJson(response.data);
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
}
