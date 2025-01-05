import 'package:bloc/bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/data/models/service_preferences_model.dart';
import 'package:flutter_application/features/home/domain/usecases/create_vehicle_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/current_location_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_locations_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/get_vehicle_list_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CurrentLocationUsecase currentLocationUsecase;
  final FetchLocationsUsecase fetchLocationsUsecase;
  final GetVehicleListUsecase getVehicleListUsecase;
  final CreateVehicleUsecase createVehicleUsecase;

  HomeBloc(this.currentLocationUsecase, this.fetchLocationsUsecase,
      this.getVehicleListUsecase, this.createVehicleUsecase)
      : super(const HomeState()) {
    on<_fetchAllLocations>(_fetchAllLocationsFunc);
    on<_getCurrentLocation>(_getCurrentLocationFunc);
    on<_getVehicleList>(_getVehicleListFunc);
    on<_createVehicle>(_createVehicleFunc);
  }

  Future<void> _fetchAllLocationsFunc(
      _fetchAllLocations event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await fetchLocationsUsecase(event.title);
    response.fold((error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }, (data) {
      emit(state.copyWith(status: Status.success, locations: data));
    });
  }

  Future<void> _getCurrentLocationFunc(
      _getCurrentLocation event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final response = await currentLocationUsecase.call(());
    response.fold((error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }, (locationData) {
      if (locationData != null) {
        final currentLocation =
            LatLng(locationData.latitude, locationData.longitude);
        emit(state.copyWith(
            status: Status.success, currentLocation: currentLocation));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: "Location data is null"));
      }
    });
  }

  Future<void> _getVehicleListFunc(
      _getVehicleList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await getVehicleListUsecase.call(());
    response.fold((error) {
      emit(
          state.copyWith(status: Status.error, errorMessage: error.toString()));
    }, (vehicleList) {
      emit(state.copyWith(status: Status.success, vehicleList: vehicleList));
    });
  }

  Future<void> _createVehicleFunc(
      _createVehicle event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await createVehicleUsecase.call(event.vehicleModel);

      add(const _getVehicleList());

      emit(
        state.copyWith(
          status: Status.success,
          createdVehicle: event.vehicleModel,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
