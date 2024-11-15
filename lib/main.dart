import 'package:flutter/material.dart';
import 'package:flutter_application/features/history/presentation/pages/detail_screen.dart';
import 'package:flutter_application/features/history/presentation/pages/history_screen.dart';
import 'package:flutter_application/features/home/presentation/pages/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailScreen(),
    );
  }
}
