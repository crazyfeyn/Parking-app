part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(Status.initial) Status status,
    LatLng? currentLocation,
    List<LocationModel>? locations,
    String? errorMessage,
    String? searchQuery,
    @Default(ServicePreferences()) ServicePreferences servicePreferences,
    List<VehicleModel>? vehicleList,
    VehicleModel? createdVehicle,
  }) = _HomeState;
}
