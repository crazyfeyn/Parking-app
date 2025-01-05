import 'package:dio/dio.dart';
import 'package:flutter_application/core/config/dio_config.dart';
import 'package:flutter_application/core/config/local_config.dart';
import 'package:flutter_application/features/auth/data/datasources/auth_datasources.dart';
import 'package:flutter_application/features/auth/data/datasources/local_auth_datasources.dart';
import 'package:flutter_application/features/auth/data/repositories/auth_repositories.dart';
import 'package:flutter_application/features/auth/domain/usecases/authicated_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/refresh_user_token_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:flutter_application/features/auth/domain/usecases/reset_pass_user_usecase.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/home/data/datasources/home_datasources.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/data/repositories/home_repositories.dart';
import 'package:flutter_application/features/home/domain/repositories/home_repositories.dart';
import 'package:flutter_application/features/home/domain/usecases/create_vehicle_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/current_location_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_locations_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_search_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/get_vehicle_list_usecase.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/data/datasources/profile_datasources.dart';
import 'package:flutter_application/features/profile/data/datasources/profile_local_data_sources.dart';
import 'package:flutter_application/features/profile/data/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/domain/repositories/profile_repositories.dart';
import 'package:flutter_application/features/profile/domain/usecases/add_payment_method_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:flutter_application/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External Dependencies
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // LocalConfig
  sl.registerLazySingleton<LocalConfig>(
      () => LocalConfig(sharedPreferences: sl<SharedPreferences>()));

  // Dio
  sl.registerLazySingleton<Dio>(() => DioConfig(sl<LocalConfig>()).client);

  // DioConfig
  sl.registerLazySingleton<DioConfig>(
    () => DioConfig(sl<LocalConfig>()),
  );

  //! Core Services
  sl.registerLazySingleton<Location>(() => Location());

  // Use Cases
  sl.registerLazySingleton<CurrentLocationUsecase>(
    () => CurrentLocationUsecase(
      homeRepositories: sl<HomeRepositories>(),
    ),
  );

  sl.registerLazySingleton<FetchLocationsUsecase>(
    () => FetchLocationsUsecase(
      homeRepositories: sl<HomeRepositories>(),
    ),
  );

  sl.registerLazySingleton<GetVehicleListUsecase>(
    () => GetVehicleListUsecase(
      homeRepositories: sl<HomeRepositories>(),
    ),
  );
  sl.registerLazySingleton<CreateVehicleUsecase>(
    () => CreateVehicleUsecase(
      homeRepositories: sl<HomeRepositories>(),
    ),
  );
  sl.registerLazySingleton<FetchSearchUsecase>(
    () => FetchSearchUsecase(
      homeRepositories: sl<HomeRepositories>(),
    ),
  );

  // Bloc
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      sl<CurrentLocationUsecase>(),
      sl<FetchLocationsUsecase>(),
      sl<GetVehicleListUsecase>(),
      sl<CreateVehicleUsecase>(),
      sl<FetchSearchUsecase>(),
    ),
  );

  //! Features Registration

  //? Auth Feature
  // Data Sources
  sl.registerLazySingleton<LocalAuthDatasources>(
      () => LocalAuthDatasources(localConfig: sl<LocalConfig>()));

  sl.registerLazySingleton<AuthDatasources>(() => AuthDatasources(
        dio: sl<Dio>(),
        localAuthDatasources: sl<LocalAuthDatasources>(),
      ));

  // Repositories
  sl.registerLazySingleton<AuthRepositoriesImpl>(
    () => AuthRepositoriesImpl(authDatasources: sl<AuthDatasources>()),
  );

  // Use Cases
  sl.registerLazySingleton<LoginUserUsecase>(
      () => LoginUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<RefreshUserTokenUsecase>(() =>
      RefreshUserTokenUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<RegisterUserUsecase>(
      () => RegisterUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<ResetPassUserUsecase>(
      () => ResetPassUserUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<AuthicatedUsecase>(
      () => AuthicatedUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<LogOutUsecase>(
      () => LogOutUsecase(authRepositoriesImpl: sl<AuthRepositoriesImpl>()));

  sl.registerLazySingleton<ChangePasswordUsecase>(() =>
      ChangePasswordUsecase(authRepositories: sl<AuthRepositoriesImpl>()));

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl<LoginUserUsecase>(),
      sl<RefreshUserTokenUsecase>(),
      sl<RegisterUserUsecase>(),
      sl<ResetPassUserUsecase>(),
      sl<AuthicatedUsecase>(),
      sl<LogOutUsecase>(),
      sl<ChangePasswordUsecase>(),
    ),
  );

  //? Home Feature
  // Data Sources
  sl.registerLazySingleton<HomeDatasources>(
      () => HomeDatasources(dio: sl<Dio>()));

  // Repositories
  sl.registerLazySingleton<HomeRepositories>(
    () => HomeRepositoriesImpl(
      homeDatasources: sl<HomeDatasources>(),
    ),
  );

  //? Profile Feature
  // Data Sources
  sl.registerLazySingleton<ProfileDatasources>(() => ProfileDatasources(
        dio: sl<Dio>(),
        cachedProfile: null,
      ));

  // Repositories
  sl.registerLazySingleton<ProfileRepositories>(
    () => ProfileRepositoriesImpl(
        profileDatasources: sl<ProfileDatasources>(),
        profileLocalDataSources: sl<ProfileLocalDataSources>()),
  );
  sl.registerFactory(
      () => ProfileLocalDataSources(localConfig: sl<LocalConfig>()));

  // Use Cases
  sl.registerLazySingleton<AddPaymentMethodUsecase>(
    () => AddPaymentMethodUsecase(
      profileRepositories: sl<ProfileRepositories>(),
    ),
  );

  sl.registerLazySingleton<GetProfileUsecase>(
    () => GetProfileUsecase(
      profileRepositories: sl<ProfileRepositories>(),
    ),
  );

  sl.registerLazySingleton<UpdateProfileUsecase>(
    () => UpdateProfileUsecase(
      profileRepositories: sl<ProfileRepositories>(),
    ),
  );

  // Bloc
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      addPaymentMethodUsecase: sl<AddPaymentMethodUsecase>(),
      getProfileUsecase: sl<GetProfileUsecase>(),
      updateProfileUsecase: sl<UpdateProfileUsecase>(),
    ),
  );

  // Booking provider
  sl.registerFactoryParam<BookingProvider, LocationModel, void>(
    (locationModel, _) => BookingProvider(locationModel: locationModel),
  );
}
