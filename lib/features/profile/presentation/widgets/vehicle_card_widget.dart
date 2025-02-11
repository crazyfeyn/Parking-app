import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/profile/presentation/widgets/info_text_widget.dart';

class VehicleCardWidget extends StatelessWidget {
  final VehicleModel vehicle;
  final VoidCallback onEditPressed;

  const VehicleCardWidget({
    super.key,
    required this.vehicle,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Vehicle type',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.shadeColor)),
              Text(vehicle.type,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTextWidget(title: vehicle.make, subTitle: 'Make'),
              InfoTextWidget(title: vehicle.model, subTitle: 'Model'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoTextWidget(title: vehicle.year.toString(), subTitle: 'Year'),
              InfoTextWidget(
                  title: vehicle.plateNumber, subTitle: 'Plate Number'),
            ],
          ),
          const SizedBox(height: 12),
          InfoTextWidget(title: vehicle.unitNumber, subTitle: 'Unit Number'),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEditPressed,
            ),
          ),
        ],
      ),
    );
  }
}
