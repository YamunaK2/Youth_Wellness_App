import 'package:flutter/material.dart';
import 'widgets/phone_frame.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';


class YouthWellnessApp extends StatelessWidget {
  const YouthWellnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youth Wellness',
      theme: AppTheme.lightTheme,
      home: const PhoneFrame(
        child: LoginScreen(),
      ),
    );
  }
}