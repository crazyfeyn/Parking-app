import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final dynamic Function()? onTap;
  final Color? bgColor;
  const ButtonWidget({super.key, required this.text, this.onTap, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.98,
        height: MediaQuery.of(context).size.height * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(
            AppDimens.BORDER_RADIUS_15,
          ),
          color: bgColor ?? AppConstants.mainColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
