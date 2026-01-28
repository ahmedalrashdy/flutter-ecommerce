import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.colors.primary,
      title: Text(
        title,
        style: context.appTextTheme.bold23,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () => Get.back(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
