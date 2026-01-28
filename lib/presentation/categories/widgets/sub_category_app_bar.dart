import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/data/models/category_model.dart';
import 'package:super_ecommerce/presentation/categories/getX/sub_category_controller.dart';

class SubCategoryAppBar extends StatelessWidget {
  SubCategoryAppBar({required this.category});
  CategoryModel category;
  @override
  Widget build(BuildContext context) {
    SubCategoryController controller = Get.find(
      tag: "subCategory_${category.id}",
    );
    return Obx(
      () {
        return SliverAppBar(
          expandedHeight: 60,
          pinned: true,
          floating: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back,
                color: context.colors.onPrimary,
              )),
          backgroundColor: context.colors.primary,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: controller.showSearchBar.value
                ? _buildSearchField()
                : Text(
                    category.name,
                    style: context.appTextTheme.bold20
                        .copyWith(color: context.colors.onPrimary),
                  ),
          ),
          actions: [
            if (!controller.showSearchBar.value)
              IconButton(
                  icon: Icon(Icons.search, color: context.colors.onPrimary),
                  onPressed: () => controller.showSearchBar.value = true),
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: context.colors.onPrimary),
              onPressed: () => Get.toNamed(AppRoute.cartScreen),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search in ${category.name}',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
