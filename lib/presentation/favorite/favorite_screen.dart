import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/presentation/favorite/getx/favorite_controller.dart';
import 'widgets/favorite_appbar.dart';
import 'widgets/favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Scaffold(
        appBar: FavoriteAppBar(),
        body: GetBuilder<FavoriteController>(builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.products.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                FavoriteItem(product: controller.products[index]),
          );
        }));
  }
}
