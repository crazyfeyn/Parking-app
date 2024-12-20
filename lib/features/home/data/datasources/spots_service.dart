import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
class SpotService {
  final Dio dio;

  SpotService(this.dio);

  Future<void> fetchAllSpots() async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}spots',
        options: Options(headers: {
          'Authorization': 'Bearer YOUR_TOKEN',
        }),
      );
      if (response.statusCode == 200) {
        print('Spots fetched: ${response.data}');
      } else {
        print('Error fetching spots: ${response.statusCode} ${response.data}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
    } catch (e) {
      print('General error: $e');
    }
  }
}
