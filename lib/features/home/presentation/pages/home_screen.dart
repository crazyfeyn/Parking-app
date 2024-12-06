import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:flutter_application/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/button_for_map_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/near_spot_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:flutter_application/core/extension/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        isLoading = false;
      });
    } catch (e) {
      print('Error retrieving location: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: LiquidPullToRefresh(
        animSpeedFactor: 5,
        height: MediaQuery.of(context).size.height * 0.2,
        color: Colors.black,
        onRefresh: () async {
          await _getCurrentLocation();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Stack(
          children: [
            isLoading || currentLocation == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation!,
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: {
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          position: currentLocation!,
                          infoWindow: const InfoWindow(
                            title: 'Current Location',
                          ),
                        ),
                      },
                    ),
                  ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchWidgetHome(),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (context, index) => 5.ws(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const NearSpotWidget(
                      orienter: 'Near Bus Station',
                      price: 12.50,
                      carSpots: '13',
                      distance: 8,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 120,
              child: Column(
                children: [
                  ButtonForMapWidget(
                    onTap: () {
                      mapController?.animateCamera(
                        CameraUpdate.zoomIn(),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                  10.hs(),
                  ButtonForMapWidget(
                    onTap: () {
                      mapController?.animateCamera(
                        CameraUpdate.zoomOut(),
                      );
                    },
                    child: const Icon(Icons.remove),
                  )
                ],
              ),
            ),
            Positioned(
              left: 10,
              bottom: 120,
              child: ButtonForMapWidget(
                onTap: _getCurrentLocation,
                child: const Icon(Icons.location_on),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
