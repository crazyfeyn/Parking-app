// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';

import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatefulWidget {
  final ProfileEntity profileEntity;
  UpdateProfileScreen({
    super.key,
    required this.profileEntity,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = widget.profileEntity;
    nameController.text =
        profile.first_name.isEmpty ? "Name" : profile.first_name;
    surnameController.text =
        profile.last_name.isEmpty ? "Surname" : profile.last_name;
    emailController.text = profile.email.isEmpty ? "Email" : profile.email;
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBarWidget(title: 'Update Profile'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextWidget(controller: nameController, labelText: "Name"),
            TextWidget(controller: surnameController, labelText: "Surname"),
            TextWidget(controller: emailController, labelText: "Email"),
            BlocConsumer<ProfileBloc, ProfileState>(
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
                  showErrorDialog(context, 'Unknown error occurred');
                }
              },
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return _buildLoadingState();
                }
                return ButtonWidget(
                  text: 'Change',
                  onTap: () {
                    context.read<ProfileBloc>().add(
                          ProfileEvent.updateProfile(
                            name: nameController.text,
                            surname: surnameController.text,
                            email: emailController.text,
                          ),
                        );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildLoadingState() {
  return const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 3,
      ),
      SizedBox(height: 16),
      Text('Please wait...'),
    ],
  );
}
