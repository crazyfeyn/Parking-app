import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DurationPickerWidget extends StatefulWidget {
  final Function(String) onDurationChanged;

  const DurationPickerWidget({
    super.key,
    required this.onDurationChanged,
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
          'Duration (days)',
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
