import 'package:e_commerce/presentation/auth/login_screen.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platini Store',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switch based on device settings
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
