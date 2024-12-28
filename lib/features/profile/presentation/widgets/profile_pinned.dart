import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePinned extends StatelessWidget {
  const ProfilePinned({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
         if (state.status == Status.error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Login Error'),
              content: const Text('Unknown error occurred'),
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
        print(state);
       
        if (state.status == Status.loading) {
          return _buildLoadingState();
        }
        if (state.status == Status.success) {
          final profile = state.profile;
          profile == null
              ? const Center(
                  child: Text('CAME NULL'),
                )
              : Container(
                  padding: const EdgeInsets.all(AppDimens.PADDING_20),
                  margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_12),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppDimens.BORDER_RADIUS_30),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      10.ws(),
                      const Text(
                        'Jessika hola',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.blackColor,
                        ),
                      )
                    ],
                  ),
                );
        }
        return Container(
          padding: const EdgeInsets.all(AppDimens.PADDING_20),
          margin: const EdgeInsets.only(bottom: AppDimens.MARGIN_12),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimens.BORDER_RADIUS_30),
            ),
            color: Colors.white,
          ),
        );
      },
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
