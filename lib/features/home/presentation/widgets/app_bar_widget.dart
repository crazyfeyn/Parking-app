import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/profile/presentation/pages/profile_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ZoomTapAnimation(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: Container(
            height: 45,
            width: 45,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_48),
            ),
            child: Image.asset('assets/images/avatar.png'),
          ),
        ),
        10.ws(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
