import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/booking_modal_bottom_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  final UniqueKey _mapKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    _clearFilter();
  }

  // void _initializeData() async {
  //   context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  //   context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
  //   context.read<HomeBloc>().add(const HomeEvent.fetchAllLocations());
  // }

  void _clearFilter() async {
    context.read<HomeBloc>().add(const HomeEvent.clearFilterResults());
  }

  void _focusOnSearchedLocations(List<LocationModel> searchedLocations) {
    if (searchedLocations.isEmpty || _mapController == null) return;

    final validLocations = searchedLocations
        .where((loc) => loc.latitude != null && loc.longitude != null)
        .toList();

    if (validLocations.isEmpty) return;

    if (validLocations.length == 1) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
              validLocations.first.latitude!, validLocations.first.longitude!),
          10,
        ),
      );
    } else {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          const LatLng(37.0902, -95.7129),
          4,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == Status.errorNetwork) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('No Internet, check your connection.'),
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'Retry',
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(const HomeEvent.fetchAllLocations());
                    },
                  ),
                ),
              );
            }

            if (state.searchLocations?.isNotEmpty == true) {
              _focusOnSearchedLocations(state.searchLocations!);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.currentLocation != current.currentLocation ||
                previous.locations != current.locations,
            builder: (context, state) {
              if (state.status == Status.initial) {
                return const Center(child: CircularProgressIndicator());
              }
              return _buildGoogleMap(state);
            },
          ),
        ));
  }

  Widget _buildGoogleMap(HomeState state) {
    final initialPosition = state.currentLocation ?? const LatLng(0, 0);

    Set<Marker> markers = {
      if (state.currentLocation != null)
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: state.currentLocation!,
          infoWindow: const InfoWindow(title: 'Current Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      if (state.locations != null)
        ...state.locations!
            .where((loc) => loc.latitude != null && loc.longitude != null)
            .map(
              (loc) => Marker(
                markerId: MarkerId(loc.id.toString()),
                position: LatLng(loc.latitude!, loc.longitude!),
                infoWindow: InfoWindow(title: loc.name),
                icon: state.searchLocations
                            ?.any((searchLoc) => searchLoc.id == loc.id) ==
                        true
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)
                    : BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                onTap: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(loc.latitude!, loc.longitude!),
                      15,
                    ),
                  );
                  showLocationDetails(context, loc);
                },
              ),
            ),
    };

    return Stack(
      children: [
        GoogleMap(
          key: _mapKey,
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: state.currentLocation != null ? 10 : 2,
          ),
          minMaxZoomPreference: const MinMaxZoomPreference(2, 20),
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: markers,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            50.hs(),
            const Row(
              children: [
                SearchWidgetHome(),
                FilterWidget(),
                SizedBox(
                  width: 16,
                )
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              context
                  .read<HomeBloc>()
                  .add(const HomeEvent.clearSearchResults());
              if (state.currentLocation != null) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    state.currentLocation!,
                    15,
                  ),
                );
              } else {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    const LatLng(37.0902, -95.7129),
                    2,
                  ),
                );
              }
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
