import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';

class PerPriceWidget extends StatelessWidget {
  final String price;
  final String per;

  const PerPriceWidget({super.key, required this.price, required this.per});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$$price',

          style: const TextStyle(
            color: AppConstants.mainColor,
          ),
        ),
         Text(
          'Per $per',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
