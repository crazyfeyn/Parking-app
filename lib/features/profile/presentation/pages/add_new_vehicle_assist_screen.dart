import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/white_back_widget.dart';
import 'package:flutter_application/features/booking_space/data/models/vehicle_model.dart';
import 'package:flutter_application/features/booking_space/presentation/widgets/new_vehicle/general_form_field_widget.dart';
import 'package:flutter_application/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application/features/profile/presentation/provider/vehicle_provider.dart';
import 'package:flutter_application/features/profile/presentation/widgets/add_vehicle_button_assist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AddNewVehicleScreenAssistScreenAssist extends StatelessWidget {
  final VehicleProvider provider;
  final VehicleModel? vehicle;
  final bool isEditing;

  const AddNewVehicleScreenAssistScreenAssist({
    super.key,
    required this.provider,
    this.vehicle,
    this.isEditing = false,
  });

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
    // Use a post-frame callback to defer state updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEditing && vehicle != null) {
        provider.setMake(vehicle!.make);
        provider.setModel(vehicle!.model);
        provider.setPlateNumber(vehicle!.plateNumber);
        provider.setUnitNumber(vehicle!.unitNumber);
        provider.setVehicleType(vehicle!.type);
        provider.setYear(vehicle!.year);
        provider.setVehicleId(vehicle!.id);
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
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
                title: Text(
                  isEditing ? 'Edit Vehicle' : 'Add New Vehicle',
                ),
              ),
              14.hs(),
              WhiteBackWidget(
                widget: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setVehicleType,
                      labelText: 'Vehicle type',
                      initialExample: 'Vehicle type',
                      aboveText: 'Car, Truck...',
                      keyboardType: TextInputType.text,
                      initialValue: isEditing ? vehicle!.type : null,
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setUnitNumber,
                      labelText: '',
                      initialExample: 'Unit number',
                      aboveText: '123',
                      keyboardType: TextInputType.number,
                      initialValue: isEditing ? vehicle!.unitNumber : null,
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: (value) =>
                          provider.setYear(int.tryParse(value) ?? 0),
                      labelText: '',
                      initialExample: 'Year',
                      aboveText: '1987',
                      keyboardType: TextInputType.number,
                      initialValue: isEditing ? vehicle!.year.toString() : null,
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setMake,
                      labelText: 'Make',
                      aboveText: 'Make',
                      initialExample: '',
                      keyboardType: TextInputType.text,
                      initialValue: isEditing ? vehicle!.make : null,
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setModel,
                      labelText: 'Model',
                      aboveText: 'enter model',
                      initialExample: '',
                      keyboardType: TextInputType.text,
                      initialValue: isEditing ? vehicle!.model : null,
                    ),
                    const SizedBox(height: 16),
                    GeneralFormFieldWidget(
                      onValueChanged: provider.setPlateNumber,
                      labelText: '',
                      aboveText: 'enter plate number',
                      initialExample: '',
                      keyboardType: TextInputType.text,
                      initialValue: isEditing ? vehicle!.plateNumber : null,
                    ),
                    24.hs(),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        if (state.status == Status.success &&
                            state.profile != null) {
                          return AddVehicleButtonAssist(
                            provider: provider,
                            userId: state.profile!.id,
                            onSuccess: _clearForm,
                            isEditing: isEditing,
                          );
                        } else if (state.status == Status.loading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 3,
                          ));
                        } else {
                          return const Center(
                            child: Text('Failed to load user data'),
                          );
                        }
                      },
                    ),
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
