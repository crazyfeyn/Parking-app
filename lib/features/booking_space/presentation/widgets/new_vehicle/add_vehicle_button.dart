import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddVehicleButton extends StatelessWidget {
  final BookingProvider provider;

  const AddVehicleButton({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () async {
        if (provider.isFormValidVehicle) {
          final vehicleModel = VehicleModel(
            type: provider.vehicleType!,
            unitNumber: provider.unitNumber!,
            year: provider.year!,
            make: provider.make!,
            model: provider.model!,
            plateNumber: provider.plateNumber!,
            user: 34, // Replace with actual user ID
          );

          // Dispatch the create vehicle event
          context.read<HomeBloc>().add(HomeEvent.createVehicle(vehicleModel));

          // Listen to state changes
          context
              .read<HomeBloc>()
              .stream
              .firstWhere((state) => state.status == Status.success)
              .then((_) {
            // Dispatch the event to get the updated list of vehicles
            context.read<HomeBloc>().add(const HomeEvent.getVehicleList());

            // Navigate back to the previous screen
            Navigator.pop(context);
          });
        } else {
          // Show error message if the form is invalid
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill all fields')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppConstants.mainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: const Text(
          'Add vehicle',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
