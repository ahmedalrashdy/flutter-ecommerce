import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';
import 'package:super_ecommerce/presentation/profile&setting/views/profile_screen.dart';
import '../../presentation/cart/cart_screen.dart';
import 'categories/views/categories_screen.dart';
import '../../presentation/products/views/home_screen.dart';
import '../core/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<bool> _isPageLoaded = [true, false, false, false];

  final List<Widget?> _pages = [HomeScreen(), null, null, null];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (!_isPageLoaded[index]) {
        _pages[index] = _buildPage(index);
        _isPageLoaded[index] = true;
      }
      if (index == 2 && refreshCartScreen) {
        _refreshCartScreen();
      } else if (index == 2) {
        refreshCartScreen = true;
      }
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return CategoriesScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(
          _pages.length,
          (index) => _pages[index] ?? Container(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  bool refreshCartScreen = false;
  void _refreshCartScreen() async {
    await Get.find<CartController>().getCartList();
  }
}
