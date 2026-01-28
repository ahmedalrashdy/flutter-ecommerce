import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_ecommerce/core/theme/app_theme_current.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';
import 'package:super_ecommerce/presentation/profile&setting/getX/setting_controller.dart';
import 'package:super_ecommerce/presentation/profile&setting/widgets/settings/setting_item.dart';
import 'package:super_ecommerce/presentation/profile&setting/widgets/settings/user_header.dart';
import '../../../core/dialogs/custom_confirm_dialog.dart';
import '../../../core/widgets/simple_app_bar.dart';
import '../widgets/settings/language_bottom_sheet.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SimpleAppBar(title: "Settings"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authController.isAuth
                ? UserHeader()
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: CustomButton(
                      title: "Login",
                      onPressed: () {},
                    ),
                  ),
            _buildSettingsSection(
              context,
              'Preferences',
              [
                ValueListenableBuilder<bool>(
                  valueListenable: settingController.notificationsEnabled,
                  builder: (context, enabled, _) {
                    return SettingItem(
                      icon: Icons.notifications_outlined,
                      iconColor: Colors.red,
                      title: 'Notifications',
                      trailing: Switch.adaptive(
                        value: enabled,
                        onChanged: (value) =>
                            settingController.toggleNotifications(),
                        activeColor: context.colors.primary,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<String>(
                  valueListenable: settingController.currentLanguage,
                  builder: (context, currentLanguage, _) {
                    return SettingItem(
                      icon: Icons.language,
                      iconColor: Colors.green,
                      title: 'Language',
                      trailing: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const LanguageBottomSheet(),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              currentLanguage,
                              style: context.appTextTheme.regular16,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: context.colors.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: settingController.isDarkMode,
                  builder: (context, darkMode, _) {
                    return SettingItem(
                      icon: Icons.dark_mode_outlined,
                      iconColor: Colors.purple,
                      title: 'Dark Mode',
                      trailing: Switch.adaptive(
                        value: darkMode,
                        onChanged: (value) {
                          settingController.toggleDarkMode();
                        },
                        activeColor: context.colors.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
            _buildSettingsSection(
              context,
              'Privacy & Security',
              [
                SettingItem(
                  icon: Icons.security,
                  iconColor: Colors.teal,
                  title: 'Privacy Settings',
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: settingController.locationEnabled,
                  builder: (context, enabled, _) {
                    return SettingItem(
                      icon: Icons.location_on_outlined,
                      iconColor: Colors.indigo,
                      title: 'Location Services',
                      trailing: Switch.adaptive(
                        value: enabled,
                        onChanged: (value) =>
                            settingController.toggleLocation(),
                        activeColor: context.colors.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
            _buildSettingsSection(
              context,
              'About',
              [
                SettingItem(
                  icon: Icons.info_outline,
                  iconColor: Colors.grey.shade700,
                  title: 'About App',
                  trailing: Text(
                    'v1.0.0',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SettingItem(
                  icon: Icons.help_outline,
                  iconColor: Colors.brown,
                  title: 'Help & Support',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: CustomButton(
                title: "Logout",
                onPressed: settingController.logout,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
      BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}
