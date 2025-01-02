import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/widgets/white_back_widget.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/new_vehicle/general_form_field_widget.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/new_vehicle/general_modal_field_widget.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddNewVehicleScreen extends StatelessWidget {
  final BookingProvider provider;

  const AddNewVehicleScreen({super.key, required this.provider});

  void _clearForm() {
    provider.setVehicleType(null);
    provider.setUnitNumber('');
    provider.setYear(0);
    provider.setMake('');
    provider.setModel('');
    provider.setPlateNumber('');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                leading: ZoomTapAnimation(
                  onTap: () {
                    _clearForm();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F1F3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                title: const Text(
                  'Add new vehicle',
                  style: TextStyle(
                    color: Color(0xFF323232),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              WhiteBackWidget(
                widget: Column(
                  children: [
                    GeneralModalFieldWidget(
                      onStateChanged: provider.setVehicleType,
                      dataList: const ['Car', 'Motorcycle', 'Truck'],
                      labelText: 'Vehicle type',
                      initialValue: '',
                      aboveText: 'Pick vehicle type',
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setUnitNumber,
                      labelText: '',
                      initialExample: 'Unit number',
                      aboveText: '123',
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: (value) =>
                          provider.setYear(int.tryParse(value) ?? 0),
                      labelText: '',
                      initialExample: 'Year',
                      aboveText: '1987',
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setMake,
                      labelText: 'Make',
                      aboveText: 'Make',
                      initialExample: '',
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setModel,
                      labelText: 'Model',
                      aboveText: 'enter model',
                      initialExample: '',
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setPlateNumber,
                      labelText: '',
                      aboveText: 'enter plate number',
                      initialExample: '',
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.status == Status.success &&
                            state.profile != null) {
                          return AddVehicleButton(
                            provider: provider,
                            userId: state.profile!.id,
                            onSuccess: _clearForm,
                          );
                        } else if (state.status == Status.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return const Center(
                            child: Text('Failed to load user data'),
                          );
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddVehicleButton extends StatelessWidget {
  final int userId;
  final BookingProvider provider;
  final VoidCallback onSuccess;

  const AddVehicleButton({
    required this.provider,
    required this.userId,
    required this.onSuccess,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: () {
        if (provider.isFormValidVehicle) {
          final vehicleModel = VehicleModel(
            type: provider.vehicleType!,
            unitNumber: provider.unitNumber!,
            year: provider.year!,
            make: provider.make!,
            model: provider.model!,
            plateNumber: provider.plateNumber!,
            user: userId,
          );

          context.read<HomeBloc>().add(HomeEvent.createVehicle(vehicleModel));
          onSuccess();
          Navigator.of(context).pop();
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
