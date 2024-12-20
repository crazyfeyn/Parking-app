import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BackButtonCircleWidget extends StatelessWidget {
  const BackButtonCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
        left: 16,
      ),
      child: ZoomTapAnimation(
        onTap: () {
          Navigator.pop(context);
        },
        child: const CircleAvatar(
          backgroundColor: AppConstants.grayColor,
          radius: 52,
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
    );
  }
}
