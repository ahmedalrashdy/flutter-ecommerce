import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/widgets/custom_%20message.dart';
import 'package:super_ecommerce/core/widgets/shimmer_product_grid.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/presentation/categories/getX/sub_category_controller.dart';
import '../../../core/enums/product_type.dart';
import '../../../core/widgets/product_sliver_grid.dart';
import '../../../core/widgets/tab_content.dart';

class NestedTabbarView extends StatelessWidget {
  const NestedTabbarView({
    super.key,
    required this.controller,
    required this.tabController,
  });
  final TabController tabController;

  final SubCategoryController controller;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          TabContent(
              child: GetBuilder<SubCategoryController>(
                  id: ProductType.all,
                  tag: "subCategory_${controller.category.id}",
                  builder: (controller) {
                    log("جاري بناء ProductGrid of all");
                    return CustomScrollView(
                      slivers: [
                        ProductGrid(
                          products: controller.products.all,
                          fetchData: () {
                            controller.getProducts();
                          },
                        ),
                        if (controller.allStatus == AsyncStatus.loading)
                          const ShimmerProductGrid(
                            itemCount: 6,
                          ),
                        _buildEmptyState(
                            controller.allStatus, controller.products.all)
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<SubCategoryController>(
                  id: ProductType.bestSeller,
                  tag: "subCategory_${controller.category.id}",
                  builder: (controller) {
                    log("جاري بناء ProductGrid of all");
                    return CustomScrollView(
                      slivers: [
                        ProductGrid(
                          products: controller.products.bestSeller,
                          fetchData: () {
                            controller.getBestSeller();
                          },
                        ),
                        if (controller.bestSellStatus == AsyncStatus.loading)
                          const ShimmerProductGrid(
                            itemCount: 6,
                          ),
                        _buildEmptyState(controller.bestSellStatus,
                            controller.products.bestSeller)
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<SubCategoryController>(
                  id: ProductType.tapRated,
                  tag: "subCategory_${controller.category.id}",
                  builder: (controller) {
                    log("جاري بناء ProductGrid of all");
                    return CustomScrollView(
                      slivers: [
                        ProductGrid(
                          products: controller.products.tapRated,
                          fetchData: () {
                            controller.getTapRated();
                          },
                        ),
                        if (controller.tapRatedStatus == AsyncStatus.loading)
                          const ShimmerProductGrid(
                            itemCount: 6,
                          ),
                        _buildEmptyState(controller.tapRatedStatus,
                            controller.products.tapRated)
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<SubCategoryController>(
                  id: ProductType.recent,
                  tag: "subCategory_${controller.category.id}",
                  builder: (controller) {
                    log("جاري بناء ProductGrid of all");
                    return CustomScrollView(
                      slivers: [
                        ProductGrid(
                          products: controller.products.recent,
                          fetchData: () {
                            controller.getRecentProducts();
                          },
                        ),
                        if (controller.recentStatus == AsyncStatus.loading)
                          const ShimmerProductGrid(
                            itemCount: 6,
                          ),
                        _buildEmptyState(
                            controller.recentStatus, controller.products.recent)
                      ],
                    );
                  }))
        ]);
  }

  Widget _buildEmptyState(AsyncStatus status, List<ProductModel> products) {
    if (status == AsyncStatus.success && products.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: Center(
            child: CustomMessage(
                icon: Icons.list, title: "لايوجد منتحات في هذه الفئة"),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter();
  }
}
