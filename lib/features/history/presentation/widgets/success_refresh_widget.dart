import 'package:flutter/material.dart';

class SuccessNotifierWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final String text;
  final String contentText;
  const SuccessNotifierWidget(
      {super.key,
      required this.onRefresh,
      required this.text,
      required this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              onRefresh();
            },
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF2357ED),
              ),
              child: Text(
                contentText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
