import 'package:flutter/material.dart';

class ScheduleWidget extends StatelessWidget {
  final String schedule;

  const ScheduleWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    // Split the schedule string into individual day schedules
    final daySchedules = schedule.split(';');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working Hours',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...daySchedules.map((daySchedule) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              daySchedule.trim(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          );
        }),
      ],
    );
  }
}
