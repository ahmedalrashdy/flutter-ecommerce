import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/controllers/product_card_controller.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';

class ProductBottomNavBar extends StatefulWidget {
  const ProductBottomNavBar({super.key, required this.productId});
  final String productId;
  @override
  State<ProductBottomNavBar> createState() => _ProductBottomNavBarState();
}

class _ProductBottomNavBarState extends State<ProductBottomNavBar> {
  int quantity = 1;
  late ProductCardController productCardController;
  late ProductModel product;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    productCardController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ProductDetailsController controller =
        Get.find(tag: "product_${widget.productId}");
    final totalPrice = (controller.productDetail!.product.price -
            controller.productDetail!.product.discount) *
        quantity;

    return GetBuilder<ProductDetailsController>(
        tag: "product_${widget.productId}",
        id: "addProductToCart",
        builder: (controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Total Price
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الإجمالي',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${totalPrice.toStringAsFixed(2)} ريال',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Quantity Selector
                      if (!controller.productDetail!.product.isInCart)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _decrementQuantity,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: quantity > 1
                                          ? theme.primaryColor
                                          : theme.primaryColor.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 16,
                                      color: quantity > 1
                                          ? Colors.white
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(minWidth: 40),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  quantity.toString(),
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: _incrementQuantity,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Action Buttons Row
                  Row(
                    children: [
                      // Add to Favorites Button
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await productCardController.handleAddToFavorite(
                                controller.productDetail!.product);
                            setState(() {});
                          },
                          icon: Icon(
                              controller.productDetail!.product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                          color: theme.primaryColor,
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Add to Cart Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (controller.productDetail!.product.isInCart) {
                              Get.toNamed(AppRoute.cartScreen);
                            } else {
                              await controller.addProductToCart(
                                  controller.productDetail!.product.id,
                                  quantity);
                              setState(() {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          icon: controller.addProductToCartStatus ==
                                  AsyncStatus.loading
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.shopping_cart_outlined),
                          label: Text(
                            controller.productDetail!.product.isInCart
                                ? "السلة"
                                : 'إضافة الى السلة',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
