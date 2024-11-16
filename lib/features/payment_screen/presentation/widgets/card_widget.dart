import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(AppDimens.PADDING_12),
        margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5D21E),
          borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(50)),
              child: Image.asset(
                'assets/cards/master_card.png',
                height: 77,
                width: 77,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3056****5904',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Keneyshka Jessika',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
