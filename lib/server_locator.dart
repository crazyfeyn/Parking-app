import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_datasources.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repositories.dart';
import 'package:flutter_application/features/auth/domain/usecases/authicated_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/refresh_user_token_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/reset_pass_user_usecase.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final shared = await SharedPreferences.getInstance();
  sl.registerFactory(() => AuthBloc(
      sl<LoginUserUsecase>(),
      sl<RefreshUserTokenUsecase>(),
      sl<RegisterUserUsecase>(),
      sl<ResetPassUserUsecase>(),
      sl<AuthicatedUsecase>()));
  sl.registerFactory(
      () => AuthicatedUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(
      () => LoginUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(() =>
      RefreshUserTokenUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(
      () => RegisterUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(
      () => ResetPassUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(
      () => AuthRepositoriesImpl(authDatasources: sl<AuthDatasources>()));
  // final client = DioConfig(localConfig: sl<LocalAuthDatasources>()).client;

  sl.registerFactory(() => AuthDatasources(
      dio: Dio(), localAuthDatasources: sl<LocalAuthDatasources>()));
  sl.registerFactory(
      () => LocalAuthDatasources(localConfig: sl<LocalConfig>()));
  sl.registerSingleton(LocalConfig(sharedPreferences: shared));
}
