part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetchAllLocations() = _fetchAllLocations;
  const factory HomeEvent.getCurrentLocation() = _getCurrentLocation;
}
