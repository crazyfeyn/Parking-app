import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/custom_error_widget.dart';
import 'package:flutter_application/core/widgets/custom_loader.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:flutter_application/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter_application/features/home/presentation/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final passController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == Status.success) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              }
            },
            builder: (context, state) {
              print(state);
              if (state.status == Status.error) {
                return CustomErrorWidget();
              }
              if (state.status == Status.loading) {
                return CustomLoader();
              }

              return Column(
                children: [
                  const Text(
                    "Log in",
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
                          topRight:
                              Radius.circular(AppDimens.BORDER_RADIUS_30)),
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
                        Row(
                          children: [
                            const Spacer(),
                            ZoomTapAnimation(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  text: 'Forgot password',
                                  children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        text: ' Retrive'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ButtonWidget(
                          text: 'Login',
                          onTap: () {
                            context.read<AuthBloc>().add(AuthEvent.logIn(
                                passController.text, emailController.text));
                          },
                        ),
                        20.hs(),
                        ZoomTapAnimation(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ));
                          },
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              text: 'Don`t have an account?',
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                    text: ' Register'),
                              ],
                            ),
                          ),
                        ),
                        20.hs(),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
        ));
  }
}
