import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/controllers/locale_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/auth_controller.dart';
import '../../../core/dialogs/custom_confirm_dialog.dart';
import '../../../core/theme/theme_controller.dart';

class SettingController extends GetxController {
  AuthController authController = Get.find();
  LocaleController localeController = Get.find();
  ThemeController themeController = Get.find();
  ValueNotifier<String> get currentLanguage => ValueNotifier(
      localeController.appLocale.languageCode == "ar" ? "العربية" : "English");

  final ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);
  final ValueNotifier<bool> locationEnabled = ValueNotifier(true);

  final Map<String, String> availableLanguages = {
    "العربية": "ar",
    "English": "en"
  };

  void updateLanguage(String language) async {
    if (language == "العربية") {
      await localeController.changeLocale("ar");
    } else {
      await localeController.changeLocale("en");
    }
    currentLanguage.value = language;
  }

  void toggleDarkMode() {
    themeController.switchTheme();
    isDarkMode.value = themeController.themeMode == ThemeMode.dark;
  }

  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
  }

  void toggleLocation() {
    locationEnabled.value = !locationEnabled.value;
  }

  Future<void> logout() async {
    await Get.dialog(CustomConfirmationDialog(
        confirmText: "خروج",
        title: "تسجيل الخروج",
        content: "هل انت متأكد من انك تريد تسجيل الخروج",
        isDestructive: true,
        onConfirm: () async {
          if (await authController.logout()) {
            Get.offAllNamed(AppRoute.loginScreen);
          }
        }));
  }
}
