import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/booking_space_screen.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/per_price_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

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
            final locations = state.filterLocations;
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
                        separatorBuilder: (context, index) => 8.hs(),
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
                              height: MediaQuery.of(context).size.height * 0.23,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimens.BORDER_RADIUS_16),
                                color: Colors.grey.shade300,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    location.name,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          location.description,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Spacer(),
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 16,
                                        backgroundImage: AssetImage(
                                            'assets/images/parking.png'),
                                      ),
                                    ],
                                  ),
                                  12.hs(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              location.phNumber,
                                              style: TextStyle(
                                                  color: Colors.grey.shade700),
                                            ),
                                            8.hs(),
                                            const Text(
                                              '18 spaces are available now',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Available spaces',
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const PerPriceWidget(
                                                  price: '20', per: 'day'),
                                              10.ws(),
                                              const PerPriceWidget(
                                                  price: '120', per: 'week'),
                                              10.ws(),
                                              const PerPriceWidget(
                                                  price: '250', per: 'monthly'),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
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
}
