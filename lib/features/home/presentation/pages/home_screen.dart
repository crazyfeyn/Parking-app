import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/datasources/spots_service.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application/features/home/presentation/widgets/button_for_map_widget.dart';
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
    Dio dio = await Dio();
    final s = SpotService(dio);
    await s.fetchAllSpots();
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
      // appBar: const AppBarWidget(),
      body: Stack(
        children: [
          isLoading || currentLocation == null
              ? const Center(
                  child: SizedBox(),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              50.hs(),
              const Row(
                children: [
                  SearchWidgetHome(),
                  FilterWidget(),
                ],
              )
            ],
          ),
          Positioned(
            right: 10,
            bottom: 10,
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
            bottom: 15,
            child: ButtonForMapWidget(
              onTap: _getCurrentLocation,
              child: const Icon(Icons.location_on),
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> markers = {};

  Future<void> _addCustomMarker(LatLng coordinates, String title) async {
    BitmapDescriptor customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/icons/location_icon.png',
    );

    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(title),
          position: coordinates,
          infoWindow: InfoWindow(title: title),
          icon: customIcon,
        ),
      );
    });
  }
}
