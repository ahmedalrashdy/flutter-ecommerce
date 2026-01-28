import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';
import '../../../core/widgets/ExpandedText.dart';
import 'product_price.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    ProductDetailsController controller = Get.find(tag: "product_$productId");
    int rating = (controller.productDetail!.product.rating.toInt()) - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.productDetail!.product.name,
          style: context.appTextTheme.bold23,
        ),
        Text("الملابس الرجاليه",
            style: context.appTextTheme.bold16.copyWith(color: Colors.grey)),
        ProductPrice(
          discount: controller.productDetail!.product.price,
          price: controller.productDetail!.product.discount,
          size: 20,
          size2: 16,
        ),
        InkWell(
          onTap: () {
            tabController.animateTo(1, duration: const Duration(seconds: 0));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(5, (index) {
                return index <= rating
                    ? const Icon(Icons.star, color: Color(0xffffc82c), size: 30)
                    : const Icon(Icons.star,
                        color: Color(0xffcccccc), size: 30);
              }),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 30,
                child: Text(
                  "${controller.productDetail!.product.rating}",
                  style: context.appTextTheme.bold16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "(${controller.productDetail!.rating.totalRatings} مراجعة)",
                style:
                    context.appTextTheme.bold12.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ExpandedText(
          text: controller.productDetail!.product.description ?? "",
          style: context.appTextTheme.bold16.copyWith(color: Colors.grey[800]),
          maxLines: 3,
        )
      ],
    );
  }
}
