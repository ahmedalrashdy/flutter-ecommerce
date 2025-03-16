import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/functions/format_price.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/presentation/favorite/getx/favorite_controller.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    String newPrice = formatPrice(product.price - product.discount);
    String oldPrice = formatPrice(product.price);
    String discountRate = product.price != 0 || product.discount == 0
        ? (product.discount / product.price * 100).toStringAsFixed(1)
        : "";
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  width: isSmallScreen ? 100 : 120,
                  height: isSmallScreen ? 100 : 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product.mainImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.find<FavoriteController>()
                            .deleteFromFavorite(product.id);
                      },
                      customBorder: const CircleBorder(),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: isSmallScreen ? 16 : 20,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: isSmallScreen ? 12 : 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: AppTextStyle.bold23.copyWith(
                          fontSize: isSmallScreen ? 16 : 18,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      Text(
                        product.description ?? "",
                        style: AppTextStyle.regular16.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: isSmallScreen ? 12 : 14,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price with discount
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '\$$newPrice',
                                    style: AppTextStyle.bold23.copyWith(
                                      color: AppTheme.deepPrimaryColor,
                                      fontSize: isSmallScreen ? 18 : 20,
                                    ),
                                  ),
                                  SizedBox(width: isSmallScreen ? 6 : 8),
                                  if (product.discount > 0)
                                    Text(
                                      oldPrice,
                                      style: AppTextStyle.regular14.copyWith(
                                        color: Colors.grey,
                                        fontSize: isSmallScreen ? 12 : 14,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (product.discount > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 6 : 8,
                                        vertical: isSmallScreen ? 2 : 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        'خصم $discountRate%',
                                        style: AppTextStyle.regular13.copyWith(
                                          color: Colors.green.shade700,
                                          fontSize: isSmallScreen ? 8 : 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  SizedBox(width: isSmallScreen ? 6 : 8),
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    size: isSmallScreen ? 14 : 16,
                                    color: AppTheme.deepPrimaryColor,
                                  ),
                                  SizedBox(width: isSmallScreen ? 2 : 4),
                                  Text(
                                    'شحن مجاني',
                                    style: AppTextStyle.regular13.copyWith(
                                      color: AppTheme.deepPrimaryColor,
                                      fontSize: isSmallScreen ? 11 : 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      // Add to Cart Button
                      SizedBox(
                        height: isSmallScreen ? 36 : 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.deepPrimaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 12 : 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: isSmallScreen ? 16 : 18,
                              ),
                              SizedBox(width: isSmallScreen ? 4 : 6),
                              Text(
                                'أضف للسلة',
                                style: AppTextStyle.regular16.copyWith(
                                  color: Colors.white,
                                  fontSize: isSmallScreen ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
