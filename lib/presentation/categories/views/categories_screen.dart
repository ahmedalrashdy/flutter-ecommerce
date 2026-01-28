import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/theme/app_theme_current.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/core/widgets/custom_%20message.dart';
import 'package:super_ecommerce/core/widgets/request_widget.dart';
import 'package:super_ecommerce/core/widgets/simple_app_bar.dart';
import '../../../core/constants/app_assets.dart';

import '../getX/categories_screen_controller.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.lighten(context.colors.surface),
      appBar: SimpleAppBar(title: 'Categories'),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CategoriesScreenController>(
            init: CategoriesScreenController(),
            builder: (controller) {
              return RequestWidget(
                status: controller.status,
                loading: Center(
                  child: Lottie.asset(AppAssets.lottieLoading,
                      width: 200, height: 250, fit: BoxFit.cover),
                ),
                success: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: controller.categories[index],
                      onTap: () {
                        Get.toNamed(AppRoute.subcategoriesScreen,
                            arguments: controller.categories[index]);
                      },
                    );
                  },
                ),
                failure: const Center(
                  child: CustomMessage(
                    icon: Icons.error,
                    title: "حدث خطأ ما غير معروف الرجاء المحاوله لاحقاً",
                  ),
                ),
              );
            }),
      ),
    );
  }
}
