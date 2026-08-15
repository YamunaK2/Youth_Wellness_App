import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const SplashScreen({super.key, required this.onFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), widget.onFinished);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.self_improvement, size: 72, color: Color(0xFF00897B)),
            SizedBox(height: 16),
            Text('Youth Wellness', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text('Supporting your well-being every day', style: TextStyle(color: Color(0xFF718096))),
          ],
        ),
      ),
    );
  }
}
