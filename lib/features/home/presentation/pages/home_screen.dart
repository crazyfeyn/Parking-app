import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_home_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ZoomTapAnimation(
          child: Icon(
            Icons.menu,
          ),
        ),
        actions: [
          ZoomTapAnimation(
            child: Container(
              height: 45,
              width: 45,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_48),
              ),
              child: Image.asset(
                'assets/images/avatar.png',
              ),
            ),
          ),
          10.ws(),
        ],
      ),
      body: LiquidPullToRefresh(
        animSpeedFactor: 5,
        height: 200,
        color: Colors.black,
        child: const CustomScrollView(
          slivers: [
            SearchWidgetHome(),
          ],
        ),
        onRefresh: () => Future.delayed(
          const Duration(seconds: 1),
        ),
      ),
    );
  }
}
