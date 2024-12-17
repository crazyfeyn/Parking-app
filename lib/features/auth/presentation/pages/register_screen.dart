import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
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
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              const Text(
                "Let`s Start",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xFF323232),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppDimens.PADDING_20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.758,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimens.BORDER_RADIUS_30),
                      topRight: Radius.circular(AppDimens.BORDER_RADIUS_30)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    TextWidget(
                      labelText: 'Enter your name',
                      controller: nameController,
                      keyboardType: TextInputType.name,
                    ),
                    TextWidget(
                      labelText: 'Enter your last name',
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                    ),
                    TextWidget(
                      labelText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextWidget(
                      labelText: 'Set your password',
                      controller: passController,
                      obscureText: true,
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    TextWidget(
                      labelText: 'Confirm password',
                      controller: confirmPassController,
                      obscureText: true,
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                    TextWidget(
                      labelText: 'Phone',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
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
        ));
  }
}
