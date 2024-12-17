import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/payment_screen/presentation/pages/select_payment_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/profile_pinned.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                        () {},
                      ),
                      _profileButtons(
                        'card',
                        'Payment methods',
                        () {},
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
                        () {},
                      ),
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
