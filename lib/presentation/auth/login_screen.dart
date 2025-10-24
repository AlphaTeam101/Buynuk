
import 'package:e_commerce/presentation/auth/bloc/auth_bloc.dart';
import 'package:e_commerce/presentation/auth/register_screen.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/main/main_screen.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:e_commerce/presentation/widgets/app_text_field.dart';
import 'package:e_commerce/presentation/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              AppToast.show(context, state.message);
            }
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text('Welcome Back!', style: textTheme.headlineLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your credentials to continue.',
                      style: textTheme.bodyLarge?.copyWith(color: appColors.textIconsTertiary),
                    ),
                    const SizedBox(height: 40),
                    Text('Email', style: textTheme.labelLarge),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _emailController,
                      labelText: 'Enter your email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: _emailController.text.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    Text('Password', style: textTheme.labelLarge),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _passwordController,
                      labelText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: _passwordController.text.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) => setState(() {}),
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                LoginRequested(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        }
                      },
                      isLoading: state is AuthLoading,
                      isFullWidth: true,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account?', style: textTheme.bodyMedium),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterScreen()));
                          },
                          child: Text('Sign Up', style: textTheme.labelLarge?.copyWith(color: theme.primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
