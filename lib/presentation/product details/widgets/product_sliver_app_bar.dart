import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';
import 'product_page_view.dart';

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    return GetX<ProductDetailsController>(
        tag: "product_$productId",
        builder: (controller) {
          return SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            expandedHeight: controller.expandedHeight.value,
            toolbarHeight: controller.toolbarHeight.value,
            title: controller.isExpanded.value
                ? Text(
                    controller.productDetail!.product.name,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                : null,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.pink[400]!, Colors.pink[900]!])),
              child: FlexibleSpaceBar(
                background:
                    ProductPageView(product: controller.productDetail!.product),
                stretchModes: const [StretchMode.zoomBackground],
              ),
            ),
          );
        });
  }
}
