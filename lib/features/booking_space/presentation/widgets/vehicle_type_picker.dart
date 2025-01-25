import 'package:flutter/material.dart';
import 'package:flutter_application/core/constants/app_constants.dart';
import 'package:flutter_application/features/booking_space/presentation/pages/add_new_vehicle_screen.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';
import 'package:flutter_application/features/home/data/models/location_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class VehicleTypePicker extends StatefulWidget {
  final Function onStateChanged;
  final String? initialValue;
  final BookingProvider provider;

  const VehicleTypePicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
    required LocationModel locationModel,
    required this.provider,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VehicleTypePickerState createState() => _VehicleTypePickerState();
}

class _VehicleTypePickerState extends State<VehicleTypePicker> {
  String? selectedVehicleType;

  @override
  void initState() {
    super.initState();
    selectedVehicleType = widget.initialValue;
    context.read<HomeBloc>().add(const HomeEvent.getVehicleList());
  }

  void _showVehiclePicker(List<Map<String, dynamic>> vehicleTypes) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: vehicleTypes.length,
          itemBuilder: (context, index) {
            final vehicle = vehicleTypes[index];
            return ListTile(
              title: Text(
                vehicle['model'] ?? 'Unknown model',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                setState(() {
                  selectedVehicleType = vehicle['model'];
                });
                widget.onStateChanged(vehicle['model'], vehicle['id']);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vehicle',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                // Check if the vehicle list is loaded
                final isVehicleListLoaded = state.status == Status.success;

                return IgnorePointer(
                  // Disable the button if the vehicle list is not loaded
                  ignoring: !isVehicleListLoaded,
                  child: BlocSelector<HomeBloc, HomeState,
                      List<Map<String, dynamic>>>(
                    selector: (state) {
                      return state.vehicleList
                              ?.map((vehicle) => {
                                    'id': vehicle.id,
                                    'model': vehicle.model,
                                  })
                              .toList() ??
                          [];
                    },
                    builder: (context, vehicleTypes) {
                      return ZoomTapAnimation(
                        onTap: () => _showVehiclePicker(vehicleTypes),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedVehicleType ?? 'Select vehicle',
                                style: TextStyle(
                                  color: selectedVehicleType != null
                                      ? Colors.black
                                      : Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isVehicleListLoaded)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppConstants.mainColor,
                                  ),
                                )
                              else
                                const Icon(Icons.arrow_drop_down,
                                    color: Colors.black54),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        12.hs(),
        ButtonWidget(
          text: '(+) Add vehicle',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewVehicleScreen(
                provider: widget.provider,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
