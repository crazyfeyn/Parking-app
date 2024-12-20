import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const InfoTextWidget(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
              fontSize: 12),
        ),
        Text(
          subTitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
