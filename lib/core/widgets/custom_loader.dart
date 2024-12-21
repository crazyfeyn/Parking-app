import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/lottie_loading.json',
        width: 60, height: 60);
  }
}
