import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/widgets/near_spot_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';

class ForInfoWidget extends StatelessWidget {
  const ForInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SearchWidgetHome(),
                SizedBox(
                  child: ListView.separated(
                    itemCount: 20,
                    separatorBuilder: (context, index) => 5.ws(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return NearSpotWidget(
                        orienter: 'Near Bus Station',
                        price: 12.50,
                        carSpots: '13',
                        distance: 8,
                      );
                    },
                  ),
                ),
              ],
            );
  }
}