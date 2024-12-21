import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            width: 180,
            height: 180,
            'assets/lottie/lottie_server.json',
          ),
          20.hs(),
          const Text(
            'Ошибка сервера',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
