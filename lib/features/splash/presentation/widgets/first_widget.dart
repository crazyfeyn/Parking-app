// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FirstWidget extends StatelessWidget {
  final Color? bgColor;
  final Color? colorOfText;
  final Color? borderColor;
  final String text;
  final dynamic Function()? onTap;

  const FirstWidget({
    super.key,
    this.bgColor,
    this.onTap,
    this.colorOfText,
    this.borderColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(
            AppDimens.BORDER_RADIUS_24,
          ),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: colorOfText, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
