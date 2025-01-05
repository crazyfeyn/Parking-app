import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final newpassController = TextEditingController();
  final oldpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomProfileAppBarWidget(title: 'CUSTOM RESET PASS'),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Successfully changed'),
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
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Change Error'),
                  content: const Text('Your Old password dont correct'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
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
                  const Text('CUSTOM OLD PASSWORD'),
                  TextWidget(
                    controller: oldpassController,
                    labelText: 'Old password',
                  ),
                  const Text(
                    'CUSTOM NEW PASSWORD',
                  ),
                  TextWidget(
                    controller: newpassController,
                    labelText: 'New password',
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
