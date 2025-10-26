import 'package:e_commerce/core/di/get_it.dart';
import 'package:e_commerce/domain/products/entities/product.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/home/bloc/home_bloc.dart';
import 'package:e_commerce/presentation/home/widgets/category_list.dart';
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
          if (state.products.isEmpty) {
            return const Center(
              child: Text(
                'No electronics products found.',
                style: TextStyle(fontSize: 18, color: AppColors.textIconsSecondary),
                textAlign: TextAlign.center,
              ),
            );
          }

          final products = state.products;

          return CustomScrollView(
            slivers: [
              const HomeAppBar(),
              const _TopFlashSaleBanner(),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              SliverToBoxAdapter(child: PromoCarousel(products: products.take(3).toList())),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "Today's Flash Sales", showViewAll: true),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ProductGrid(products: products.take(4).toList()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "Categories"),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: CategoryList(categories: state.categories)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              _buildSectionHeader(context, "This Month Best Selling"),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ProductGrid(products: products.skip(4).take(4).toList()),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              if (products.length > 3) ...[
                const SliverToBoxAdapter(child: _MusicExperienceCard()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                _buildSectionHeader(context, "Featured", isFeatured: true),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: FeaturedCard(
                  title: 'ASUS FHD Gaming Laptop',
                  subtitle: 'High-performance gaming experience',
                  buttonText: "Shop Now",
                  imageUrl: products[0].images.isNotEmpty ? products[0].images.first : '',
                  isWide: true,
                )),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                SliverToBoxAdapter(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (products.length > 1)
                        Expanded(child: FeaturedCard(
                          title: 'Wireless Headphones',
                          subtitle: 'Immersive sound, all-day comfort.',
                          buttonText: "Shop Now",
                          imageUrl: products[1].images.isNotEmpty ? products[1].images.first : '',
                          isWide: false,
                        )),
                      const SizedBox(width: 16),
                      if (products.length > 3)
                        Expanded(child: Column(
                          children: [
                            FeaturedCard(
                              title: 'Smart Watch',
                              subtitle: 'Stay connected and track your fitness.',
                              buttonText: "Shop Now",
                              imageUrl: products[2].images.isNotEmpty ? products[2].images.first : '',
                              isWide: false,
                              isHalf: true,
                            ),
                            const SizedBox(height: 16),
                            FeaturedCard(
                              title: 'Bluetooth Speaker',
                              subtitle: 'Portable and powerful sound.',
                              buttonText: "Shop Now",
                              imageUrl: products[3].images.isNotEmpty ? products[3].images.first : '',
                              isWide: false,
                              isHalf: true,
                            ),
                          ],
                        )),
                    ],
                  ),
                )),
              ],
              SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom + 24)),
            ],
          );
        },
      ),
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

class _MusicExperienceCard extends StatelessWidget {
  const _MusicExperienceCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enhance Your Music Experience',
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.textIconsOnDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildTimerBox('06', 'Days'),
                  const SizedBox(width: 10),
                  _buildTimerBox('18', 'Hours'),
                  const SizedBox(width: 10),
                  _buildTimerBox('46', 'Mins'),
                  const SizedBox(width: 10),
                  _buildTimerBox('22', 'Secs'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Check it out!',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textIconsOnDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerBox(String time, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.textIconsOnDark,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            time,
            style: const TextStyle(
              color: AppColors.textIconsPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.textIconsOnDark, fontSize: 12),
        ),
      ],
    );
  }
}
