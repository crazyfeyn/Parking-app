// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_application/core/error/exception.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConfig {
  late final Dio _dio;
  final LocalConfig localConfig;

  DioConfig(
    this.localConfig,
  ) {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env["baseseconUrl"]!,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(DioInterceptor(localConfig: localConfig));
  }

  Dio get client => _dio;
}

class DioInterceptor extends Interceptor {
  LocalConfig localConfig;
  DioInterceptor({
    required this.localConfig,
  });
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await localConfig.getToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      throw ServerException();
    }

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
        if (newToken != null && newToken.isNotEmpty) {
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

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
        '${dotenv.env["baseseconUrl"]}users/token/refresh/',
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
