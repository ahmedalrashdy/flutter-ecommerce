import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/presentation/addresses/views/address_adding_screen.dart';
import 'package:super_ecommerce/presentation/addresses/views/address_screen.dart';
import 'package:super_ecommerce/presentation/cart/cart_screen.dart';
import 'package:super_ecommerce/presentation/main_screen.dart';
import 'package:super_ecommerce/presentation/orders/views/orders_screen.dart';
import 'package:super_ecommerce/presentation/payment/payment_screen.dart';
import 'package:super_ecommerce/presentation/products/views/home_screen.dart';
import 'package:super_ecommerce/presentation/product%20details/views/product_details_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/login_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/register_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/reset_password_screen.dart';
import 'package:super_ecommerce/shared%20features/onboarding/middleware/onboarding_middleware.dart';
import 'package:super_ecommerce/shared%20features/onboarding/views/onboarding_screen.dart';
import 'presentation/categories/views/categories_screen.dart';
import 'presentation/categories/views/sub_categories_screen.dart';
import 'presentation/favorite/favorite_screen.dart';
import 'presentation/profile&setting/views/profile_screen.dart';

final routes = [
  GetPage(name: AppRoute.HomeScreen, page: () => HomeScreen()),
  GetPage(
    name: AppRoute.productDetails,
    page: () => ProductDetailsScreen(
      key: Key(Get.parameters['key']!),
    ),
  ),
  GetPage(
      name: AppRoute.onBoarding,
      page: () => OnboardingScreen(),
      middlewares: [OnboardingMiddleware()]),
  GetPage(
    name: AppRoute.cartScreen,
    page: () => CartScreen(),
  ),
  GetPage(
    name: AppRoute.favoriteScreen,
    page: () => const FavoriteScreen(),
  ),
  GetPage(
    name: AppRoute.loginScreen,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoute.registerScreen,
    page: () => const RegisterScreen(),
  ),
  GetPage(
    name: AppRoute.forgotPasswordScreen,
    page: () => const ForgotPasswordScreen(),
  ),
  GetPage(
    name: AppRoute.verifyOtpScreen,
    page: () => const VerifyOtpScreen(),
  ),
  GetPage(
    name: AppRoute.resetPassword,
    page: () => const ResetPasswordScreen(email: '', otp: ''),
  ),
  GetPage(
    name: AppRoute.categoriesScreen,
    page: () => CategoriesScreen(),
  ),
  GetPage(
    name: AppRoute.mainScreen,
    page: () => const MainScreen(),
  ),
  GetPage(
    name: AppRoute.profileScreen,
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: AppRoute.addressScreen,
    page: () => const AddressScreen(),
  ),
  GetPage(
    name: AppRoute.addressAddingScreen,
    page: () => const AddressAddingScreen(),
  ),
  GetPage(
    name: AppRoute.paymentScreen,
    page: () => PaymentScreen(),
  ),
  GetPage(
    name: AppRoute.orderScreen,
    page: () => OrdersScreen(),
  ),
  GetPage(
    name: AppRoute.subcategoriesScreen,
    page: () => SubcategoriesScreen(),
  ),
];
