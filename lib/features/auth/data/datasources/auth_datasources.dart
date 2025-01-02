// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

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
    print(password);
    print(email);
    print('{"email": $email, "password": $password}');
    final recponce = await dio.post(
      '${AppConstants.baseseconUrl}users/token/',
      data: {"email": email, "password": password},
    );
    print(recponce);
    if (recponce.statusCode == 200) {
      localAuthDatasources.saveRefreshToken(recponce.data['refresh']);
      localAuthDatasources.saveToken(recponce.data['access']);
      return;
    }
    throw ServerException();
  }

  Future<void> register(
      String password, String email, String name, String surname) async {
    print('${AppConstants.baseseconUrl}users/register/');
    final response = await dio.post(
      '${AppConstants.baseseconUrl}users/register/',
      data: {
        "email": email,
        "password": password,
        "first_name": name,
        "last_name": surname
      },
    );

    print("Response data: ${response.data}");
    print("Response status code: ${response.statusCode}");

    if (response.statusCode == 201) {
      return;
    } else {
      throw ServerException();
    }
  }

  Future<void> changePass(String oldPassword, String newPassword) async {
    print('${AppConstants.baseseconUrl}users/register/');
    final response = await dio.post(
      '${AppConstants.baseseconUrl}users/change-password/',
      data: {
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );

    print("Response data: ${response.data}");
    print("Response status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  Future<void> resetPass(String email) async {
    print(email);
    final recponce = await dio.post(
      '${AppConstants.baseseconUrl}users/reset-password/',
      data: {
        "email": email,
      },
    );
    print(recponce);
    if (recponce.statusCode == 200) {
      return;
    }
    throw ServerException();
  }

  Future<void> logOut() async {
    print('hello from local datsoruces');
    return localAuthDatasources.logOut();
  }

  Future<void> startTokenAutoRefresh() async {
    print('hlelelleel');
    _tokenRefreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (timer) async {
        try {
          await _refreshToken();
        } catch (e) {
          print("Ошибка обновления токена: $e");
        }
      },
    );
    print('TOKEN REFRESHED');
  }

  Future<void> stopTokenAutoRefresh() async {
    _tokenRefreshTimer?.cancel();
  }

  Future<void> _refreshToken() async {
    try {
      print("[_refreshToken] Attempting to refresh token...");
      final token = await localAuthDatasources.getRefreshToken();
      print("[_refreshToken] Current refresh token: $token");

      if (token.isEmpty) {
        print(
            "[_refreshToken] Refresh token is empty. Throwing CacheException.");
        throw CacheException();
      }

      final response = await dio.post(
        '${AppConstants.baseUrl}users/token/refresh',
        data: {'refresh': token},
      );

      print("[_refreshToken] Server response: ${response.data}");

      if (response.statusCode == 200) {
        await localAuthDatasources.saveToken(response.data['access']);
        print(
            "[_refreshToken] Token refreshed successfully. New token: ${response.data['access']}");
      } else {
        print(
            "[_refreshToken] Failed to refresh token. Server responded with status code: ${response.statusCode}");
        throw ServerException();
      }
    } catch (e) {
      print("[_refreshToken] Error during token refresh: $e");
      rethrow;
    }
  }

  Future<bool> authicated() async {
    print('hello fro mdata');
    print('REFRESSHSSHSH');
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
    print('Request: ${options.method} ${options.uri}');

    try {
      final token = await localConfig.getToken();

      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print('Error fetching token: $e');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('Request failed: ${err.response?.statusCode}, ${err.message}');

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
        print('Token refresh failed: $e');
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
      print('Error during token refresh: $e');
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
