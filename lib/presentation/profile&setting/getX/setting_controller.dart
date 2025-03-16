import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/shared%20features/auth/data/auth_controller.dart';
import 'package:super_ecommerce/core/controllers/global_controller.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';

import '../../../core/dialogs/custom_confirm_dialog.dart';

class SettingController extends GetxController {
  AuthController authController = Get.find();
  GlobalController globalController = Get.find();
  final ValueNotifier<String> currentLanguage = ValueNotifier(
      Get.find<GlobalController>().locale.languageCode == "ar"
          ? "العربية"
          : "English");
  final ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);
  final ValueNotifier<bool> locationEnabled = ValueNotifier(true);

  final Map<String, String> availableLanguages = {
    "العربية": "ar",
    "English": "en"
  };

  void updateLanguage(String language) async {
    if (language == "العربية") {
      await globalController.updateLang("ar");
    } else {
      await globalController.updateLang("en");
    }
    currentLanguage.value = language;
  }

  void toggleDarkMode() async {
    await globalController.toggleDarkMode();
    isDarkMode.value = globalController.themeMode == ThemeMode.dark;
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
          await authController.logout();
          Get.offAllNamed(AppRoute.loginScreen);
        }));
  }
}
