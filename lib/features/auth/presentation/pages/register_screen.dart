import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(27, 24, 41, 10),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: AppDimens.PADDING_50, left: AppDimens.PADDING_20),
                width: double.infinity,
                height: 225,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg_auth.png'),
                  ),
                ),
                child: const Text(
                  "Let`s Start",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.PADDING_20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.758,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    TextWidget(
                      labelText: 'Email',
                      controller: emailController,
                    ),
                    TextWidget(
                      labelText: 'password',
                      controller: passController,
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    TextWidget(
                      labelText: 'password authicated',
                      controller: confirmPassController,
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    TextWidget(
                      labelText: 'phone',
                      controller: phoneController,
                    ),
                    const Spacer(),
                    const ButtonWidget(text: 'Register'),
                    20.hs(),
                    ZoomTapAnimation(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          text: ' have an account?',
                          children: [
                            TextSpan(
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                                text: ' Login'),
                          ],
                        ),
                      ),
                    ),
                    20.hs(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
