part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetchAllLocations(String title) = _fetchAllLocations;
  const factory HomeEvent.getCurrentLocation() = _getCurrentLocation;
  const factory HomeEvent.getVehicleList() = _getVehicleList;
  const factory HomeEvent.createVehicle(VehicleModel vehicleModel) = _createVehicle;
}
