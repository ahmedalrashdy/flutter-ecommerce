import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../services/simple_cache_service.dart';
import 'app_theme.dart';
import 'colors/dark_color_scheme.dart';
import 'colors/light_color_scheme.dart';

class ThemeController extends GetxController {
  final SimpleCacheService simpleCacheService = Get.find();
  final _key = 'isDarkMode';

  ThemeMode themeMode = ThemeMode.light;

  ThemeData get currentThemeData {
    final colors = themeMode == ThemeMode.dark
        ? const DarkAppColors()
        : const LightAppColors();
    return AppTheme.getThemeData(colors, themeMode);
  }

  ThemeData lightTheme =
      AppTheme.getThemeData(const LightAppColors(), ThemeMode.light);

  ThemeData darkTheme =
      AppTheme.getThemeData(const DarkAppColors(), ThemeMode.dark);

  @override
  void onInit() {
    super.onInit();

    _loadThemeFromBox();
  }

  void _loadThemeFromBox() {
    bool isDarkMode = simpleCacheService.get(_key) ?? _isSystemDarkMode();
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode);
  }

  bool _isSystemDarkMode() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  Future<void> _saveThemeToBox(bool isDarkMode) async {
    await simpleCacheService.set(_key, isDarkMode);
  }

  void switchTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemeToBox(themeMode == ThemeMode.dark);
    Get.changeThemeMode(themeMode);
  }

  void setTheme(ThemeMode mode) {
    if (themeMode != mode) {
      themeMode = mode;
      Get.changeThemeMode(mode);
      _saveThemeToBox(mode == ThemeMode.dark);
    }
  }
}
