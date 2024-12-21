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
  });
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

  Future<void> register(String password, String email) async {
    print('${AppConstants.baseseconUrl}users/register/');
    final response = await dio.post(
      '${AppConstants.baseseconUrl}users/register/',
      data: {"email": email, "password": password},
    );

    print("Response data: ${response.data}");
    print("Response status code: ${response.statusCode}");

    if (response.statusCode == 201) {
      return;
    } else {
      throw ServerException();
    }
  }

  Future<void> resetPass(String email) async {
    final recponce = await dio.post(
      '${AppConstants.baseUrl}users/reset-password',
      data: {
        "email": email,
      },
    );
    if (recponce.statusCode == 200) {
      return;
    }
    throw ServerException();
  }

  Future<void> startTokenAutoRefresh() async {
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
  }

  Future<void> stopTokenAutoRefresh() async {
    _tokenRefreshTimer?.cancel();
  }

  Future<void> _refreshToken() async {
    try {
      final token = await localAuthDatasources.getRefreshToken();
      if (token.isEmpty) {
        throw CacheException();
      }

      final response = await dio.post(
        '${AppConstants.baseUrl}users/token/refresh',
        data: {'refresh': token},
      );

      if (response.statusCode == 200) {
        await localAuthDatasources.saveToken(response.data['access']);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("Ошибка обновления токена: $e");
      rethrow;
    }
  }
}
