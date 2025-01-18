import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: AppDimens.MARGIN_20),
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_20),
          color: Colors.grey.shade300,
        ),
        child: Image.asset(
          'assets/icons/back_icon.png',
          width: 14,
        ),
      ),
    );
  }
}
