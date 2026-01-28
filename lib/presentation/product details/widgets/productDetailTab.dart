import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/core/widgets/product_sliver_grid.dart';
import 'package:super_ecommerce/core/widgets/shimmer_product_grid.dart';
import 'package:super_ecommerce/presentation/product%20details/widgets/product_bottom_nav_bar.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';

import 'product_info.dart';

class ProductDetailTab extends StatelessWidget {
  const ProductDetailTab({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    log("جاري بناء الtab of details");
    String productId = Get.parameters["productId"]!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: ProductInfo(
                tabController: tabController,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "منتجات مشابهة",
              style: context.appTextTheme.bold23,
            ),
          ),
          GetBuilder<ProductDetailsController>(
              tag: "product_$productId",
              builder: (controller) {
                return ProductGrid(
                    products: controller.relatedProducts,
                    fetchData: () {
                      controller.getBestSeller(5);
                    });
              }),
          GetBuilder<ProductDetailsController>(
              tag: "product_$productId",
              builder: (controller) {
                return controller.relatedProductsStatus == AsyncStatus.loading
                    ? const ShimmerProductGrid(
                        itemCount: 6,
                      )
                    : const SliverToBoxAdapter();
              }),
        ],
      ),
      bottomNavigationBar: ProductBottomNavBar(
        productId: productId,
      ),
    );
  }
}
