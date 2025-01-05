import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class InfoTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const InfoTextWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subTitle,
          style: const TextStyle(
            fontSize: 14,
            color: AppConstants.shadeColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
