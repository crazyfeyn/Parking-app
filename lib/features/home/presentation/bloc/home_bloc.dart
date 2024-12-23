import 'package:bloc/bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/home/domain/usecases/current_location_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_locations_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  CurrentLocationUsecase currentLocationUsecase;
  FetchLocationsUsecase fetchLocationsUsecase;

  HomeBloc(this.currentLocationUsecase, this.fetchLocationsUsecase)
      : super(HomeState()) {
    on<_fetchAllLocations>(_fetchAllLocationsFunc);
    on<_getCurrentLocation>(_getCurrentLocationFunc);
  }

  Future<void> _fetchAllLocationsFunc(
      _fetchAllLocations event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await fetchLocationsUsecase.call(());
    response.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }

  Future<void> _getCurrentLocationFunc(
      _getCurrentLocation event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await currentLocationUsecase.call(());
    response.fold((error) {
      emit(
        state.copyWith(status: Status.error),
      );
    }, (data) {
      emit(
        state.copyWith(status: Status.success),
      );
    });
  }
}
