import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_dimens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(27, 24, 41, 10),
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
                        topRight: Radius.circular(AppDimens.BORDER_RADIUS_30)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      _profileButtons('profile', 'Profile'),
                      _profileButtons('terms', 'Terms and COnditations'),
                      _profileButtons('faq', 'Faq'),
                      _profileButtons('settings', 'Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileButtons(String path, String title) {
    return ListTile(
      leading: Image.asset('assets/icons/${path}_icon.png'),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios_sharp),
    );
  }
}
