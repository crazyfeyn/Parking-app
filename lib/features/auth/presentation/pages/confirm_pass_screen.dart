import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ConfirmPassScreen extends StatelessWidget {
  const ConfirmPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.PADDING_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            100.hs(),
            Image.asset(
              'assets/images/forgot_pass.png',
              height: 250,
            ),
            20.hs(),
            const Center(
              child: Text(
                'Check your email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            10.hs(),
            const Text(
                'Tempor est dolore eiusmod fugiat aQuis consectetur excepteur qui consectetur nisi id labore nulla proident amet in commodo magna.liquip laborum in.'),
            40.hs(),
            const ButtonWidget(text: 'Open Email app'),
            20.hs(),
            Center(
              child: ZoomTapAnimation(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    text:
                        'Didn’t receive the email? Check your spam filter,\n or ',
                    children: [
                      TextSpan(
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                          text: 'try another email address'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
