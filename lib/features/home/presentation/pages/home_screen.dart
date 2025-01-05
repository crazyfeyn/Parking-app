import 'package:flutter/material.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/booking_modal_bottom_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/button_for_map_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  bool isDataFetched = false; // Flag to avoid re-fetching data

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    // Fetch data only if it hasn't been fetched before
    if (!isDataFetched) {
      context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
      context.read<HomeBloc>().add(const HomeEvent.fetchAllLocations());
      isDataFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // Update current location when it changes
          if (state.currentLocation != null) {
            setState(() {
              currentLocation = state.currentLocation;
            });
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return _buildGoogleMap(state.locations);
            case Status.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.errorMessage}'),
                    20.hs(),
                    ElevatedButton(
                      onPressed: () {
                        // Retry fetching data
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.getCurrentLocation());
                        context
                            .read<HomeBloc>()
                            .add(const HomeEvent.fetchAllLocations());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            case Status.initial:
              return const Center(child: Text('Getting started...'));
          }
        },
      ),
    );
  }

  Widget _buildGoogleMap(List<LocationModel>? locations) {
    // Default to a fallback location if current location is null
    final location = currentLocation ?? const LatLng(33.592806, -84.388716);

    // Create markers for all fetched locations
    Set<Marker> markers = {
      if (currentLocation != null)
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: location,
          infoWindow: const InfoWindow(title: 'Current Location'),
        ),
      if (locations != null)
        for (var loc in locations)
          if (loc.latitude != null && loc.longitude != null)
            Marker(
              markerId: MarkerId(loc.id.toString()),
              position: LatLng(loc.latitude!, loc.longitude!),
              infoWindow: InfoWindow(title: loc.name),
              onTap: () async {
                // Zoom into the selected location
                mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(
                    LatLng(loc.latitude!, loc.longitude!),
                    15.0,
                  ),
                );
                // Show booking modal bottom sheet
                // ignore: use_build_context_synchronously
                showLocationDetails(context, loc);
              },
            ),
    };

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 5,
          ),
          zoomControlsEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
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
          right: 10,
          bottom: 10,
          child: Column(
            children: [
              ButtonForMapWidget(
                onTap: () {
                  mapController?.animateCamera(CameraUpdate.zoomIn());
                },
                child: const Icon(Icons.add, size: 30),
              ),
              10.hs(),
              ButtonForMapWidget(
                onTap: () {
                  mapController?.animateCamera(CameraUpdate.zoomOut());
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
        Positioned(
          left: 10,
          bottom: 15,
          child: ButtonForMapWidget(
            onTap: () {
              // Refresh current location
              context
                  .read<HomeBloc>()
                  .add(const HomeEvent.getCurrentLocation());
            },
            child: const Icon(Icons.location_on),
          ),
        ),
      ],
    );
  }

  // void showLocationDetails(BuildContext context, LocationModel location) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return BookingModalBottomWidget(locationModel: location);
  //     },
  //   );
  // }
}
