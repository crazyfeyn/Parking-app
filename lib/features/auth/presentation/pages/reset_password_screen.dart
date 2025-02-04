import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  final newpassController = TextEditingController();

  final oldpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomProfileAppBarWidget(title: 'Change password'),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Successfully changed',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  content: const Text(
                      'Your password has been changed successfully.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ),
              );
            }
            if (state.status == Status.error) {
              AlertDialog(
                content: const Text(
                  'Change Error',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFF2357ED),
                        ),
                        child: const Text(
                          'The password you entered is incorrect. Please try again',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Retry'),
                  ),
                ],
              );
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return _buildLoadingState();
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Old password'),
                  8.hs(),
                  TextWidget(
                    controller: oldpassController,
                    labelText: 'Enter your old password',
                    obscureText: !_isOldPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isOldPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOldPasswordVisible = !_isOldPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const Text(
                    'New password',
                  ),
                  8.hs(),
                  TextWidget(
                    controller: newpassController,
                    labelText: 'Enter your new password',
                    obscureText: !_isNewPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordVisible = !_isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                  ButtonWidget(
                    text: 'Change',
                    onTap: () {
                      context.read<AuthBloc>().add(AuthEvent.change(
                          oldpassController.text, newpassController.text));
                    },
                  ),
                ],
              ),
            );
          },
        ));
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
            'Changing in, please wait...',
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
