import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CardWidget extends StatelessWidget {
  final String cardNumber;

  const CardWidget({
    super.key,
    required this.cardNumber,
  });

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
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'assets/images/parking.png',
                color: Colors.black,
                height: 77,
                width: 77,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardNumber,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
