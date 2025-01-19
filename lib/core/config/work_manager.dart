import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:workmanager/workmanager.dart';

import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';

class WorkManagerClass {
  final Dio dio;
  final LocalAuthDatasources localAuthDatasources;

  WorkManagerClass({
    required this.dio,
    required this.localAuthDatasources,
  });

  // Фоновая задача
  static void callbackDispatcher() {
    log('FUNCTION IS WORKEEED');
    Workmanager().executeTask((task, inputData) async {
      try {
        final dio = Dio();
        final refreshToken = inputData?['refreshToken'] ?? '';

        if (refreshToken.isEmpty) {
          print("No refresh token provided.");
          return Future.value(false);
        }

        final response = await dio.post(
          '${AppConstants.baseseconUrl}users/token/refresh/',
          data: {'refresh': refreshToken},
        );

        if (response.statusCode == 200) {
          final newAccessToken = response.data['access'];
          print("Token refreshed in background: $newAccessToken");
          // Здесь можно сохранить новый токен (например, через SharedPreferences)
          return Future.value(true);
        } else {
          print(
              "Failed to refresh token in background. Status: ${response.statusCode}");
          return Future.value(false);
        }
      } catch (e) {
        print("Error refreshing token in background: $e");
        return Future.value(false);
      }
    });
  }

  // Регистрация задачи
  Future<void> registerPeriodicTask(String refreshToken) async {
    log('IUYTREWQ WERTYUIUYTREWERTYUIUYTREW');
    await Workmanager().registerPeriodicTask(
      "refreshTokenTask",
      "refreshToken",
      inputData: {'refreshToken': refreshToken},
      frequency: const Duration(minutes: 5),
    );
    log("Periodic task registered for token refresh.");
  }
}
