import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/city_picker.dart';
import 'package:flutter_application/features/home/presentation/widgets/mile_slider_widget.dart';
import 'package:flutter_application/features/home/presentation/widgets/state_picker.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(AppDimens.PADDING_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatePicker(onStateChanged: (state) {
                    // print(state);
                  }),
                  12.hs(),
                  CityPicker(onStateChanged: (city) {
                    // print(city);
                  }),
                  12.hs(),
                  MileSliderWidget(onChanged: (mile) {
                    // print(mile);
                  }),
                  const ButtonWidget(text: 'Add vehicle'),
                  32.hs(),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.PADDING_18,
          left: AppDimens.BORDER_RADIUS_10,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.PADDING_12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_15),
            color: Colors.white,
          ),
          child: Image.asset(
            'assets/icons/configure_icon.png',
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
