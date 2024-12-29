import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_datasources.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repositories.dart';
import 'package:flutter_application/features/auth/domain/usecases/authicated_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/refresh_user_token_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/reset_pass_user_usecase.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/home/data/datasources/home_datasources.dart';
import 'package:flutter_application/features/home/data/repositories/home_repositories.dart';
import 'package:flutter_application/features/home/domain/repositories/location_repositories.dart';
import 'package:flutter_application/features/home/domain/usecases/current_location_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_locations_usecase.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/data/datasources/profile_datasources.dart';
import 'package:flutter_application/features/profile/data/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/domain/usecases/add_payment_method_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton<LocalConfig>(
      () => LocalConfig(sharedPreferences: shared));
  final dio = DioConfig(sl<LocalConfig>()).client;
  //! Core
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => DioConfig(sl<LocalConfig>(),),);
  //! Features

  // Auth Feature
  // Bloc
  sl.registerFactory(() => AuthBloc(
      sl<LoginUserUsecase>(),
      sl<RefreshUserTokenUsecase>(),
      sl<RegisterUserUsecase>(),
      sl<ResetPassUserUsecase>(),
      sl<AuthicatedUsecase>(),
      sl<LogOutUsecase>()));

  // Use cases
  sl.registerFactory(
      () => LogOutUsecase(authRepositoriesImpl: sl<AuthRepositoriesImpl>()));
  sl.registerFactory(
      () => AuthicatedUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerLazySingleton(
      () => LoginUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerLazySingleton(() =>
      RefreshUserTokenUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerLazySingleton(
      () => RegisterUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));
  sl.registerLazySingleton(
      () => ResetPassUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  // Repository
  sl.registerLazySingleton<AuthRepositoriesImpl>(
    () => AuthRepositoriesImpl(authDatasources: sl<AuthDatasources>()),
  );

  // Data sources
  sl.registerLazySingleton(() => AuthDatasources(
        dio: Dio(),
        localAuthDatasources: sl<LocalAuthDatasources>(),
      ));
  sl.registerLazySingleton(
      () => LocalAuthDatasources(localConfig: sl<LocalConfig>()));

  // Home Feature
  // Bloc
  sl.registerFactory(() => HomeBloc(
        sl<CurrentLocationUsecase>(),
        sl<FetchLocationsUsecase>(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CurrentLocationUsecase(
        homeRepositories: sl<HomeRepositories>(),
      ));
  sl.registerLazySingleton(() => FetchLocationsUsecase(
        homeRepositories: sl<HomeRepositories>(),
      ));

  // Repository
  sl.registerLazySingleton<HomeRepositories>(() => HomeRepositoriesImpl(
        homeDatasources: sl<HomeDatasources>(),
      ));

  // Data sources
  sl.registerLazySingleton(() => HomeDatasources(dio: dio));


  // Bloc
  sl.registerFactory(() => ProfileBloc(
        addPaymentMethodUsecase: sl<AddPaymentMethodUsecase>(),
        changePasswordUsecase: sl<ChangePasswordUsecase>(),
        getProfileUsecase: sl<GetProfileUsecase>(),
        updateProfileUsecase: sl<UpdateProfileUsecase>(),
      ));

  // Use cases
  sl.registerLazySingleton(() => AddPaymentMethodUsecase(
        profileRepositories: sl<ProfileRepositories>(),
      ));
  sl.registerLazySingleton(() => ChangePasswordUsecase(
        profileRepositories: sl<ProfileRepositories>(),
      ));
  sl.registerLazySingleton(() => GetProfileUsecase(
        profileRepositories: sl<ProfileRepositories>(),
      ));
  sl.registerLazySingleton(() => UpdateProfileUsecase(
        profileRepositories: sl<ProfileRepositories>(),
      ));

  // Repository
  sl.registerLazySingleton<ProfileRepositories>(() => ProfileRepositoriesImpl(
        profileDatasources: sl<ProfileDatasources>(),
      ));

  // Data sources
  //! cachedProfile uchun shareddan current userni olib berib yuborish kerak
  sl.registerLazySingleton(() => ProfileDatasources(
        dio: dio,
        cachedProfile: null, //! cached profile ga etibor qarat
      ));
}
