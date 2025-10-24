import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final int cartItemCount;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.cartItemCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(20),
      height: 75, // Increased height to accommodate labels
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / 4;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: selectedIndex * itemWidth,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: _buildNavItem(index, theme),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavItem(int index, ThemeData theme) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onItemTapped(index),
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(index, isSelected, theme),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? theme.primaryColor : Colors.transparent,
              ),
              child: Text(_getLabel(index), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(int index, bool isSelected, ThemeData theme) {
    IconData selectedIcon;
    IconData unselectedIcon;

    switch (index) {
      case 0:
        selectedIcon = Icons.home;
        unselectedIcon = Icons.home_outlined;
        break;
      case 1:
        selectedIcon = Icons.shopping_cart;
        unselectedIcon = Icons.shopping_cart_outlined;
        break;
      case 2:
        selectedIcon = Icons.list_alt;
        unselectedIcon = Icons.list_alt_outlined;
        break;
      case 3:
        selectedIcon = Icons.person;
        unselectedIcon = Icons.person_outline;
        break;
      default:
        return const SizedBox.shrink();
    }

    Widget icon = Icon(
      isSelected ? selectedIcon : unselectedIcon,
      color: isSelected ? theme.primaryColor : Colors.grey,
      size: 28,
    );

    // Apply scaling to the icon
    icon = AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: isSelected ? 1.1 : 1.0,
      child: icon,
    );

    // Wrap with Badge for the cart icon *after* scaling
    if (index == 1) {
      icon = Badge(
        label: Text(cartItemCount.toString()),
        isLabelVisible: cartItemCount > 0,
        backgroundColor: Colors.red,
        child: icon, // The scaled icon is now the child
      );
    }

    return icon;
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Cart';
      case 2:
        return 'Orders';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}
