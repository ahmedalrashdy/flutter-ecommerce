import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/presentation/favorite/getx/favorite_controller.dart';

class FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoriteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.find();

    return AppBar(
      elevation: 0,
      backgroundColor: context.darken(context.colors.primary),
      title: Text(
        "المفضلة",
        style: context.appTextTheme.bold23.copyWith(
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
