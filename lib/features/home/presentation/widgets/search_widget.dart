import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/home/presentation/widgets/search_option_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});
  openGotNext(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.BORDER_RADIUS_20),
        ),
      ),
      builder: (context) {
        return SearchOptionScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ZoomTapAnimation(
          onTap: () {
            openGotNext(context);
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimens.PADDING_10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.057,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Where to park?',
                  style: TextStyle(fontSize: 16),
                ),
                Image.asset(
                  'assets/icons/search.png',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
