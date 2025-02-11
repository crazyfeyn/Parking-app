import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/data/models/filter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/history/presentation/widgets/filter_for_parking_widget.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_item_widget.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final TextEditingController searchController = TextEditingController();
  List<LocationModel> searchedLocations = [];

  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeEvent.clearSearchResults());
    super.initState();
  }

  void searchLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        searchedLocations = [];
      } else {
        searchedLocations = (context.read<HomeBloc>().state.locations ?? [])
            .where((location) =>
                location.name.toLowerCase().contains(query.toLowerCase()) ||
                location.address.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.locations != current.locations ||
            previous.filterLocations != current.filterLocations,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return _buildShimmer();
          }

          if (state.status == Status.errorNetwork) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No Internet, check your connection.'),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<HomeBloc>()
                          .add(const HomeEvent.fetchAllLocations());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Handle filtered locations
          final List<LocationModel> locationsToDisplay;
          if (state.filterLocations != null) {
            // If filterLocations is empty, show no locations
            if (state.filterLocations!.isEmpty) {
              locationsToDisplay = [];
            } else {
              locationsToDisplay = state.filterLocations!;
            }
          } else {
            // No filter applied, show all locations
            locationsToDisplay = state.locations ?? [];
          }

          final List<LocationModel> filteredLocations =
              searchController.text.isEmpty
                  ? locationsToDisplay
                  : locationsToDisplay
                      .where((location) =>
                          location.name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()) ||
                          location.address
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                      .toList();

          return _buildBookingList(
            filteredLocations,
            state.filterLocations?.isEmpty == true
                ? 'No locations match your filters'
                : 'No locations available',
          );
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
                  borderRadius:
                      BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchController,
                  onChanged: searchLocations,
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
              FilterForParkingWidget(
                onTap: filterFunc,
              ),
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
                    return ParkingItem(location: location);
                  },
                ),
        ),
      ],
    );
  }

  void filterFunc(FilterModel filterModel) {
    context.read<HomeBloc>().add(
          HomeEvent.filterLocation(filterModel),
        );
  }

  Widget _buildShimmer() {
    return Column(
      children: [
        30.hs(),
        Expanded(
          // Ensuring ListView takes available space
          child: ListView.builder(
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 130,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          2,
                          (_) => Container(
                            height: 16,
                            width: 80,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          2,
                          (_) => Container(
                            height: 16,
                            width: 80,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 16,
                        width: 120,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),
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
