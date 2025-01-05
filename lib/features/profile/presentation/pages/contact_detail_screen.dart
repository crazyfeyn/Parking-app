// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application/features/profile/presentation/pages/update_profile_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ContactDetailScreen extends StatelessWidget {
  final ProfileEntity profileEntity;
  const ContactDetailScreen({super.key, required this.profileEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.grayColor,
      appBar: const CustomProfileAppBarWidget(title: 'Contact details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // Wrap in Expanded to prevent overflow
                          child: InfoTextWidget(
                            title: profileEntity.last_name.isEmpty
                                ? "USER"
                                : profileEntity.last_name,
                            subTitle: "Surname",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InfoTextWidget(
                            title: profileEntity.first_name.isEmpty
                                ? "USER"
                                : profileEntity.first_name,
                            subTitle: "Name",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InfoTextWidget(
                      title: profileEntity.email,
                      subTitle: 'Email adress',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: InfoTextWidget(
                            title: 'Phone number',
                            subTitle: 'ADD QILISH KERE API YODEEE',
                          ),
                        ),
                        const SizedBox(width: 12),
                        ZoomTapAnimation(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateProfileScreen(
                                    profileEntity: profileEntity,
                                  ),
                                ));
                          },
                          child: Container(
                            width: 38,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2357ED).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
