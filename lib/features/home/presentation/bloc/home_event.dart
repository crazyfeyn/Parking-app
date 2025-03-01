part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.fetchAllLocations() = _fetchAllLocations;
  const factory HomeEvent.fetchSearchLocations(String title) =
      _fetchSearchAllLocations;
  const factory HomeEvent.getCurrentLocation() = _getCurrentLocation;
  const factory HomeEvent.getVehicleList() = _getVehicleList;
  const factory HomeEvent.createVehicle(VehicleModel vehicleModel) =
      _createVehicle;
  const factory HomeEvent.filterLocation(FilterModel filterModel) =
      _filterLocation;
  const factory HomeEvent.fetchPaymentMethodList() = _fetchPaymentMethodList;
  const factory HomeEvent.clearSearchResults() = _clearSearchResults;
  const factory HomeEvent.updateIsDefaultCard(String id) = _updateIsDefaultCard;
  const factory HomeEvent.updateVehicle(VehicleModel vehicleModel) =
      _updateVehicle;
  const factory HomeEvent.clearFilterResults() = _clearFilterResults;
}
