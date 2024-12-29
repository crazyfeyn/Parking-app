import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class StartDatePickerWidget extends StatefulWidget {
  const StartDatePickerWidget({super.key, required Function onDateSelected});

  @override
  State<StartDatePickerWidget> createState() => _StartDatePickerWidgetState();
}

class _StartDatePickerWidgetState extends State<StartDatePickerWidget>
    with SingleTickerProviderStateMixin {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start date',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        ZoomTapAnimation(
          onTap: () async {
            await _pickDate();
          },
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
                  selectedDate != null
                      ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                      : 'Pick a start day',
                  style: TextStyle(
                    color: selectedDate != null ? Colors.black : Colors.black54,
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
