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

  // USA bounds
  static LatLngBounds usaBounds = LatLngBounds(
    southwest: const LatLng(
        24.396308, -125.000000), // Southwest corner of continental US
    northeast: const LatLng(
        49.384358, -66.934570), // Northeast corner of continental US
  );

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
    _initializeData();
  }

  void _initializeData() async {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
    context.read<HomeBloc>().add(const HomeEvent.fetchAllLocations());
  }

  void _focusOnSearchedLocations(List<LocationModel> searchedLocations) {
    if (searchedLocations.isEmpty || _mapController == null) return;

    final validLocations = searchedLocations
        .where((loc) =>
            loc.latitude != null &&
            loc.longitude != null &&
            _isWithinUSA(loc.latitude!, loc.longitude!))
        .toList();

    if (validLocations.isEmpty) return;

    // For single location
    if (validLocations.length == 1) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(
              validLocations.first.latitude!, validLocations.first.longitude!),
          8, // Closer zoom for single location
        ),
      );
      return;
    }

    // For multiple locations, calculate visible region within USA bounds
    double minLat = validLocations
        .map((loc) => loc.latitude!)
        .reduce((a, b) => a < b ? a : b);
    double maxLat = validLocations
        .map((loc) => loc.latitude!)
        .reduce((a, b) => a > b ? a : b);
    double minLng = validLocations
        .map((loc) => loc.longitude!)
        .reduce((a, b) => a < b ? a : b);
    double maxLng = validLocations
        .map((loc) => loc.longitude!)
        .reduce((a, b) => a > b ? a : b);

    // Ensure we stay within USA bounds
    minLat = minLat.clamp(
        usaBounds.southwest.latitude, usaBounds.northeast.latitude);
    maxLat = maxLat.clamp(
        usaBounds.southwest.latitude, usaBounds.northeast.latitude);
    minLng = minLng.clamp(
        usaBounds.southwest.longitude, usaBounds.northeast.longitude);
    maxLng = maxLng.clamp(
        usaBounds.southwest.longitude, usaBounds.northeast.longitude);

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  bool _isWithinUSA(double lat, double lng) {
    return lat >= usaBounds.southwest.latitude &&
        lat <= usaBounds.northeast.latitude &&
        lng >= usaBounds.southwest.longitude &&
        lng <= usaBounds.northeast.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('No Internet, check your connection.'),
                duration: const Duration(seconds: 10),
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    _initializeData();
                  },
                ),
              ),
            );
          }

          if (state.searchLocations?.isNotEmpty == true) {
            _focusOnSearchedLocations(state.searchLocations!);
          }
        },
        builder: (context, state) {
          if (state.status == Status.initial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            );
          }

          return _buildGoogleMap(state);
        },
      ),
    );
  }

  Widget _buildGoogleMap(HomeState state) {
    // Use current location as the initial position if available
    final initialPosition =
        state.currentLocation ?? const LatLng(39.8283, -98.5795);

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
                      22,
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
            zoom: state.currentLocation != null
                ? 14
                : 4, // Zoom closer if current location is available
          ),
          minMaxZoomPreference: const MinMaxZoomPreference(4, 20),
          cameraTargetBounds: CameraTargetBounds(usaBounds),
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            _mapController = controller;
            controller
                .animateCamera(CameraUpdate.newLatLngBounds(usaBounds, 0));
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
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: FloatingActionButton(
            onPressed: () {
              if (state.currentLocation != null) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    state.currentLocation!,
                    22,
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
