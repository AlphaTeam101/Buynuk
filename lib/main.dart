import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/data/cart/datasources/cart_local_data_source.dart';
import 'package:e_commerce/data/cart/models/cart_item_model.dart';
import 'package:e_commerce/data/categories/models/category_model.dart';
import 'package:e_commerce/data/products/models/product_model.dart';
import 'package:e_commerce/domain/auth/repositories/auth_repository.dart';
import 'package:e_commerce/logic/theme/theme_bloc.dart';
import 'package:e_commerce/logic/theme/theme_event.dart';
import 'package:e_commerce/logic/theme/theme_state.dart';
import 'package:e_commerce/presentation/auth/login_screen.dart';
import 'package:e_commerce/presentation/cart/bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/main/main_screen.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the generated adapters
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());

  setupGetIt();

  // Initialize CartLocalDataSource (which opens the Hive box)
  await getIt<CartLocalDataSource>().init();

  final authRepository = getIt<AuthRepository>();
  final userOrError = await authRepository.getProfile();

  // Get the singleton CartBloc instance and add the initial event
  final CartBloc cartBlocInstance = getIt<CartBloc>()..add(CartStarted());

  // If the user is authenticated, go to the MainScreen, otherwise go to LoginPage.
  final Widget initialScreen = userOrError.fold(
    (error) => const LoginScreen(),
    (user) => const MainScreen(),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>.value(value: cartBlocInstance),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(const FlutterSecureStorage())..add(ThemeLoaded()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Platini Store',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: initialScreen,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}
