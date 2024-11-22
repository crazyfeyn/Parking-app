import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/payment_screen/presentation/pages/select_payment_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                color: Color(0xFF7B3F00),
              ),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: AppDimens.PADDING_50,
                          left: AppDimens.PADDING_20,
                          right: AppDimens.PADDING_20),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bg_auth.png'),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.amber),
                            ),
                            title: const Text(
                              "Welcome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              'Kenyishka Steyk',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(
                                  AppDimens.BORDER_RADIUS_15,
                                ),
                              ),
                              child: Image.asset(
                                'assets/icons/leave_icon.png',
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.all(AppDimens.PADDING_20),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.759,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppDimens.BORDER_RADIUS_30),
                          topRight:
                              Radius.circular(AppDimens.BORDER_RADIUS_30)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        _profileButtons(
                          'profile',
                          'profile',
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoryScreen()),
                          ),
                        ),
                        _profileButtons(
                            'history',
                            'history',
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HistoryScreen()))),
                        _profileButtons(
                            'card',
                            'my cards',
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectPaymentScreen()))),
                        _profileButtons(
                            'settings',
                            'settings',
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HistoryScreen()))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          height: 36,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios_sharp),
      ),
    );
  }
}
