import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

class CardTypeWidget extends StatelessWidget {
  const CardTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimens.MARGIN_8),
      padding: const EdgeInsets.all(AppDimens.PADDING_12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
        color: const Color(0xFFFFFFFF),
      ),
      child: Image.asset(
        'assets/cards/master_card.png',
        height: 45,
      ),
    );
  }
}
