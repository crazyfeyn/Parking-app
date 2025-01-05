import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/custom_error_widget.dart';
import 'package:flutter_application/core/widgets/custom_loader.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/payment_screen/presentation/pages/select_payment_screen.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/profile/presentation/pages/contact_detail_screen.dart';
import 'package:flutter_application/features/profile/presentation/pages/payments_screen.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == Status.error) {
            return Column(
              children: [
                Container(
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
                    subtitle: const Text('No Position'),
                  ),
                ),
                const CustomErrorWidget(),
              ],
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
                : SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfilePinned(profile: profile),
                            Container(
                              padding:
                                  const EdgeInsets.all(AppDimens.PADDING_16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimens.BORDER_RADIUS_30),
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _profileButtons(
                                    'phone',
                                    'Contact details',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ContactDetailScreen(
                                            profileEntity: profile,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  _profileButtons(
                                    'card',
                                    'Payment methods',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  _profileButtons(
                                    'listing',
                                    'Your listings',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HistoryScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  _profileButtons(
                                    'card',
                                    'My cards',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SelectPaymentScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  _profileButtons(
                                    'vehicle',
                                    'Your vehicles',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const VehiclesScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  _profileButtons(
                                    'vehicle',
                                    'CUSTOM CHANGE PASSWORD',
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            8.hs(),
                            BlocConsumer<AuthBloc, AuthState>(
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('An error occurred!')),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state.status == Status.error) {
                                  return const CustomErrorWidget();
                                }
                                if (state.status == Status.loading) {
                                  return const CustomLoader();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const LeaveWidget(),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.BORDER_RADIUS_30),
                                      color: Colors.white,
                                    ),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Image.asset(
                                        'assets/icons/log_icon.png',
                                        color: AppConstants.mainColor,
                                        height: 20,
                                      ),
                                      title: const Text('Log out'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }

  Widget _profileButtons(String path, String title, Function()? onTap) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          'assets/icons/${path}_icon.png',
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
}

Widget _buildLoadingState() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.red,
      strokeWidth: 3,
    ),
  );
}
