import 'package:e_commerce/presentation/auth/bloc/login_bloc.dart';
import 'package:e_commerce/presentation/auth/register_screen.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/main/main_screen.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:e_commerce/presentation/widgets/app_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            AppToast.show(
              context: context,
              title: 'Login Failed',
              message: state.errorMessage,
              type: ToastType.error,
            );
          }
          if (state.status == LoginStatus.success) {
            AppToast.show(
              context: context,
              title: 'Login Successful',
              message: 'Welcome back!',
              type: ToastType.success,
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()), // Navigate to MainScreen
              (Route<dynamic> route) => false,
            );
          }
        },
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColor.withOpacity(0.1),
                ),
              ).animate().scale(delay: 200.ms, duration: 1500.ms, curve: Curves.easeOutCubic),
            ),
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
                      const _LoginForm(),
                      const SizedBox(height: 32),
                      const _PrimaryActions(),
                      const SizedBox(height: 32),
                      const _SocialLogins(),
                      const SizedBox(height: 40),
                      const _SignupRedirect(),
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
      ),
    );
  }
}

// --- Private Sub-Widgets ---

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome Back', style: textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Log in to your Platini account to continue.',
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).extension<AppColorsExtension>()!.textIconsTertiary,
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final state = context.watch<LoginBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTextField(
          onChanged: (email) => context.read<LoginBloc>().add(LoginEmailChanged(email)),
          labelText: 'Email Address',
          prefixIcon: Icons.email_outlined,
          prefixIconColor: state.email.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
        ),
        const SizedBox(height: 16),
        AppTextField(
          onChanged: (password) => context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          labelText: 'Password',
          prefixIcon: Icons.lock_outline,
          prefixIconColor: state.password.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
        ),
        const SizedBox(height: 12),
        Text(
          'Forgot Password?',
          style: theme.textTheme.labelLarge?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            AppButton(
              text: 'Log In',
              onPressed: state.isFormValid ? () => context.read<LoginBloc>().add(LoginSubmitted()) : null,
              isFullWidth: true,
              buttonType: AppButtonType.primary,
              isLoading: state.status == LoginStatus.loading,
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
      },
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

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Text.rich(
      TextSpan(
        text: 'Don\'t have an account? ',
        style: textTheme.bodyMedium?.copyWith(color: appColors.textIconsTertiary),
        children: [
          TextSpan(
            text: 'Sign Up',
            style: textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
