import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/booking_space_screen.dart';
import 'package:flutter_application/features/history/presentation/widgets/parking_detail_screen.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:shimmer/shimmer.dart';

class FilterResultWidget extends StatelessWidget {
  const FilterResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: AppDimens.PADDING_20,
        left: AppDimens.PADDING_20,
        right: AppDimens.PADDING_20,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.94,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == Status.loading) {
            return _buildShimmer();
          }

          if (state.status == Status.error) {
            return const Center(
              child: Text(
                'An error occurred. Please try again.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (state.status == Status.success) {
            final locations = state.filterLocations;
            if (locations == null) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }

            if (locations.isEmpty) {
              return const Center(
                child: Text('No locations found'),
              );
            }

            return ListView.separated(
              itemCount: locations.length,
              separatorBuilder: (context, index) => 16.hs(),
              itemBuilder: (context, index) {
                final location = locations[index];
                return ZoomTapAnimation(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingSpaceScreen(
                          locationModel: location,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.PADDING_16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row with parking name and logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Parking name:',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  location.name.length <= 29
                                      ? location.name
                                      : '${location.name.substring(0, 29)}...',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/logo_1.png',
                              color: Colors.black,
                              height: 45,
                              width: 45,
                            ),
                          ],
                        ),
                        12.hs(),
                        // Row showing available spaces and rate details
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 115,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available spaces: ${location.availableSpots ?? 0}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Text(
                                    '${location.availableSpots} spaces are available now',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free parking for all types of vehicles:',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildRateWidget(
                                        location.dailyRate.toString(),
                                        'Per day'),
                                    17.ws(),
                                    _buildRateWidget(
                                        location.weeklyRate.toString(),
                                        'Per week'),
                                    17.ws(),
                                    _buildRateWidget(
                                        location.monthlyRate.toString(),
                                        'Monthly'),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        16.hs(),
                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ParkingDetailsScreen(
                                              location: location),
                                    ),
                                  );
                                },
                                child: const Text('Details'),
                              ),
                            ),
                            8.ws(),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingSpaceScreen(
                                          locationModel: location),
                                    ),
                                  );
                                },
                                child: const Text('Book'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }

  // Shimmer placeholder widget for loading state
  Widget _buildShimmer() {
    return ListView.separated(
      itemCount: 5, // Adjust this count as needed.
      separatorBuilder: (context, index) =>
          SizedBox(height: AppDimens.PADDING_20),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(AppDimens.PADDING_16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
              color: Colors.grey.shade200,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shimmer header row (Parking name and logo placeholder)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text placeholders
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 11,
                          width: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 16,
                          width: 120,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    // Image placeholder
                    Container(
                      height: 45,
                      width: 45,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Shimmer row for available spaces and rates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 10,
                      width: 115,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 10,
                      width: 150,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Shimmer row for buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRateWidget(String price, String period) {
    return Column(
      children: [
        Text(
          price,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          period,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
