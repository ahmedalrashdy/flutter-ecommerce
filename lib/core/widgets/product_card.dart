import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/controllers/product_card_controller.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import '../constants/app_text_style.dart';

class ProductCard extends StatefulWidget {
  ProductModel product;
  ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final PageController _pageController = PageController();

  void navigateToProductDetails() {
    String currentRoute = Get.currentRoute.split("?")[0];
    String key = UniqueKey().toString();
    if (currentRoute != AppRoute.productDetails) {
      Get.toNamed(
        AppRoute.productDetails,
        arguments: widget.product,
        parameters: {"key": key, "productId": "${widget.product.id}"},
      );
    } else {
      Get.offNamed(
        AppRoute.productDetails,
        arguments: widget.product,
        parameters: {"key": key, "productId": "${widget.product.id}"},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductCardController controller = Get.find();
    return InkWell(
      onTap: navigateToProductDetails,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Image Slider Section
                Expanded(
                  child: _buildImageSlider(),
                ),
                // Product Details
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      _buildPriceRow(),
                      const SizedBox(height: 4),
                      _buildRatingStars(),
                    ],
                  ),
                ),
              ],
            ),

            // Favorite Button
            Positioned(
              top: 8,
              left: 8,
              child: GetBuilder<ProductCardController>(
                  id: widget.product.id,
                  builder: (context) {
                    log("جاري بناء الكارد رقم ${widget.product.id}");
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: IconButton(
                        icon: widget.product.isFavorite
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                        onPressed: () async {
                          await controller.handleAddToFavorite(widget.product);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _currentPage.value = index,
          itemCount: widget.product.additionalImages.length + 1,
          itemBuilder: (context, index) {
            log("تم بناء page view of index: $index");
            return Image.network(
              index == 0
                  ? widget.product.mainImage
                  : widget.product.additionalImages[index - 1],
              fit: BoxFit.cover,
            );
          },
        ),

        // Discount Badge
        if (widget.product.discount > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "${widget.product.discount}% OFF",
                style: AppTextStyle.semiBold12.copyWith(color: Colors.white),
              ),
            ),
          ),

        // Page Indicators
        if (widget.product.additionalImages.isNotEmpty)
          Positioned(
            bottom: 8,
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, value, _) => Row(
                children: List.generate(
                  widget.product.additionalImages.length + 1,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == index
                          ? Colors.pink
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      children: [
        Text(
          "\$${(widget.product.price * (1 - widget.product.discount / 100)).toStringAsFixed(2)}",
          style: AppTextStyle.bold16.copyWith(color: Colors.deepOrange),
        ),
        // const SizedBox(width: 4),
        if (widget.product.discount > 0)
          Text(
            "\$${widget.product.price.toStringAsFixed(2)}",
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
      ],
    );
  }

  Widget _buildRatingStars() {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < widget.product.rating.floor()
              ? Icons.star
              : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }
}
