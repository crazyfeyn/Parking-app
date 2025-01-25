// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';

class AuthDatasources {
  Dio dio;
  LocalAuthDatasources localAuthDatasources;
  AuthDatasources({
    required this.dio,
    required this.localAuthDatasources,
  }) {
    dio.interceptors.add(DioInterceptor(localConfig: localAuthDatasources));
  }
  Timer? _tokenRefreshTimer;
  Future<void> logIn(String password, String email) async {
    final recponce = await dio.post(
      '${AppConstants.baseseconUrl}users/token/',
      data: {"email": email, "password": password},
    );
    if (recponce.statusCode == 200) {
      localAuthDatasources.saveRefreshToken(recponce.data['refresh']);
      localAuthDatasources.saveToken(recponce.data['access']);
      return;
    }
    throw ServerException();
  }

  Future<void> register(
      String password, String email, String name, String surname) async {
    final response = await dio.post(
      '${AppConstants.baseseconUrl}users/register/',
      data: {
        "email": email,
        "password": password,
        "first_name": name,
        "last_name": surname
      },
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw ServerException();
    }
  }

  Future<void> changePass(String oldPassword, String newPassword) async {
    final response = await dio.post(
      '${AppConstants.baseseconUrl}users/change-password/',
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  Future<void> resetPass(String email) async {
    log(email);

    final recponce = await dio.post(
      'https://parkmytrucks.com/api/users/reset-password/',
      data: {
        "email": email,
      },
    );
    log('hellloooooo');
    if (recponce.statusCode == 200) {
      return;
    }
    throw ServerException();
  }

  Future<void> logOut() async {
    return localAuthDatasources.logOut();
  }

  Future<void> startTokenAutoRefresh() async {
    // Проверяем, есть ли уже активный таймер, чтобы избежать дублирования
    if (_tokenRefreshTimer != null) {
      log('[startTokenAutoRefresh] Таймер уже запущен.');
      return;
    }

    log('[startTokenAutoRefresh] Запуск таймера автообновления токена.');

    _tokenRefreshTimer = Timer.periodic(
      const Duration(minutes: 4), // Обновление каждые 5 минут
      (timer) async {
        try {
          log('[startTokenAutoRefresh] Попытка обновления токена...');
          await _refreshToken();
          log('[startTokenAutoRefresh] Токен успешно обновлен.');
        } catch (e) {
          log('[startTokenAutoRefresh] Ошибка при обновлении токена: $e');
          stopTokenAutoRefresh(); // Остановка таймера при ошибке
        }
      },
    );
  }

  Future<void> stopTokenAutoRefresh() async {
    if (_tokenRefreshTimer != null) {
      log('[stopTokenAutoRefresh] Остановка таймера автообновления токена.');
      _tokenRefreshTimer?.cancel();
      _tokenRefreshTimer = null;
    } else {
      log('[stopTokenAutoRefresh] Таймер уже остановлен.');
    }
  }

  Future<void> _refreshToken() async {
    try {
      log('[_refreshToken] Попытка обновить токен...');
      final token = await localAuthDatasources.getRefreshToken();

      if (token.isEmpty) {
        log('[_refreshToken] Refresh-токен отсутствует.');
        throw CacheException();
      }

      final response = await dio.post(
        '${AppConstants.baseseconUrl}users/token/refresh/',
        data: {'refresh': token},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        await localAuthDatasources.saveToken(newAccessToken);
        log('[_refreshToken] Токен успешно обновлен: $newAccessToken');
      } else {
        log('[_refreshToken] Ошибка сервера: ${response.statusCode}');
        throw ServerException();
      }
    } catch (e) {
      log('[_refreshToken] Ошибка при обновлении токена: $e');
      rethrow;
    }
  }

  Future<bool> authicated() async {
    // print(await localAuthDatasources.getRefreshToken());
    return localAuthDatasources.authicated();
  }
}

class DioInterceptor implements Interceptor {
  final LocalAuthDatasources localConfig;

  DioInterceptor({required this.localConfig});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await localConfig.getToken();

      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      // ignore: empty_catches
    } catch (e) {}

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await _refreshToken();

        final newToken = await localConfig.getToken();
        if (newToken.isNotEmpty) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          // Clone the original request with updated headers
          final clonedRequest = await _retry(err.requestOptions);
          return handler.resolve(clonedRequest);
        }
      } catch (e) {
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<void> _refreshToken() async {
    final refreshToken = await localConfig.getRefreshToken();

    if (refreshToken.isEmpty) {
      throw Exception('Refresh token not found');
    }

    try {
      final response = await Dio().post(
        '${AppConstants.baseseconUrl}users/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['access'];
        await localConfig.saveToken(newAccessToken);
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return Dio().request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
