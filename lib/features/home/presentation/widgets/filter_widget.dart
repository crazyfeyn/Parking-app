import 'package:flutter/material.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_result_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/home/data/models/filter_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/city_picker.dart';
import 'package:flutter_application/features/home/presentation/widgets/mile_slider_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/services_serction_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/state_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filterModel = FilterModel();

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ZoomTapAnimation(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DraggableScrollableSheet(
                      initialChildSize: 0.9,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      expand: false,
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(AppDimens.PADDING_16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StatePicker(
                                  onStateChanged: (state) {
                                    setState(() => filterModel.state = state);
                                  },
                                ),
                                8.hs(),
                                CityPicker(
                                  onStateChanged: (city) {
                                    setState(() => filterModel.city = city);
                                  },
                                ),
                                12.hs(),
                                MileSliderWidget(
                                  onChanged: (mile) {
                                    setState(() => filterModel.miles = mile);
                                  },
                                ),
                                8.hs(),
                                ServicesSectionWidget(
                                  title: 'Allowed services',
                                  items: filterModel.allowedServices,
                                  onChanged: (key, value) {
                                    setState(() {
                                      filterModel.allowedServices[key] = value;
                                    });
                                  },
                                ),
                                8.hs(),
                                ServicesSectionWidget(
                                  title: 'One service allowed',
                                  items: filterModel.oneServiceAllowed,
                                  onChanged: (key, value) {
                                    setState(() {
                                      filterModel.oneServiceAllowed[key] =
                                          value;
                                    });
                                  },
                                ),
                                8.hs(),
                                ServicesSectionWidget(
                                  title: 'Additional services',
                                  items: filterModel.additionalServices,
                                  onChanged: (key, value) {
                                    setState(() {
                                      filterModel.additionalServices[key] =
                                          value;
                                    });
                                  },
                                ),
                                8.hs(),
                                ButtonWidget(
                                  text: 'Filter',
                                  onTap: () {
                                    // Dispatch the filter event to the HomeBloc
                                    context.read<HomeBloc>().add(
                                          HomeEvent.filterLocation(filterModel),
                                        );
                                    // Close the bottom sheet and open the SearchOptionScreen
                                    Navigator.pop(context);
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) {
                                        return const FilterResultWidget();
                                      },
                                    );
                                  },
                                ),
                                32.hs(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppDimens.PADDING_18,
              left: AppDimens.BORDER_RADIUS_10,
            ),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.PADDING_12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/icons/configure_icon.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}
