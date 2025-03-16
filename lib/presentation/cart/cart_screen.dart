import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/shared%20features/auth/data/auth_controller.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/widgets/custom_%20message.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';
import 'package:super_ecommerce/presentation/cart/widgets/bottom_summery.dart';
import 'package:super_ecommerce/presentation/cart/widgets/cart_item.dart';
import '../../core/constants/app_assets.dart';
import 'widgets/cart_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.put(CartController());
    final auth = Get.find<AuthController>();
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: const CartAppBar(),
        bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
          if (controller.cartList.isEmpty) return const SizedBox.shrink();
          return GetBuilder<CartController>(
              id: "cartSummery",
              builder: (_) {
                return BottomSummery();
              });
        }),
        body: GetBuilder<CartController>(builder: (controller) {
          if (!auth.isAuth) {
            return const Center(
              child: CustomMessage(
                icon: Icons.lock,
                title: 'يرجى تسجيل الدخول لعرض سلة التسوق',
              ),
            );
          }
          if (controller.status == AsyncStatus.loading) {
            return Center(
              child: Lottie.asset(AppAssets.lottieLoading,
                  width: 200, height: 250, fit: BoxFit.cover),
            );
          }

          if (controller.cartList.isEmpty) {
            return const Center(
              child: CustomMessage(
                  icon: Icons.remove_shopping_cart,
                  title: 'سلة التسوق فارغة\nهيا بنا نتسوق!'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.cartList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) => CartItem(
              cartItem: controller.cartList[index],
              cartController: controller,
            ),
          );
        }));
  }
}
