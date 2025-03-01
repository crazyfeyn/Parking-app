import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/error/failure.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/data/models/filter_model.dart';
import 'package:flutter_application/features/home/data/models/service_preferences_model.dart';
import 'package:flutter_application/features/home/domain/usecases/create_vehicle_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/current_location_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_locations_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_payment_method_list.dart';
import 'package:flutter_application/features/home/domain/usecases/fetch_search_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/filter_locations_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/get_vehicle_list_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/update_is_default_card_usecase.dart';
import 'package:flutter_application/features/home/domain/usecases/update_vehicle_usecase.dart';
import 'package:flutter_application/features/payment_screen/presentation/data/models/list_payment_methods.dart';
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
  final FetchSearchUsecase fetchSearchUsecase;
  final FetchPaymentMethodListUsecase fetchPaymentMethodListUsecase;
  final FilterLocationsUsecase filterLocationsUsecase;
  final UpdateVehicleUsecase updateVehicleUsecase;
  final UpdateIsDefaultCardUsecase updateIsDefaultCardUsecase;

  HomeBloc(
    this.currentLocationUsecase,
    this.fetchLocationsUsecase,
    this.getVehicleListUsecase,
    this.createVehicleUsecase,
    this.fetchSearchUsecase,
    this.fetchPaymentMethodListUsecase,
    this.filterLocationsUsecase,
    this.updateVehicleUsecase,
    this.updateIsDefaultCardUsecase,
  ) : super(const HomeState()) {
    on<_fetchAllLocations>(_fetchAllLocationsFunc);
    on<_fetchSearchAllLocations>(_fetchSearchAllLocationsFunc);
    on<_getCurrentLocation>(_getCurrentLocationFunc);
    on<_getVehicleList>(_getVehicleListFunc);
    on<_createVehicle>(_createVehicleFunc);
    on<_fetchPaymentMethodList>(_fetchPaymentMethodListFunc);
    on<_filterLocation>(_filterLocationsFunc);
    on<_clearSearchResults>(_clearSearchResultsFunc);
    on<_updateVehicle>(_updateVehicleFunc);
    on<_updateIsDefaultCard>(_updateIsDefaultCardFunc);
    on<_clearFilterResults>(_clearFilterResultsFunc);
  }

  Future<void> _fetchSearchAllLocationsFunc(
      _fetchSearchAllLocations event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await fetchSearchUsecase(event.title);
    response.fold((error) {
      emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString()));
    }, (data) {
      emit(state.copyWith(status: Status.success, searchLocations: data));
    });
  }

  Future<void> _fetchAllLocationsFunc(
      _fetchAllLocations event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await fetchLocationsUsecase(null);
    response.fold(
      (error) {
        emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString(),
        ));
      },
      (data) {
        emit(state.copyWith(status: Status.success, locations: data));
      },
    );
  }

  Future<void> _getCurrentLocationFunc(
      _getCurrentLocation event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final response = await currentLocationUsecase.call(());

    response.fold(
      (error) {
        emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString(),
          // Maintain previous location if there was an error
          currentLocation: state.currentLocation,
        ));
      },
      (locationData) {
        if (locationData.latitude != null && locationData.longitude != null) {
          final currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          emit(state.copyWith(
            status: Status.success,
            currentLocation: currentLocation,
          ));
        } else {
          emit(state.copyWith(
            status: Status.error,
            errorMessage: "Location data is null",
            currentLocation: state.currentLocation,
          ));
        }
      },
    );
  }

  Future<void> _getVehicleListFunc(
      _getVehicleList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await getVehicleListUsecase.call(());
    response.fold((error) {
      emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString()));
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

  Future<void> _fetchPaymentMethodListFunc(
      _fetchPaymentMethodList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final response = await fetchPaymentMethodListUsecase.call(());
    response.fold((error) {
      emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString()));
    }, (paymentMethodList) {
      emit(state.copyWith(
          status: Status.success, listPaymentMethod: paymentMethodList));
    });
  }

  Future<void> _filterLocationsFunc(
      _filterLocation event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final filterParams = event.filterModel.toFilterLocationsParams();

    final response = await filterLocationsUsecase.call(filterParams);

    response.fold(
      (error) {
        emit(
          state.copyWith(
            status:
                error is NetworkFailure ? Status.errorNetwork : Status.error,
            errorMessage: error.toString(),
          ),
        );
      },
      (locations) {
        emit(
            state.copyWith(status: Status.success, filterLocations: locations));
      },
    );
  }

  Future<void> _clearSearchResultsFunc(
      _clearSearchResults event, Emitter<HomeState> emit) async {
    emit(state.copyWith(searchLocations: []));
  }

  Future<void> _clearFilterResultsFunc(
      _clearFilterResults event, Emitter<HomeState> emit) async {
    emit(state.copyWith(filterLocations: null));
  }

  Future<void> _updateVehicleFunc(
      _updateVehicle event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      await updateVehicleUsecase.call(event.vehicleModel);

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

  Future<void> _updateIsDefaultCardFunc(
      _updateIsDefaultCard event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      // Update the default card
      await updateIsDefaultCardUsecase.call(event.id);

      // Fetch the updated payment method list
      final response = await fetchPaymentMethodListUsecase.call(());

      response.fold((error) {
        emit(state.copyWith(
          status: error is NetworkFailure ? Status.errorNetwork : Status.error,
          errorMessage: error.toString(),
        ));
      }, (paymentMethodList) {
        emit(state.copyWith(
          status: Status.success,
          listPaymentMethod: paymentMethodList,
        ));
      });
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
