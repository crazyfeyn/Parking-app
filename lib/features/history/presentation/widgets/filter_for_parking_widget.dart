// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/home/data/models/filter_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/home/presentation/widgets/city_picker.dart';
import 'package:flutter_application/features/home/presentation/widgets/filter_result_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/parking_filter_model.dart';
import 'package:flutter_application/features/home/presentation/widgets/state_picker.dart';

class FilterForParkingWidget extends StatefulWidget {
  const FilterForParkingWidget({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FilterForParkingWidgetState createState() => _FilterForParkingWidgetState();
}

class _FilterForParkingWidgetState extends State<FilterForParkingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ZoomTapAnimation(
          onTap: () async {
            final filterModel = FilterModel();

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
                                    context.read<HomeBloc>().add(
                                          HomeEvent.filterLocation(filterModel),
                                        );
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
