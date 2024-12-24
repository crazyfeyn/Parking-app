import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
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
    // Fetch current location and all locations when screen initializes
    context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
    context.read<HomeBloc>().add(const HomeEvent.fetchAllLocations());
  }

  // Future<void> _getCurrentLocation() async {
  //   Dio dio = Dio();
  //   final s = SpotService(dio);
  //   await s.fetchAllSpots();
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     // Check if location services are enabled
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       throw Exception('Location services are disabled.');
  //     }

  //     // Check location permissions
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         throw Exception('Location permissions are denied.');
  //       }
  //     }

  //     // Get current position
  //     Position position = await Geolocator.getCurrentPosition();
  //     setState(() {
  //       currentLocation = LatLng(position.latitude, position.longitude);
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error retrieving location: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return _buildGoogleMap(state.locations);
            case Status.error:
              return const Center(
                child: Text('Error fetching location'),
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

    // Create markers for all fetched locations, ensuring each has a unique MarkerId
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
                onTap: () {
                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(loc.latitude!, loc.longitude!),
                      15.0,
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  // );

                  // You might also want to update some state or show additional UI
                }),
    };

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 5,
          ),
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
