import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_commerce/presentation/design_system/app_theme.dart';

// Mock Banner Data Model
class BannerItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String callToAction;
  final Color? backgroundColor;

  const BannerItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.callToAction,
    this.backgroundColor,
  });
}

// Mock Banner Service
class MockBannerService {
  static List<BannerItem> getBanners() {
    return [
      const BannerItem(
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=2899&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        title: 'Summer Sale!',
        subtitle: 'Up to 50% off on selected items.',
        callToAction: 'Shop Now',
        backgroundColor: Color(0xFFFEE2E2), // Light Red
      ),
      const BannerItem(
        imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        title: 'New Arrivals',
        subtitle: 'Discover the latest trends.',
        callToAction: 'Explore',
        backgroundColor: Color(0xFFDBEAFE), // Light Blue
      ),
      const BannerItem(
        imageUrl: 'https://images.unsplash.com/photo-1572635196232-adcd1e40d107?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        title: 'Limited Time Offer',
        subtitle: 'Don\'t miss out on amazing deals!',
        callToAction: 'Get Yours',
        backgroundColor: Color(0xFFD1FAE5), // Light Green
      ),
    ];
  }
}

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late List<BannerItem> _banners;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _banners = MockBannerService.getBanners();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= _banners.length) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final appColors = theme.extension<AppColorsExtension>()!;

    if (_banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 200, // Fixed height for the banner carousel
          child: PageView.builder(
            controller: _pageController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    // Apply a subtle parallax effect to the image
                    final parallax = value * 30; // Adjust this value for more/less parallax
                    return Transform.translate(
                      offset: Offset(parallax, 0),
                      child: Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(1 - (value.abs() * 0.2)).clamp(0.8, 1.0) * 200, // Scale effect
                          child: child,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: SizedBox(
                      height: 200,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: banner.backgroundColor ?? appColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            banner.imageUrl,
                            fit: BoxFit.cover,
                            // Added a placeholder for better loading experience
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.totalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.totalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey, child: const Icon(Icons.broken_image, color: Colors.white)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                banner.title,
                                style: textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.2),
                              const SizedBox(height: 8),
                              Text(
                                banner.subtitle,
                                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: -0.2),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // TODO: Implement navigation based on banner.callToAction or targetScreen
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${banner.callToAction} clicked!')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: appColors.brandSecondary,
                                  foregroundColor: appColors.brandSecondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                ),
                                child: Text(
                                  banner.callToAction,
                                  style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideX(begin: -0.2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _banners.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _pageController.animateToPage(
                entry.key,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentPage == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension on ImageChunkEvent {
  get totalBytes => null;
}
