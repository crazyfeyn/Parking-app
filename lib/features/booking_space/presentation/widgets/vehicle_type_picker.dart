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

  void _showVehiclePicker(List<String> vehicleTypes) async {
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
            return ListTile(
              title: Text(
                vehicleTypes.isNotEmpty
                    ? vehicleTypes[index]
                    : 'There is not vehicle list in your list',
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedVehicleType = vehicleTypes[index];
                });
                widget.onStateChanged(vehicleTypes[index]);
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == Status.error) {
          return Center(
            child: Text(
              'Error: ${state.errorMessage}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final vehicleTypes =
            state.vehicleList?.map((vehicle) => vehicle.model).toList() ?? [];

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
                ZoomTapAnimation(
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
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down,
                            color: Colors.black54),
                      ],
                    ),
                  ),
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
      },
    );
  }
}
