import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/history/presentation/widgets/filter_for_parking_widget.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_item_widget.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class ParkingScreen extends StatefulWidget {
  final List<LocationModel>? locations;
  const ParkingScreen(this.locations, {super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with SingleTickerProviderStateMixin {
  final searchController = TextEditingController();
  List<LocationModel> searchedLocations = [];
  List<LocationModel> allLocations = [];

  @override
  void initState() {
    super.initState();
    // Initialize allLocations and searchedLocations with widget.locations
    allLocations = widget.locations ?? [];
    searchedLocations = List.from(allLocations);
  }

  void searchLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        searchedLocations = List.from(allLocations);
      } else {
        searchedLocations = allLocations.where((location) {
          return location.name.toLowerCase().contains(query.toLowerCase()) ||
              location.address.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.locations);
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == Status.errorNetwork) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('No Internet, check your connection.'),
                duration: const Duration(seconds: 3),
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
        },
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            );
          } else if (state.status == Status.success) {
            // Add any additional handling for the success state if needed
          }

          return _buildBookingList(searchedLocations, 'No locations available');
        },
      ),
    );
  }

  Widget _buildBookingList(List<LocationModel> locations, String emptyMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 60, right: 20),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.057,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius:
                      BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) => searchLocations(value),
                  decoration: InputDecoration(
                    labelText: 'Where to park',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        searchLocations('');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const FilterForParkingWidget(), // Updated
            ],
          ),
        ),
        16.hs(),
        Expanded(
          child: locations.isEmpty
              ? Center(
                  child: Text(
                    searchController.text.isNotEmpty
                        ? 'No matching locations found'
                        : emptyMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return ParkingItem(
                      location: location,
                    );
                  },
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
