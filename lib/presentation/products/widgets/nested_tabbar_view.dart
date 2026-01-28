import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/widgets/shimmer_product_grid.dart';
import 'package:super_ecommerce/presentation/products/getX/category_section_view_controller.dart';

import '../../../core/enums/product_type.dart';
import '../../../core/widgets/product_sliver_grid.dart';
import '../../../core/widgets/basic/tab_content.dart';

class NestedTabbarView extends StatelessWidget {
  const NestedTabbarView(
      {super.key,
      required this.controller,
      required this.tabController,
      required this.tagIndex});
  final TabController tabController;
  final int tagIndex;
  final CategorySectionViewController controller;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          TabContent(
              child: GetBuilder<CategorySectionViewController>(
                  id: ProductType.all,
                  tag: "tab_${tagIndex}",
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
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<CategorySectionViewController>(
                  id: ProductType.bestSeller,
                  tag: "tab_${tagIndex}",
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
                        if (controller.bestSellerStatus == AsyncStatus.loading)
                          const ShimmerProductGrid(
                            itemCount: 6,
                          ),
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<CategorySectionViewController>(
                  id: ProductType.tapRated,
                  tag: "tab_${tagIndex}",
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
                      ],
                    );
                  })),
          TabContent(
              child: GetBuilder<CategorySectionViewController>(
                  id: ProductType.recent,
                  tag: "tab_${tagIndex}",
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
                      ],
                    );
                  }))
        ]);
  }
}
