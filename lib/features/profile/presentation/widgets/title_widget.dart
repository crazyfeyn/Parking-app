import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
