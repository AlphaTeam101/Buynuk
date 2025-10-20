import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:e_commerce/presentation/widgets/app_toast.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switch based on device settings
      home: const DesignSystemDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DesignSystemDemoPage extends StatelessWidget {
  const DesignSystemDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Showcase'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Reusable Text Field',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const AppTextField(
                labelText: 'Email Address',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 24),
              const Text(
                'Reusable Buttons',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Primary Button',
                onPressed: () {
                  AppToast.show(
                    context: context,
                    title: 'Success!',
                    message: 'The primary action was completed.',
                    type: ToastType.success,
                  );
                },
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Secondary Button',
                buttonType: AppButtonType.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Tertiary Button',
                buttonType: AppButtonType.tertiary,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Destructive Button',
                buttonType: AppButtonType.destructive,
                onPressed: () {
                  AppToast.show(
                    context: context,
                    title: 'Error!',
                    message: 'Something went wrong. Please try again.',
                    type: ToastType.error,
                  );
                },
              ),
              const SizedBox(height: 12),
              const AppButton(
                text: 'Disabled Button',
                onPressed: null, // Setting onPressed to null disables the button
              ),
              const SizedBox(height: 12),
              const AppButton(
                text: 'Loading Button',
                isLoading: true,
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
