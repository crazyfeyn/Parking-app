import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NearSpotWidget extends StatelessWidget {
  final String orienter;
  final double price;
  final String carSpots;
  final double distance;

  const NearSpotWidget({
    super.key,
    required this.orienter,
    required this.price,
    required this.carSpots,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZoomTapAnimation(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(AppDimens.PADDING_12),
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimens.MARGIN_8,
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      orienter,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Column(
                      children: [
                        Text(
                          '${price.toStringAsFixed(0)} won',
                          style: const TextStyle(
                            color: Color(0xFF3277D8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(
                          'for hr',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.car_fill,
                          color: Colors.blue,
                        ),
                        Text(
                          '$carSpots Cars Spots',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_walk_rounded,
                          color: Colors.blue,
                        ),
                        Text(
                          '${distance.toStringAsFixed(1)} km away',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        10.hs(),
      ],
    );
  }
}
