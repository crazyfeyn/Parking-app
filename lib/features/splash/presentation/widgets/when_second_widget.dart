import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class WhenSecondWidget extends StatelessWidget {
  const WhenSecondWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppConstants.mainColor,
          borderRadius: BorderRadius.circular(
            AppDimens.BORDER_RADIUS_24,
          ),
        ),
        child: const Text(
          "Explore",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
