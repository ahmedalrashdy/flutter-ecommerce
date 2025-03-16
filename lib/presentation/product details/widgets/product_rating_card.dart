import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getX/product_detail_controller.dart';
import 'generic_rating.dart';
import 'rating_row.dart';

class ProductRatingCard extends StatelessWidget {
  const ProductRatingCard({super.key});
  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    ProductDetailsController controller = Get.find(tag: "product_$productId");

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "مراجعات  العملاء",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  elevation: 6,
                  color: const Color(0xff0052cc),
                  child: const Text(
                    "اكتب تقييم للمنتج",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const GenericRating(),
                Expanded(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(8),
                    child: _getRatingRows(controller),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getRatingRows(ProductDetailsController controller) {
    if (controller.productDetail!.rating.totalRatings == 0) return Container();
    return Column(
      children: [
        RatingRow(
            number: 5,
            rating: controller.productDetail!.rating.rating5Count /
                controller.productDetail!.rating.totalRatings),
        RatingRow(
            number: 4,
            rating: controller.productDetail!.rating.rating4Count /
                controller.productDetail!.rating.totalRatings),
        RatingRow(
            number: 3,
            rating: controller.productDetail!.rating.rating3Count /
                controller.productDetail!.rating.totalRatings),
        RatingRow(
            number: 2,
            rating: controller.productDetail!.rating.rating2Count /
                controller.productDetail!.rating.totalRatings),
        RatingRow(
            number: 1,
            rating: controller.productDetail!.rating.rating1Count /
                controller.productDetail!.rating.totalRatings),
      ],
    );
  }
}
