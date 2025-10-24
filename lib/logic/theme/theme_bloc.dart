import 'package:e_commerce/logic/theme/theme_event.dart';
import 'package:e_commerce/logic/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final FlutterSecureStorage _secureStorage;

  ThemeBloc(this._secureStorage) : super(const ThemeState(ThemeMode.system)) {
    on<ThemeLoaded>(_onThemeLoaded);
    on<ThemeChanged>(_onThemeChanged);
  }

  Future<void> _onThemeLoaded(ThemeLoaded event, Emitter<ThemeState> emit) async {
    final isDarkMode = await _secureStorage.read(key: 'isDarkMode') == 'true';
    emit(ThemeState(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    await _secureStorage.write(key: 'isDarkMode', value: event.isDarkMode.toString());
    emit(state.copyWith(
      themeMode: event.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ));
  }
}
