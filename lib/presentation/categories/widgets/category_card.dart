import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/theme/app_theme_current.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/data/models/category_model.dart';

import '../../../core/widgets/custom_image.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.onPrimary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [context.shadows.medium],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomImage(
                  imageUrl: category.image,
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // Category Title
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category.name,
                          style: context.appTextTheme.bold18
                              .copyWith(color: context.colors.onSurface)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.shop_outlined,
                            size: 16,
                            color: context.colors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'View All',
                            style: context.appTextTheme.regular12.copyWith(
                                color: context.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
