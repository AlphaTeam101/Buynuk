
import 'package:e_commerce/presentation/auth/bloc/login_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
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
                      labelText: 'Enter your email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: state.email.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
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
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginEmailChanged(value));
                      },
                    ),
                    const SizedBox(height: 24),
                    Text('Password', style: textTheme.labelLarge),
                    const SizedBox(height: 8),
                    AppTextField(
                      labelText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: state.password.isEmpty ? appColors.textIconsTertiary : theme.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginPasswordChanged(value));
                      },
                    ),
                    const SizedBox(height: 40),
                    AppButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        }
                      },
                      isLoading: state.status == LoginStatus.loading,
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
