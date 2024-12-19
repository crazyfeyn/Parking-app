import 'package:flutter/material.dart';

class StatePicker extends StatefulWidget {
  final Function(String?) onStateChanged;
  final String? initialValue;

  const StatePicker({
    super.key,
    required this.onStateChanged,
    this.initialValue,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StatePickerState createState() => _StatePickerState();
}

class _StatePickerState extends State<StatePicker> {
  String? selectedState;

  final List<String> states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
  ];

  @override
  void initState() {
    super.initState();
    selectedState = widget.initialValue;
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
          itemCount: states.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                states[index],
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                setState(() {
                  selectedState = states[index];
                });
                widget.onStateChanged(states[index]);
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
          'State',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
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
                  selectedState ?? 'Pick state',
                  style: TextStyle(
                    color:
                        selectedState != null ? Colors.black : Colors.black54,
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
