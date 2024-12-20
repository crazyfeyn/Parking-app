import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.grayColor,
      appBar: const CustomProfileAppBarWidget(title: 'Contact details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Driver',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoTextWidget(
                        title: 'Shermatova',
                        subTitle: 'Surname',
                      ),
                      InfoTextWidget(
                        title: 'Lobar',
                        subTitle: 'Name',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const InfoTextWidget(
                    title: 'artikboyevnalim@gmail.com',
                    subTitle: 'Email adress',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const InfoTextWidget(
                        title: '+ 1 (55)998 77 89',
                        subTitle: 'Phone number',
                      ),
                      const Spacer(),
                      Container(
                        width: 38,
                        height: 38,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2357ED).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.edit),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
