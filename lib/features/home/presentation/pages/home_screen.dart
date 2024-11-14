import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/datasources/define_place_with_lat_lng_datasource.dart';
import 'package:flutter_application/features/home/data/datasources/location_datasource.dart';
import 'package:flutter_application/features/profile/presentation/pages/profile_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ZoomTapAnimation(
          child: Icon(Icons.menu),
        ),
        actions: [
          ZoomTapAnimation(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
            child: Container(
              height: 45,
              width: 45,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_48),
              ),
              child: Image.asset('assets/images/avatar.png'),
            ),
          ),
          10.ws(),
        ],
      ),
      body: LiquidPullToRefresh(
        animSpeedFactor: 5,
        height: 200,
        color: Colors.black,
        onRefresh: () async {
          await _getCurrentLocation();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Stack(
          children: [
            isLoading || currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation!,
                        zoom: 15,
                        tilt: 0,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SearchWidgetHome(),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < 4; i++)
                          ZoomTapAnimation(
                            onTap: () {},
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppDimens.PADDING_12),
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppDimens.MARGIN_8,
                              ),
                              width: 270,
                              height: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimens.BORDER_RADIUS_15),
                                color: Colors.white,
                              ),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vunupal geod locator',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'On Spot Paking',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '100 won',
                                            style: TextStyle(
                                              color: Color(0xFF3277D8),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            'for hr',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.car_fill,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            '15 Cars Spots',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.directions_walk_rounded,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            '1.3 km away',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await LocationService.getCurrentLocation();
      setState(() {
        currentLocation = LatLng(
          location.latitude ?? 35.8430201,
          location.longitude ?? 127.1376109,
        );
        isLoading = false;
      });

      // Get address for the location
      if (currentLocation != null) {
        final address = await DefinePlaceWithLatlng.getAddressFromCoordinates(
          currentLocation!.latitude,
          currentLocation!.longitude,
        );
        print('Current address: $address');
      }
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}
