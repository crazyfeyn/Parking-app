import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LottieFillDemo(),
    );
  }
}

class LottieFillDemo extends StatefulWidget {
  @override
  _LottieFillDemoState createState() => _LottieFillDemoState();
}

class _LottieFillDemoState extends State<LottieFillDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fillPercentage = 0.6; // 60% filled

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottie Fill Example"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation with controlled percentage
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset(
                'assets/lottie/test.json', // Path to your Lottie file
                controller: _controller,
                onLoaded: (composition) {
                  // Set animation progress to the desired percentage
                  _controller.duration = composition.duration;
                  _controller.value = fillPercentage; // 60% filled
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '${(fillPercentage * 100).toInt()}% filled',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
