import 'package:flutter/material.dart';
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
    _initializeData();
  }

  void _initializeData() async {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    context.read<HomeBloc>().add(const HomeEvent.getCurrentLocation());
    context.read<HomeBloc>().add(const HomeEvent.fetchAllLocations());
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
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    _initializeData();
                  },
                ),
              ),
            );
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
    final location =
        state.currentLocation ?? const LatLng(33.592806, -84.388716);

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
                onTap: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      LatLng(loc.latitude!, loc.longitude!),
                      15.0,
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
          key: _mapKey, // Use the unique key here
          initialCameraPosition: CameraPosition(
            target: location,
            zoom: 5,
          ),
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
              ],
            ),
          ],
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
