import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/presentation/auth/bloc/login_bloc.dart';
import 'package:e_commerce/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const LoginScreen(),
    );
  }
}
