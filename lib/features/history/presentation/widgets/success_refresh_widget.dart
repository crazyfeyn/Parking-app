import 'package:flutter/material.dart';

class SuccessNotifierWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final String text;
  final String contentText;
  const SuccessNotifierWidget({
    super.key,
    required this.onRefresh,
    required this.text,
    required this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss the dialog
            onRefresh(); // Call the refresh callback
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 37,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF2357ED),
            ),
            child: Text(
              contentText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
