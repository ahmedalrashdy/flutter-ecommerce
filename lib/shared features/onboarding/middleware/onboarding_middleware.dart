import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/simple_cache_keys.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/auth_controller.dart';
import '../../../core/services/simple_cache_service.dart';

class OnboardingMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final simpleCacheService = Get.find<SimpleCacheService>();
    if (simpleCacheService
            .get<bool>(SharedPreferencesConstants.seenOnboarding) ==
        true) {
      if (Get.find<AuthController>().authModel != null) {
        return const RouteSettings(name: AppRoute.mainScreen);
      } else {
        return const RouteSettings(name: AppRoute.loginScreen);
      }
    }
  }
}
