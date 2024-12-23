import 'package:dio/dio.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class DioConfig {
  late final Dio _dio;

  DioConfig() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseseconUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(DioInterceptor());
  }

  Dio get client => _dio;
}

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('🔴 Dio Error!');
    print('   ├─ URL: ${err.requestOptions.uri}');
    print('   ├─ Status Code: ${err.response?.statusCode}');
    print('   └─ Error Message: ${err.message}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('➡️ Dio Request');
    print('   ├─ URL: ${options.uri}');
    print('   ├─ Method: ${options.method}');
    print('   └─ Headers: ${options.headers}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ Dio Response');
    print('   ├─ URL: ${response.requestOptions.uri}');
    print('   ├─ Status Code: ${response.statusCode}');
    print('   └─ Data: ${response.data}');
    handler.next(response);
  }
}
