import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/widgets/custom_loader.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/history/presentation/widgets/error_refresh_widget.dart';
import 'package:flutter_application/features/home/presentation/pages/main_screen.dart';
import 'package:flutter_application/features/payment_screen/presentation/pages/select_payment_screen.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/profile/presentation/pages/contact_detail_screen.dart';
import 'package:flutter_application/features/profile/presentation/pages/vehicles_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/leave_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/profile_pinned.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _refreshData() async {
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
    await context.read<ProfileBloc>().stream.firstWhere(
          (state) => state.status != Status.loading,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            showDialog(
                context: context,
                builder: (context) {
                  return ErrorRefreshWidget(
                      onRefresh: () => Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()),
                            (Route<dynamic> route) => false,
                          ));
                });
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return _buildLoadingState();
            }

            return _buildSuccessState(state);
          },
        ),
      ),
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

  Widget _buildSuccessState(ProfileState state) {
    final profile = state.profile;

    if (profile == null) {
      return const Center(
        child: Text('No data available to display'),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfilePinned(profile: profile),
                _buildProfileOptions(profile),
                const SizedBox(height: 8),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOptions(dynamic profile) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.PADDING_16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_30),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _profileButton(
            'phone',
            'Contact Details',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailScreen(
                  profileEntity: profile,
                ),
              ),
            ),
          ),
          _profileButton(
            'listing',
            'Your Listings',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryScreen(pageNumber: 1),
              ),
            ),
          ),
          _profileButton(
            'card',
            'My Cards',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectPaymentScreen(),
              ),
            ),
          ),
          _profileButton(
            'vehicle',
            'Your Vehicles',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VehiclesScreen(),
              ),
            ),
          ),
          _profileButton(
            'vehicle',
            'Change Password',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ResetPasswordScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileButton(String iconPath, String title, VoidCallback? onTap) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          'assets/icons/${iconPath}_icon.png',
          color: AppConstants.mainColor,
          height: 20,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == Status.success) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else if (state.status == Status.error) {
          showDialog(
              context: context,
              builder: (context) {
                return ErrorRefreshWidget(
                    onRefresh: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (Route<dynamic> route) => false,
                        ));
              });
        }
      },
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const CustomLoader();
        }

        return GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => const LeaveWidget(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.BORDER_RADIUS_30),
              color: Colors.white,
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.asset(
                'assets/icons/log_icon.png',
                color: AppConstants.mainColor,
                height: 20,
              ),
              title: const Text('Logout'),
            ),
          ),
        );
      },
    );
  }
}
