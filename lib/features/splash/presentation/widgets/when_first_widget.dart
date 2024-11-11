import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/splash/presentation/widgets/first_widget.dart';

class WhenFirstWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const WhenFirstWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: FirstWidget(
          onTap: () {
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) =>  const LoginScreen(),
            //     ));
          },
          text: 'Skip',
          borderColor: AppConstants.mainColor,
        )),
        12.ws(),
        Expanded(
            child: FirstWidget(
          onTap: () {
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          text: 'Next',
          bgColor: AppConstants.mainColor,
          colorOfText: Colors.white,
        )),
      ],
    );
  }
}
