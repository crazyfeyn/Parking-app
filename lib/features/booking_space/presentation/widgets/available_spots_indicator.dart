import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/white_back_widget.dart';

class AvailableSpotsIndicator extends StatelessWidget {
  final int availableSpots;
  const AvailableSpotsIndicator({super.key, required this.availableSpots});

  @override
  Widget build(BuildContext context) {
    return WhiteBackWidget(
      widget: Row(
        children: [
          Image.asset(
            'assets/icons/warning_icon.png',
            height: 28,
            width: 28,
          ),
          10.ws(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                availableSpots > 0 ? 'Spaces available' : 'No spaces available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: availableSpots > 0
                      ? AppConstants.blackColor
                      : AppConstants.mainColor,
                ),
              ),
              Text(
                '$availableSpots available',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: availableSpots > 0
                      ? AppConstants.blackColor
                      : AppConstants.mainColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
