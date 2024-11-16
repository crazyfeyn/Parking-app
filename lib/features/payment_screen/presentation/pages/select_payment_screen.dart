import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/payment_screen/presentation/widgets/card_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SelectPaymentScreen extends StatelessWidget {
  const SelectPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cards',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ZoomTapAnimation(
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimens.PADDING_12),
                    margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5D21E),
                      borderRadius:
                          BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Add Card',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        8.ws(),
                        const Icon(
                          Icons.add_circle_outline_rounded,
                          color: Colors.white,
                          size: 47,
                        ),
                      ],
                    )),
              ),
              for (int i = 0; i < 3; i++) const CardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
