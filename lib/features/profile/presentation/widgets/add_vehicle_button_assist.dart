import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/provider/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddVehicleButtonAssist extends StatefulWidget {
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
  State<AddVehicleButtonAssist> createState() => _AddVehicleButtonAssistState();
}

class _AddVehicleButtonAssistState extends State<AddVehicleButtonAssist> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: _isLoading
          ? null
          : () async {
              if (widget.provider.isFormValidVehicle) {
                setState(() {
                  _isLoading = true;
                });

                try {
                  final vehicleModel = VehicleModel(
                    type: widget.provider.vehicleType!,
                    unitNumber: widget.provider.unitNumber!,
                    year: widget.provider.year!,
                    make: widget.provider.make!,
                    model: widget.provider.model!,
                    plateNumber: widget.provider.plateNumber!,
                    user: widget.userId,
                    id: widget.isEditing ? widget.provider.vehicleId! : 0,
                  );

                  if (widget.isEditing) {
                    context
                        .read<HomeBloc>()
                        .add(HomeEvent.updateVehicle(vehicleModel));
                  } else {
                    context
                        .read<HomeBloc>()
                        .add(HomeEvent.createVehicle(vehicleModel));
                  }

                  await context
                      .read<HomeBloc>()
                      .stream
                      .firstWhere((state) => state.status == Status.success);

                  context
                      .read<HomeBloc>()
                      .add(const HomeEvent.getVehicleList());
                  widget.onSuccess();
                  Navigator.pop(context);
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please fill all fields correctly')),
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
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                widget.isEditing ? 'Save vehicle' : 'Add vehicle',
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
