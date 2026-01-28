import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: context.colors.primary,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.colors.onPrimary,
          size: 20,
        ),
        onPressed: () => Get.back(),
      ),
      title: Text(
        "سلة المشتريات",
        style: context.appTextTheme.bold23.copyWith(
          color: context.colors.onPrimary,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: context.colors.onPrimary,
                size: 24,
              ),
              onPressed: () {},
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: GetBuilder<CartController>(builder: (controller) {
                  return Text(
                    "${controller.cartList.length}",
                    style: context.appTextTheme.bold23.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
