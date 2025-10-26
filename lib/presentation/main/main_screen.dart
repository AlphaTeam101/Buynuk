import 'package:e_commerce/presentation/cart/cart_screen.dart';
import 'package:e_commerce/presentation/design_system/app_colors.dart';
import 'package:e_commerce/presentation/home/home_screen.dart';
import 'package:e_commerce/presentation/orders/orders_screen.dart';
import 'package:e_commerce/presentation/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const Scaffold(body: Center(child: Text('Search'))), // Placeholder for Search
    const Scaffold(body: Center(child: Text('Wishlist'))), // Placeholder for Wishlist
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: _BottomNavBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
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
        padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 12.0),
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
