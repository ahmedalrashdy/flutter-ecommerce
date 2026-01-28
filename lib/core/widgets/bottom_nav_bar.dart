import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: context.colors.primary,
      selectedItemColor: context.colors.onPrimary,
      unselectedItemColor: context.colors.onPrimary.withOpacity(.6),
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'متجر',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'الفئات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'حقيبة التسوق',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'أنا',
        ),
      ],
    );
  }
}
