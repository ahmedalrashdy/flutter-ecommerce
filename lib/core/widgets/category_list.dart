import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/data/models/category_model.dart';

import '../../presentation/categories/widgets/category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories});
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, index) {
        return SizedBox(width: 10);
      },
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 130,
          child: CategoryCard(
              category: categories[index],
              onTap: () {
                Get.toNamed(AppRoute.subcategoriesScreen,
                    preventDuplicates: false, arguments: categories[index]);
              }),
        );
      },
    );
  }
}
