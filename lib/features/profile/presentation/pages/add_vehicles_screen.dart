import 'package:flutter/material.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:flutter_application/core/widgets/text_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/custom_profile_app_bar_widget.dart';
import 'package:flutter_application/features/profile/presentation/widgets/title_widget.dart';

class AddVehiclesScreen extends StatelessWidget {
  AddVehiclesScreen({super.key});
  final typeController = TextEditingController();
  final numberController = TextEditingController();
  final yearController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomProfileAppBarWidget(title: 'Add new vehicle'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleWidget(title: 'Vehicle type'),
                      TextWidget(
                        controller: typeController,
                        labelText: 'Pick vehicle type',
                      ),
                      const SizedBox(height: 12),
                      const TitleWidget(title: 'Unit number'),
                      TextWidget(
                        labelText: 'Select booking type',
                        controller: numberController,
                      ),
                      const SizedBox(height: 12),
                      const TitleWidget(title: 'Year'),
                      TextWidget(
                        labelText: '1',
                        controller: yearController,
                      ),
                      const SizedBox(height: 12),
                      const TitleWidget(title: 'Make'),
                      TextWidget(
                        labelText: 'Select vehicle',
                        controller: makeController,
                      ),
                      const SizedBox(height: 12),
                      const TitleWidget(title: 'Model'),
                      TextWidget(
                        labelText: 'Select vehicle',
                        controller: modelController,
                      ),
                      const SizedBox(height: 12),
                      const TitleWidget(title: 'Plate number'),
                      TextWidget(
                        labelText: 'Select vehicle',
                        controller: plateController,
                      ),
                      const SizedBox(height: 12),
                      ButtonWidget(
                        text: 'Add vehicle',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Icon
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 48,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Title
                                      const Text(
                                        "Successfully done",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Subtitle
                                      const Text(
                                        "Your truck is successfully added",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      // Button
                                      ButtonWidget(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'Done',
                                        bgColor: Colors.grey.shade300,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
