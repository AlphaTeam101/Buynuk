import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';
import 'package:e_commerce/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/category_list.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/promo_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<HomeBloc>().add(HomeScrolledToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final appColors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: appColors.surfaceSecondary, // Use a slightly different color for the background
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.initial || (state.status == HomeStatus.loading && state.products.isEmpty)) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == HomeStatus.failure) {
            return Center(child: Text('Failed to fetch data: ${state.errorMessage}'));
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              const HomeAppBar(),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: CategoryList(categories: state.categories)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              const SliverToBoxAdapter(child: PromoBanner()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("All Products", style: textTheme.titleLarge),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ProductGrid(products: state.products),
              if (state.status == HomeStatus.loading && state.products.isNotEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom + 24)),
            ],
          );
        },
      ),
    );
  }
}
