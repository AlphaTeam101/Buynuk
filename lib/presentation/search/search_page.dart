import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/presentation/search/bloc/search_bloc.dart';
import 'package:e_commerce/presentation/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchBloc>(),
      child: const SearchScreen(),
    );
  }
}
