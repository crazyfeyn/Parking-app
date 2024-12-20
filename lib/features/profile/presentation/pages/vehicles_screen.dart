// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/features/profile/presentation/pages/add_vehicles_screen.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const CustomProfileAppBarWidget(title: 'Your vehicles information'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Truck',
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
                      InfoTextWidget(title: '2023', subTitle: 'Truck year'),
                      InfoTextWidget(title: 'White', subTitle: 'Truck color'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoTextWidget(title: 'Lim01', subTitle: 'Truck number'),
                      InfoTextWidget(title: 'White', subTitle: 'Truck color'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
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
            const Spacer(),
            ButtonWidget(
              text: 'Add new vehicle',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  AddVehiclesScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
