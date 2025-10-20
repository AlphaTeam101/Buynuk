import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Decorative background element
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primaryColor.withOpacity(0.1),
              ),
            ).animate().scale(delay: 200.ms, duration: 1500.ms, curve: Curves.easeOutCubic),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    const _Header(),
                    const SizedBox(height: 40),
                    const _RegisterForm(),
                    const SizedBox(height: 32),
                    const _PrimaryActions(),
                    const SizedBox(height: 32),
                    const _SocialLogins(),
                    const SizedBox(height: 40),
                    const _LoginRedirect(),
                    const SizedBox(height: 20),
                  ]
                      .animate(interval: 100.ms)
                      .fade(duration: 600.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Private Sub-Widgets for Cleaner Code ---

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Create Account', style: textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Sign up to get started with Platini.',
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).extension<AppColorsExtension>()!.textIconsTertiary,
          ),
        ),
      ],
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AppTextField(
          labelText: 'Full Name',
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: 16),
        AppTextField(
          labelText: 'Email Address',
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: 16),
        AppTextField(
          labelText: 'Password',
          prefixIcon: Icons.lock_outline,
        ),
      ],
    );
  }
}

class _PrimaryActions extends StatelessWidget {
  const _PrimaryActions();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        AppButton(
          text: 'Sign Up',
          onPressed: () {},
          buttonType: AppButtonType.primary,
          isFullWidth: true,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'OR',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: appColors.textIconsQuaternary,
                    ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}

class _SocialLogins extends StatelessWidget {
  const _SocialLogins();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          text: 'Continue with Google',
          onPressed: () {},
          buttonType: AppButtonType.secondary,
          isFullWidth: true,
          leadingIcon: SvgPicture.asset('assets/icons/google_logo.svg', width: 24),
        ),
        const SizedBox(height: 12),
        AppButton(
          text: 'Continue with Apple',
          onPressed: () {},
          buttonType: AppButtonType.secondary,
          isFullWidth: true,
          leadingIcon: SvgPicture.asset('assets/icons/apple_logo.svg', width: 24, colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn)),
        ),
      ],
    );
  }
}

class _LoginRedirect extends StatelessWidget {
  const _LoginRedirect();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Text.rich(
      TextSpan(
        text: 'Already have an account? ',
        style: textTheme.bodyMedium?.copyWith(color: appColors.textIconsTertiary),
        children: [
          TextSpan(
            text: 'Log In',
            style: textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
