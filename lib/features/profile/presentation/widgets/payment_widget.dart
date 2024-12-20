import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  const PaymentWidget({super.key, required this.title, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/icons/$iconPath.png'),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
