import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/home/bloc/home_bloc.dart';
import 'package:e_commerce/presentation/home/widgets/category_list.dart';
import 'package:e_commerce/presentation/home/widgets/product_card.dart';
import 'package:e_commerce/presentation/home/widgets/product_grid.dart';
import 'package:e_commerce/presentation/home/widgets/promo_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/featured_card.dart';
import 'widgets/home_app_bar.dart';

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
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      context.read<HomeBloc>().add(HomeScrolledToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
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
              const _TopFlashSaleBanner(),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: PromoCarousel(products: state.products.take(3).toList())),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "Today's Flash Sales", showViewAll: true),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ProductGrid(products: state.products.skip(3).take(4).toList()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "Categories"),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: CategoryList(categories: state.categories)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "This Month Best Selling"),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ProductGrid(products: state.products.skip(7).take(4).toList()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "Featured", isFeatured: true),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: FeaturedCard(
                title: 'ASUS FHD Gaming Laptop',
                subtitle: 'High-performance gaming laptop with the latest specs.',
                buttonText: "Shop Now",
                imageUrl: state.products.isNotEmpty && state.products[0].images.isNotEmpty ? state.products[0].images.first : 'https://placehold.co/600x200/212121/FFFFFF?text=Gaming+Laptop',
                isWide: true,
              )),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FeaturedCard(
                      title: 'Wireless Headphones',
                      subtitle: 'Immersive sound experience, all day comfort.',
                      buttonText: "Shop Now",
                      imageUrl: state.products.length > 1 && state.products[1].images.isNotEmpty ? state.products[1].images.first : 'https://placehold.co/300x400/212121/FFFFFF?text=Headphones',
                      isWide: false,
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: Column(
                      children: [
                        FeaturedCard(
                          title: 'Smart Watch',
                          subtitle: 'Stay connected and track your fitness.',
                          buttonText: "Shop Now",
                          imageUrl: state.products.length > 2 && state.products[2].images.isNotEmpty ? state.products[2].images.first : 'https://placehold.co/300x200/212121/FFFFFF?text=Smart+Watch',
                          isWide: false,
                          isHalf: true,
                        ),
                        const SizedBox(height: 16),
                        FeaturedCard(
                          title: 'Bluetooth Speaker',
                          subtitle: 'Portable and powerful sound.',
                          buttonText: "Shop Now",
                          imageUrl: state.products.length > 3 && state.products[3].images.isNotEmpty ? state.products[3].images.first : 'https://placehold.co/300x200/212121/FFFFFF?text=Speaker',
                          isWide: false,
                          isHalf: true,
                        ),
                      ],
                    )),
                  ],
                ),
              )),
              SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom + 24)),
            ],
          );
        },
      ),
      bottomNavigationBar: _BottomNavBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  SliverToBoxAdapter _buildSectionHeader(BuildContext context, String title, {bool showViewAll = false, bool isFeatured = false}) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (isFeatured)
                  Container(
                    width: 4,
                    height: 20,
                    color: AppColors.brandPrimary,
                    margin: const EdgeInsets.only(right: 8),
                  ),
                Text(
                  title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: AppColors.textIconsPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (showViewAll)
              InkWell(
                onTap: () { /* Handle View All tap */ },
                child: Row(
                  children: [
                    Text(
                      "View All",
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.textIconsSecondary,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textIconsSecondary),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TopFlashSaleBanner extends StatelessWidget {
  const _TopFlashSaleBanner();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppColors.surfaceDark,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: const Center(
          child: Text(
            'Flash Sale - Up to 60% OFF',
            style: TextStyle(color: AppColors.textIconsOnDark, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const _BottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, Icons.home_outlined, 0, 'Home'),
            _buildNavItem(Icons.search, Icons.search_outlined, 1, 'Search'),
            _buildNavItem(Icons.favorite, Icons.favorite_border, 2, 'Wishlist'),
            _buildNavItem(Icons.shopping_cart, Icons.shopping_cart_outlined, 3, 'Cart'),
            _buildNavItem(Icons.person, Icons.person_outline, 4, 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData selectedIcon, IconData unselectedIcon, int index, String label) {
    final color = selectedIndex == index ? AppColors.feedbackError : AppColors.textIconsSecondary;
    return InkWell(
      onTap: () => onItemTapped(index),
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selectedIndex == index ? selectedIcon : unselectedIcon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
