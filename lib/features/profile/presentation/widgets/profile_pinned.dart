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
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        if (state.status == Status.error) {
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
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                child: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'User2',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.blackColor,
                ),
              ),
              subtitle: const Text(
                'No Position',
              ),
            ),
          );
        }
        if (state.status == Status.loading) {
          return _buildLoadingState();
        }
        if (state.status == Status.success) {
          final profile = state.profile;
          return profile == null
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
                      Text(
                        profile.id.toString(),
                        style: const TextStyle(
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
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
              child: const Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppConstants.blackColor,
              ),
            ),
            subtitle: const Text(
              'No Position',
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 3,
      ),
    );
  }
}
