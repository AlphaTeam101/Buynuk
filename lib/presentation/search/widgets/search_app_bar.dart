import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAppBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;

  const SearchAppBar({super.key, required this.controller, required this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorsExtension>()!;

    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: 16.0,
      title: Hero(
        tag: 'search_bar', // Must match the tag in HomeAppBar
        child: Material(
          type: MaterialType.transparency,
          child: TextField(
            controller: controller,
            autofocus: true,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: theme.textTheme.bodyLarge?.copyWith(color: appColors.textIconsTertiary),
              prefixIcon: Icon(Icons.search, color: appColors.textIconsTertiary, size: 20),
              filled: true,
              fillColor: appColors.surfaceSecondary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (query) => context.read<SearchBloc>().add(SearchQueryChanged(query)),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onFilterTap,
          icon: Icon(Icons.filter_list_rounded, color: theme.colorScheme.onSurface, size: 28),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
