import 'package:flutter/material.dart';
import 'package:flutter_application/core/extension/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application/features/auth/presentation/blocs/bloc/auth_bloc.dart';

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
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFEA0707),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            12.ws(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  onRefresh(); // Trigger the refresh callback
                  Navigator.pop(context); // Close the dialog
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
            ),
          ],
        ),
      ],
    );
  }
}
