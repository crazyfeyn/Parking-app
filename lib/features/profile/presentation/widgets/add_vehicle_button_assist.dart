import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/provider/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddVehicleButtonAssist extends StatelessWidget {
  final VehicleProvider provider;
  final int userId;
  final VoidCallback onSuccess;
  final bool isEditing;

  const AddVehicleButtonAssist({
    super.key,
    required this.provider,
    required this.userId,
    required this.onSuccess,
    this.isEditing = false,
  });

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
            user: userId,
            id: isEditing ? provider.vehicleId! : 0,
          );

          isEditing
              ? context
                  .read<HomeBloc>()
                  .add(HomeEvent.updateVehicle(vehicleModel))
              : context
                  .read<HomeBloc>()
                  .add(HomeEvent.createVehicle(vehicleModel));

          context
              .read<HomeBloc>()
              .stream
              .firstWhere((state) => state.status == Status.success)
              .then((_) {
            context.read<HomeBloc>().add(const HomeEvent.getVehicleList());

            onSuccess();

            Navigator.pop(context);
          });
        } else {
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
        child: Text(
          isEditing ? 'Save vehicle' : 'Add vehicle',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
