part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(Status.initial) Status status,
    LatLng? currentLocation,
    List<LatLng>? locations,
    String? errorMessage,
  }) = _HomeState;
}
