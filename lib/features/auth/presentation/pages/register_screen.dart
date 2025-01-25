import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isConfirmPasswordVisible = ValueNotifier(false);

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
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return _buildLoadingState();
            }
            return SingleChildScrollView(
              child: Form(
                key: _formKey, // Assign the form key
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
                          // Name Field
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Enter your name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Last Name Field
                          TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Enter your last name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          ValueListenableBuilder<bool>(
                            valueListenable: _isPasswordVisible,
                            builder: (context, isVisible, child) {
                              return TextFormField(
                                controller: passController,
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  labelText: 'Set your password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
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
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password Field
                          ValueListenableBuilder<bool>(
                            valueListenable: _isConfirmPasswordVisible,
                            builder: (context, isVisible, child) {
                              return TextFormField(
                                controller: confirmPassController,
                                obscureText: !isVisible,
                                decoration: InputDecoration(
                                  labelText: 'Confirm password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != passController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          const Spacer(),
                          ButtonWidget(
                            text: 'Register',
                            onTap: () {
                              // Validate the form
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, proceed with registration
                                context.read<AuthBloc>().add(AuthEvent.register(
                                      passController.text,
                                      emailController.text,
                                      nameController.text,
                                      lastNameController.text,
                                    ));
                              }
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
