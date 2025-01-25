import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:flutter_application/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final passController = TextEditingController();
  final emailController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.doInitial());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.whiteColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == Status.errorNetwork) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('No Internet, check your connection.')),
                );
              } else if (state.status == Status.error) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    actionsAlignment: MainAxisAlignment.spaceBetween,
                    content: const Text(
                        'Invalid email or password. Please try again.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state.status == Status.success) {
                // Clear the navigation stack and navigate to MainScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                  (route) => false, // Remove all routes from the stack
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
                  child: _buildLoginForm(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
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
              topRight: Radius.circular(AppDimens.BORDER_RADIUS_30),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              // Email Field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppDimens.BORDER_RADIUS_10), // Add border radius
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

              // Password Field
              TextFormField(
                controller: passController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        AppDimens.BORDER_RADIUS_10), // Add border radius
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Spacer(),
                  ZoomTapAnimation(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Forgot password',
                        children: [
                          TextSpan(
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            text: ' Retrieve',
                          ),
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
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with login
                    context.read<AuthBloc>().add(AuthEvent.logIn(
                          passController.text,
                          emailController.text,
                        ));
                  }
                },
              ),
              20.hs(),
              ZoomTapAnimation(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: 'Don\'t have an account?',
                    children: [
                      TextSpan(
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        text: ' Register',
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
            'Logging in, please wait...',
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
