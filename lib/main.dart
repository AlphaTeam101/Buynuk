import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/domain/auth/repositories/auth_repository.dart';
import 'package:e_commerce/presentation/auth/login_page.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();

  final authRepository = getIt<AuthRepository>();
  final userOrError = await authRepository.getProfile();

  final Widget initialScreen = userOrError.fold(
    (error) => const LoginPage(),
    (user) => const HomeScreen(),
  );

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platini Store',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switch based on device settings
      home: initialScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}
