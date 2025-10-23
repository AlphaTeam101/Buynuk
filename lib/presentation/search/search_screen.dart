import 'package:e_commerce/presentation/search/bloc/search_bloc.dart';
import 'package:e_commerce/presentation/search/widgets/filter_bottom_sheet.dart';
import 'package:e_commerce/presentation/search/widgets/search_app_bar.dart';
import 'package:e_commerce/presentation/search/widgets/search_results_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<SearchBloc>().add(SearchPaginated());
    }
  }

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<SearchBloc>(),
        child: const FilterBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SearchAppBar(controller: _textController, onFilterTap: _onFilterTap),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.status == SearchStatus.initial) {
                return const _InitialStateBody();
              }
              if (state.status == SearchStatus.loading && state.products.isEmpty) {
                return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
              }
              if (state.status == SearchStatus.failure) {
                return SliverFillRemaining(child: Center(child: Text('Error: ${state.errorMessage}')));
              }
              if (state.products.isEmpty) {
                return const _NoResultsBody();
              }

              return SearchResultsGrid(products: state.products);
            },
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.status == SearchStatus.loading && state.products.isNotEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
        ],
      ),
    );
  }
}

class _InitialStateBody extends StatelessWidget {
  const _InitialStateBody();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 100, color: Colors.grey), // Temporary fallback
            const SizedBox(height: 24),
            Text('Search for products', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Find the items you\'re looking for',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ).animate().fade(duration: 600.ms),
      ),
    );
  }
}

class _NoResultsBody extends StatelessWidget {
  const _NoResultsBody();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 100, color: Colors.grey), // Temporary fallback
            const SizedBox(height: 24),
            Text('No results found', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Try a different search term or adjust your filters.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ).animate().fade(duration: 600.ms),
      ),
    );
  }
}
