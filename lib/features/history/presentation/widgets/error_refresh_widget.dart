import 'package:flutter/material.dart';

class ErrorRefreshWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  const ErrorRefreshWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Something went wrong!',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      content: const Text('Please check your connection and try again.'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
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
            child: const Text(
              'Retry',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
