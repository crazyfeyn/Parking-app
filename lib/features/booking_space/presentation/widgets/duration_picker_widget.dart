import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/features/booking_space/presentation/provider/booking_provider.dart';

class DurationPickerWidget extends StatefulWidget {
  final BookingProvider provider;
  final Function(String) onDurationChanged;
  final String? bookingType;

  const DurationPickerWidget({
    super.key,
    required this.onDurationChanged,
    required this.provider,
    this.bookingType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DurationPickerWidgetState createState() => _DurationPickerWidgetState();
}

class _DurationPickerWidgetState extends State<DurationPickerWidget> {
  final TextEditingController _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Duration',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _durationController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: widget.bookingType ?? widget.provider.selectedBookingType,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            widget.onDurationChanged(value);
          },
        ),
      ],
    );
  }
}
