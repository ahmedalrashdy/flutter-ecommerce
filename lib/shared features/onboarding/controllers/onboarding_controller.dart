import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/shared_preferences_constants.dart';
import 'package:super_ecommerce/shared%20features/onboarding/models/onboarding_model.dart';

import '../../../core/constants/app_assets.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  final List<Color> pageColors = [
    const Color(0xFFFFF3E0), // Warm Orange
    const Color(0xFFE8F5E9), // Soft Green
    const Color(0xFFE3F2FD), // Light Blue
    const Color(0xFFFCE4EC), // Light Pink for Product Tracking
  ];

  // Get current page color
  Color get currentColor => pageColors[selectedPageIndex.value];

  void setSeenOnboarding() async {
    final prefs = Get.find<SharedPreferences>();
    await prefs.setBool(SharedPreferencesConstants.seenOnboarding, true);
  }

  void nextPage() {
    if (isLastPage) {
      setSeenOnboarding();
      Get.offAllNamed(AppRoute.HomeScreen); // Navigate to home screen
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToHome() {
    setSeenOnboarding();
    Get.offAllNamed(AppRoute.HomeScreen);
  }

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'مرحباً بك في متجرنا',
      description: 'اكتشف منتجات رائعة وعروض مميزة في مكان واحد',
      image: AppAssets.imagesOnboardingFood,
    ),
    OnboardingModel(
      title: 'تسوق بسهولة',
      description:
          'تسوق براحة تامة واحصل على منتجاتك المفضلة موصلة إلى باب منزلك',
      image: AppAssets.imagesOnboardingCart,
    ),
    OnboardingModel(
      title: 'دفع آمن',
      description: 'خيارات دفع متعددة مع معالجة آمنة للمعاملات المالية',
      image: AppAssets.imagesOnboardingSecure,
    ),
    OnboardingModel(
      title: 'تتبع المنتجات',
      description: 'سهولة تتبع المنتجات المفضلة لديك ومراقبة توفرها في المتجر',
      image: AppAssets.imagesOnboardingTracking,
    ),
  ];
}
