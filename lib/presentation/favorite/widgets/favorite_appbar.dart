import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/presentation/favorite/getx/favorite_controller.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.find();

    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.deepPrimaryColor,
      title: Text(
        "المفضلة",
        style: AppTextStyle.bold23.copyWith(
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 24,
          ),
          onPressed: controller.deleteAllFavorite,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
