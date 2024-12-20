import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

class WhiteBackWidget extends StatelessWidget {
  final Widget widget;
  const WhiteBackWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_16),
            color: AppConstants.whiteColor),
        padding: const EdgeInsets.all(AppDimens.PADDING_10),
        child: widget);
  }
}
