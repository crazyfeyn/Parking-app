import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/button_for_map_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    // Fetch current location when screen initializes
    context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          // Update current location when state is successful and data is available
          if (state.status == Status.success && state.currentLocation != null) {
            setState(() {
              currentLocation = state.currentLocation;
            });
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.success:
                return _buildGoogleMap();
              case Status.error:
                return const Center(
                  child: Text('Error fetching location'),
                );
              case Status.initial:
                return const Center(child: Text('Getting started...'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildGoogleMap() {
    // Default to a fallback location if current location is null
    final location = currentLocation ?? const LatLng(0, 0);

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 15,
          ),
          onMapCreated: (controller) {
            mapController = controller;
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: {
            if (currentLocation != null)
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: location,
                infoWindow: const InfoWindow(title: 'Current Location'),
              ),
          },
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
}
