// import 'package:dio/dio.dart';
// import 'package:flutter_application/core/constants/app_constants.dart';
// import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';

// class DioConfig {
//   final LocalAuthDatasources localConfig;

//   late final Dio _dio;

//   DioConfig({required this.localConfig}) {
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: AppConstants.baseseconUrl,
//         connectTimeout: const Duration(seconds: 15),
//         receiveTimeout: const Duration(seconds: 15),
//       ),
//     );

//     _dio.interceptors.add(DioInterceptor(localConfig: localConfig));
//   }

//   Dio get client => _dio;
// }

