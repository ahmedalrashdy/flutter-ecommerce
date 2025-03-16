import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';

class GenericRating extends StatelessWidget {
  const GenericRating({super.key});

  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    ProductDetailsController controller = Get.find(tag: "product_$productId");
    int rating = controller.productDetail!.product.rating.toInt();
    TextDirection dir = Get.locale?.languageCode == "ar"
        ? TextDirection.rtl
        : TextDirection.ltr;
    return SizedBox(
      width: 195,
      height: 200,
      child: Stack(
        children: [
          Positioned.directional(
              top: 50,
              start: 10,
              textDirection: dir,
              child: _getIcon(1, rating)),
          Positioned.directional(
              top: 30,
              start: 45,
              textDirection: dir,
              child: _getIcon(2, rating)),
          Positioned.directional(
              top: 20,
              start: 80,
              textDirection: dir,
              child: _getIcon(3, rating)),
          Positioned.directional(
              top: 30,
              start: 115,
              textDirection: dir,
              child: _getIcon(4, rating)),
          Positioned.directional(
              top: 50,
              start: 150,
              textDirection: dir,
              child: _getIcon(4, rating)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${controller.productDetail!.product.rating}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Text(
                  "based on ${controller.productDetail!.rating.totalRatings} rating",
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Icon _getIcon(int number, int rating) {
    return number <= rating
        ? const Icon(Icons.star, color: Color(0xffffc82c), size: 35)
        : const Icon(Icons.star, color: Color(0xffcccccc), size: 35);
  }
}
