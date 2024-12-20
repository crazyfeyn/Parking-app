import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BookingTypePicker extends StatefulWidget {
  final Function(String?) onStateChanged;
  final String? initialValue;

  const BookingTypePicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BookingTypePickerState createState() => _BookingTypePickerState();
}

class _BookingTypePickerState extends State<BookingTypePicker> {
  String? selectedBookingType;

  List<String> bookingTypes = [
    'New York City, New York',
    'Los Angeles, California',
    'Chicago, Illinois',
  ];

  @override
  void initState() {
    super.initState();
    selectedBookingType = widget.initialValue;
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
          itemCount: bookingTypes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                bookingTypes[index],
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedBookingType = bookingTypes[index];
                });
                widget.onStateChanged(bookingTypes[index]);
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking type',
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
                  selectedBookingType ?? 'Select booking type',
                  style: TextStyle(
                    color: selectedBookingType != null
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
    );
  }
}
