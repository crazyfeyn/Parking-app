import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/home/data/models/booking_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HistoryDatasources {
  final Dio dio;

  HistoryDatasources({required this.dio});

  Future<List<BookingView>> getBookingList() async {
    try {
      final response = await dio.get('/bookings/list/');

      if (response.statusCode == 200) {
        DateTime now = DateTime.now();

        try {
          List<BookingView> historyBookings =
              (response.data as List).map((json) {
            try {
              return BookingView.fromJson(json);
            } catch (e) {
              rethrow;
            }
          }).where((booking) {
            return booking.endDate.isBefore(now);
          }).toList();

          return historyBookings;
        } catch (e) {
          rethrow;
        }
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

class PlaceService {
  static String apiKey = dotenv.env["google_api_key"]!;

  Future<List<dynamic>> getPlacePredictions(String input) async {
    if (input.isEmpty) {
      return [];
    }

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json'
        '?input=$input'
        '&key=$apiKey'
        '&types=geocode';

    try {
      final response = await http.get(Uri.parse(url));
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        return data['predictions'] as List<dynamic>;
      }
      // ignore: empty_catches
    } catch (e) {}

    return [];
  }
}
