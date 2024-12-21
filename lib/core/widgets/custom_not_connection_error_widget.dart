import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:lottie/lottie.dart';

class CustomNotConnectionErrorWidget extends StatelessWidget {
  const CustomNotConnectionErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            width: 120,
            height: 120,
            'assets/lottie/lottie_error.json',
          ),
        20.hs(),
          const Text(
            'Проверьте свое соединение',
            style:  TextStyle(fontSize: 17, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
