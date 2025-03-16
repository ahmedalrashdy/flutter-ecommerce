import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/services/shared_preferences_service.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';

class GlobalController extends GetxController {
  late ThemeMode themeMode;
  late Locale locale;
  SimpleCacheService simpleCacheService = Get.find();

  @override
  void onInit() {
    super.onInit();
    String? currentTheme = simpleCacheService.get<String?>("theme");
    String? currentLang = simpleCacheService.get<String?>("lang");
    initTheme(currentTheme);
    initLang(currentLang);
  }

  void initTheme(String? currentTheme) {
    if (currentTheme == null) {
      themeMode = ThemeMode.system;
      if (themeMode == ThemeMode.dark) {
        AppTheme.setDarkMode(true);
      }
    } else if (currentTheme == "dark") {
      themeMode = ThemeMode.dark;
      AppTheme.setDarkMode(true);
    } else {
      themeMode = ThemeMode.light;
      AppTheme.setDarkMode(false);
    }
  }

  void initLang(String? currentLang) {
    if (currentLang == null) {
      locale = Get.deviceLocale!.languageCode == "ar" ||
              Get.deviceLocale!.languageCode == "ar"
          ? Get.deviceLocale!
          : const Locale("ar");
    } else if (currentLang == "en") {
      locale = const Locale("en");
    } else {
      locale = const Locale("ar");
    }
  }

  Future<void> toggleDarkMode() async {
    bool isDark = themeMode == ThemeMode.dark;
    if (isDark && themeMode != ThemeMode.light) {
      themeMode = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
      await simpleCacheService.set<String>("theme", "light");
    } else if (!isDark && themeMode != ThemeMode.dark) {
      themeMode = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
      await simpleCacheService.set<String>("theme", "dark");
    }
  }

  Future<void> updateLang(String langCode) async {
    if (langCode != locale.languageCode) {
      locale = Locale(langCode);
      Get.updateLocale(locale);
      await simpleCacheService.set<String>("lang", langCode);
    }
  }
}
