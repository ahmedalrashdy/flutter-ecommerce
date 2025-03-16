import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import '../widgets/product_details_body.dart';
import '../getX/product_detail_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    Get.put(ProductDetailsController(), tag: "product_$productId");
    return Scaffold(
      body: SafeArea(
          child: GetBuilder<ProductDetailsController>(
              tag: "product_$productId",
              builder: (controller) {
                if (controller.status == AsyncStatus.loading) {
                  return Center(
                    child: Lottie.asset("assets/lottie/loading.json"),
                  );
                }
                if (controller.status == AsyncStatus.failure) {
                  return Column(
                    children: [
                      Lottie.asset("assets/lottie/404error.json"),
                      Text(
                        controller.errorMessage,
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  );
                }
                return const ProductDetailsBody();
              })),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // String productId = Get.parameters["productId"]!;
    // Get.delete<ProductDetailsController>(tag: "product_$productId");
  }
}
