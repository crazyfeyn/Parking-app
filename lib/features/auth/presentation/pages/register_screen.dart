import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isConfirmPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isPasswordMismatch = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
            // if (state.status == Status.error) {
            //   showDialog(
            //     context: context,
            //     builder: (context) => const AlertDialog(
            //       title: Text('Error when register'),
            //       content: Text('Error when register, this email exist'),
            //     ),
            //   );
            // }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return _buildLoadingState();
            }
            return SingleChildScrollView(
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
                        topRight: Radius.circular(AppDimens.BORDER_RADIUS_30),
                      ),
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
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordVisible,
                          builder: (context, isVisible, child) {
                            return TextWidget(
                              labelText: 'Set your password',
                              controller: passController,
                              obscureText: !isVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  _isPasswordVisible.value =
                                      !_isPasswordVisible.value;
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordMismatch,
                          builder: (context, isMismatch, child) {
                            return ValueListenableBuilder<bool>(
                              valueListenable: _isConfirmPasswordVisible,
                              builder: (context, isVisible, child) {
                                return TextField(
                                  controller: confirmPassController,
                                  obscureText: !isVisible,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm password',
                                    errorText: isMismatch
                                        ? 'Passwords do not match'
                                        : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: isMismatch
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        _isConfirmPasswordVisible.value =
                                            !_isConfirmPasswordVisible.value;
                                      },
                                    ),
                                  ),
                                  onChanged: (value) {
                                    _isPasswordMismatch.value =
                                        passController.text !=
                                            confirmPassController.text;
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const Spacer(),
                        ButtonWidget(
                          text: 'Register',
                          onTap: () {
                            if (passController.text !=
                                confirmPassController.text) {
                              _isPasswordMismatch.value = true;
                              return;
                            }
                            context.read<AuthBloc>().add(AuthEvent.register(
                                passController.text,
                                emailController.text,
                                nameController.text,
                                lastNameController.text));
                          },
                        ),
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
                              text: 'Have an account?',
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  text: ' Login',
                                ),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.red,
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          Text(
            'Registering, please wait...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
