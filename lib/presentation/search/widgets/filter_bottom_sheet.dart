import 'package:e_commerce/domain/categories/entities/category.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/search/bloc/search_bloc.dart';
import 'package:e_commerce/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // TODO: Fetch real categories
  final _dummyCategories = [
    const Category(id: 1, name: 'Clothes', image: '', slug: 'clothes'),
    const Category(id: 2, name: 'Electronics', image: '', slug: 'electronics'),
    const Category(id: 3, name: 'Furniture', image: '', slug: 'furniture'),
    const Category(id: 4, name: 'Shoes', image: '', slug: 'shoes'),
    const Category(id: 5, name: 'Others', image: '', slug: 'others'),
  ];

  late int? _selectedCategoryId;
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    final searchState = context.read<SearchBloc>().state;
    _selectedCategoryId = searchState.categoryId;
    _currentRangeValues = RangeValues(
      searchState.minPrice ?? 0,
      searchState.maxPrice ?? 5000,
    );
  }

  void _onApplyFilters() {
    context.read<SearchBloc>().add(SearchFiltersApplied(
          categoryId: _selectedCategoryId,
          minPrice: _currentRangeValues.start,
          maxPrice: _currentRangeValues.end,
        ));
    Navigator.of(context).pop();
  }

  void _onClearFilters() {
    context.read<SearchBloc>().add(const SearchFiltersApplied(categoryId: null, minPrice: null, maxPrice: null));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: appColors.surfaceSecondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters', style: textTheme.headlineSmall),
                TextButton(onPressed: _onClearFilters, child: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 24),
            Text('Category', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _dummyCategories.map((category) {
                final isSelected = _selectedCategoryId == category.id;
                return ChoiceChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryId = selected ? category.id : null;
                    });
                  },
                  selectedColor: theme.primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Price Range', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 5000,
              divisions: 50,
              labels: RangeLabels(
                '\$${_currentRangeValues.start.round().toString()}',
                '\$${_currentRangeValues.end.round().toString()}',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Apply Filters',
              onPressed: _onApplyFilters,
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}
