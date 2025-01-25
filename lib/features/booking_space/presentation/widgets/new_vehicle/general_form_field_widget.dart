import 'package:flutter/material.dart';

class GeneralFormFieldWidget extends StatefulWidget {
  final Function(String) onValueChanged;
  final String? initialValue;
  final String labelText;
  final String initialExample;
  final String aboveText;
  final TextInputType keyboardType;

  const GeneralFormFieldWidget({
    super.key,
    required this.onValueChanged,
    this.initialValue,
    required this.labelText,
    required this.initialExample,
    required this.aboveText,
    this.keyboardType = TextInputType.text,
  });

  @override
  // ignore: library_private_types_in_public_api
  _GeneralFormFieldWidgetState createState() => _GeneralFormFieldWidgetState();
}

class _GeneralFormFieldWidgetState extends State<GeneralFormFieldWidget> {
  final TextEditingController _textController = TextEditingController();

  void clearField() {
    _textController.clear();
    widget.onValueChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.initialExample,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _textController,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.aboveText,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onChanged: (value) {
            widget.onValueChanged(value);
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
