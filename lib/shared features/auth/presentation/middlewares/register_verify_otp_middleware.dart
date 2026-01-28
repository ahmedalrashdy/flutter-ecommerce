import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/simple_cache_keys.dart';
import 'package:super_ecommerce/core/services/simple_cache_service.dart';

class RegisterVerifyOtpMiddleware extends GetMiddleware {
  final SimpleCacheService simpleCacheService = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    String? email = simpleCacheService
        .get<String?>(SharedPreferencesConstants.registerEmail);
    if (email != null) {
      return RouteSettings(
          name: AppRoute.verifyOtpScreen, arguments: {"email": email});
    }
    return super.redirect(route);
  }
}
