import 'package:e_commerce/presentation/auth/register_screen.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
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
                    _LoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 32),
                    _PrimaryActions(isFormValid: _isFormValid),
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

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(() => setState(() {}));
    widget.passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final isEmailEmpty = widget.emailController.text.isEmpty;
    final isPasswordEmpty = widget.passwordController.text.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTextField(
          controller: widget.emailController,
          labelText: 'Email Address',
          prefixIcon: Icons.email_outlined,
          prefixIconColor: isEmailEmpty ? appColors.textIconsTertiary : theme.primaryColor,
        ),
        const SizedBox(height: 16),
        AppTextField(
          controller: widget.passwordController,
          labelText: 'Password',
          prefixIcon: Icons.lock_outline,
          prefixIconColor: isPasswordEmpty ? appColors.textIconsTertiary : theme.primaryColor,
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
  const _PrimaryActions({required this.isFormValid});
  final bool isFormValid;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      children: [
        AppButton(
          text: 'Log In',
          onPressed: isFormValid ? () {} : null,
          isFullWidth: true,
          buttonType: AppButtonType.primary,
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
