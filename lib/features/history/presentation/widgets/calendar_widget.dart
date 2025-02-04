// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarWidget extends StatefulWidget {
//   const CalendarWidget({super.key});

//   @override
//   State<CalendarWidget> createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   final List<DateTime> offDays = [
//     DateTime.utc(2024, 12, 16),
//     DateTime.utc(2024, 6, 3),
//     DateTime.utc(2024, 6, 12),
//     DateTime.utc(2024, 12, 15),
//   ];

//   bool isOffDay(DateTime day) {
//     return offDays.any((offDay) =>
//         day.year == offDay.year &&
//         day.month == offDay.month &&
//         day.day == offDay.day);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       firstDay: DateTime.utc(2020, 1, 1),
//       lastDay: DateTime.utc(2030, 12, 31),
//       focusedDay: _focusedDay,
//       selectedDayPredicate: (day) {
//         return isSameDay(_selectedDay, day);
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//         if (!isOffDay(selectedDay)) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//         }
//       },
//       rowHeight: 52,
//       daysOfWeekHeight: 24,
//       calendarStyle: CalendarStyle(
//         cellMargin: EdgeInsets.zero,
//         markerMargin: EdgeInsets.zero,
//         defaultTextStyle: const TextStyle(
//           fontSize: 18,
//           color: Colors.red, // Default text color
//           fontWeight: FontWeight.w500,
//         ),
//         weekendTextStyle: TextStyle(
//           fontSize: 18,
//           color: Colors.grey.withOpacity(0.6), // Weekend text color
//           fontWeight: FontWeight.w500,
//         ),
//         weekendDecoration: const BoxDecoration(
//           color: Colors.black54, // Weekend background color
//           shape: BoxShape.circle,
//         ),
//         selectedDecoration: const BoxDecoration(
//           color: Colors.green, // Selected day background color
//           shape: BoxShape.circle,
//         ),
//         defaultDecoration: const BoxDecoration(
//           color: Colors.black54, // Default day background color
//           shape: BoxShape.circle,
//         ),
//         disabledDecoration: BoxDecoration(
//           color: Colors.black, // Disabled day background color
//           border: Border.all(color: Colors.grey), // Disabled day border color
//           shape: BoxShape.circle,
//         ),
//         todayDecoration: BoxDecoration(
//           border: Border.all(color: Colors.white), // Today's border color
//           color: Colors.black54, // Today's background color
//           shape: BoxShape.circle,
//         ),
//       ),
//       daysOfWeekStyle: const DaysOfWeekStyle(
//         weekdayStyle: TextStyle(color: Colors.white70, fontSize: 16),
//         weekendStyle: TextStyle(color: Colors.white70, fontSize: 16),
//       ),
//       headerStyle: const HeaderStyle(
//         formatButtonVisible: false,
//         titleCentered: true,
//         titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
//         leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
//         rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
//       ),
//       enabledDayPredicate: (day) => !isOffDay(day),
//     );
//   }
// }
