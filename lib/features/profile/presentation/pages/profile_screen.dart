import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/widgets/custom_error_widget.dart';
import 'package:flutter_application/core/widgets/custom_loader.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';
import 'package:flutter_application/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/payment_screen/presentation/pages/select_payment_screen.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/profile/presentation/pages/contact_detail_screen.dart';
import 'package:flutter_application/features/profile/presentation/pages/payments_screen.dart';
import 'package:flutter_application/features/profile/presentation/pages/vehicles_screen.dart';
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
    context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfilePinned(),
                Container(
                  padding: const EdgeInsets.all(AppDimens.PADDING_10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.759,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimens.BORDER_RADIUS_30),
                        topRight: Radius.circular(AppDimens.BORDER_RADIUS_30)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _profileButtons(
                        'phone',
                        'Contact details',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ContactDetailScreen(),
                              ));
                        },
                      ),
                      _profileButtons(
                        'card',
                        'Payment methods',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentsScreen(),
                              ));
                        },
                      ),
                      _profileButtons(
                          'listing',
                          'Your listings',
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoryScreen()))),
                      _profileButtons(
                          'card',
                          'My cards',
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectPaymentScreen()))),
                      _profileButtons(
                        'vehicle',
                        'Your vehicles',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VehiclesScreen(),
                              ));
                        },
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state.status == Status.error) {
                            return const CustomErrorWidget(); // Displays error
                          }
                          if (state.status == Status.loading) {
                            return const CustomLoader(); // Shows a loader during logout or other actions
                          }
                          return _profileButtons(
                            'vehicle',
                            'CUSTOM LOGOUT',
                            () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthEvent.logOut());
                            },
                          );
                        },
                        listener: (context, state) {
                          if (state.status == Status.success) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (route) => false,
                            );
                          } else if (state.status == Status.error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('An error occurred!')),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
          height: 36,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}
