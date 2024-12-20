import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_application/core/widgets/button_widget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class VehicleTypePicker extends StatefulWidget {
  final Function(String?) onStateChanged;
  final String? initialValue;

  const VehicleTypePicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VehicleTypePickerState createState() => _VehicleTypePickerState();
}

class _VehicleTypePickerState extends State<VehicleTypePicker> {
  String? selectedVehicleTypes;

  List<String> vehicleTypes = [
    'New York City, New York',
    'Los Angeles, California',
    'Chicago, Illinois',
  ];

  @override
  void initState() {
    super.initState();
    selectedVehicleTypes = widget.initialValue;
  }

  void _showStatesPicker() async {
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
                vehicleTypes[index],
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedVehicleTypes = vehicleTypes[index];
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
              onTap: _showStatesPicker,
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
                      selectedVehicleTypes ?? 'Select vehicle',
                      style: TextStyle(
                        color: selectedVehicleTypes != null
                            ? Colors.black
                            : Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ],
        ),
        12.hs(),
        ButtonWidget(text: '(+) Add viehicle'),
      ],
    );
  }
}
