import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/booking_space_screen.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SearchOptionScreen extends StatelessWidget {
  const SearchOptionScreen({super.key});

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
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == Status.error) {
            return const Center(
              child: Text("Not Found"),
            );
          }
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 3,
              ),
            );
          }
          if (state.status == Status.success) {
            final locations = state.searchLocations;
            return locations == null
                ? const Center(
                    child: Text('Something went wrong'),
                  )
                : locations.isEmpty
                    ? const Center(
                        child: Text('No locations found'),
                      )
                    : ListView.separated(
                        itemCount: locations.length,
                        separatorBuilder: (context, index) => 16.hs(),
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return ZoomTapAnimation(
                            onTap: () {
                              // Navigate to the booking screen
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
                              padding:
                                  const EdgeInsets.all(AppDimens.PADDING_16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimens.BORDER_RADIUS_12),
                                color: Colors.grey.shade200,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            'Parking name:',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          Text(
                                            location.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 115,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  location.weeklyRate
                                                      .toString(),
                                                  'Per week'),
                                              17.ws(),
                                              _buildRateWidget(
                                                  location.monthlyRate
                                                      .toString(),
                                                  'Monthly'),
                                            ],
                                          ),
                                        ],
                                      )
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
