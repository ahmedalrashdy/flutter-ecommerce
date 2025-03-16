import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/data/models/cart_item_model.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';

import '../../../core/constants/app_text_style.dart';
import '../../../core/functions/format_price.dart';
import '../../../core/theme/app_theme.dart';

class StatusWrapper {
  AsyncStatus status = AsyncStatus.idle;
  bool isSelected = false;
}

class CartItem extends StatelessWidget {
  CartItem({super.key, required this.cartController, required this.cartItem});
  final CartItemModel cartItem;
  final CartController cartController;
  final StatusWrapper status = StatusWrapper();
  @override
  Widget build(BuildContext context) {
    String newPrice = formatPrice(cartItem.price - cartItem.discountPrice);
    String oldPrice = formatPrice(cartItem.price);
    String discountRate = cartItem.price != 0 || cartItem.discountPrice == 0
        ? (cartItem.discountPrice / cartItem.price * 100).toStringAsFixed(1)
        : "";
    log("building cart item");
    log(status.isSelected.toString());
    return GetBuilder<CartController>(
        id: "cartItem_${cartItem.productId}",
        builder: (controller) {
          return InkWell(
            onLongPress: () {
              controller.toggleSelect(cartItem.productId, status: status);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: status.isSelected
                    ? AppTheme.primaryColor.withOpacity(.3)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(cartItem.mainImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (status.status != AsyncStatus.loading) {
                                    cartController.deleteCartItem(
                                        cartItem.productId,
                                        status: status);
                                  }
                                },
                                customBorder: const CircleBorder(),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GetBuilder<CartController>(
                                      id: "deleteCart_${cartItem.productId}",
                                      builder: (controller) {
                                        return status.status ==
                                                AsyncStatus.loading
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppTheme.primaryColor,
                                                ))
                                            : Icon(
                                                Icons.close,
                                                size: 20,
                                                color: Colors.red.shade400,
                                              );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      // cartItem Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.name,
                              style: AppTextStyle.bold18.copyWith(
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cartItem.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.regular14.copyWith(
                                color: Colors.grey.shade600,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping_outlined,
                                  size: 18,
                                  color: AppTheme.deepPrimaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'توصيل مجاني',
                                  style: AppTextStyle.regular13.copyWith(
                                    color: AppTheme.deepPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price with discount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$$newPrice',
                                style: AppTextStyle.bold20.copyWith(
                                  color: AppTheme.deepPrimaryColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '\$$oldPrice',
                                style: AppTextStyle.regular14.copyWith(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'خصم ${discountRate}%',
                            style: AppTextStyle.regular13.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      // Quantity Controls
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildQuantityButton(
                              icon: Icons.remove,
                              onPressed: () {},
                            ),
                            Container(
                              width: 45,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Text(
                                "${cartItem.quantity}",
                                style: AppTextStyle.bold16,
                              ),
                            ),
                            _buildQuantityButton(
                              icon: Icons.add,
                              onPressed: () {},
                            ),
                          ],
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

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.deepPrimaryColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
