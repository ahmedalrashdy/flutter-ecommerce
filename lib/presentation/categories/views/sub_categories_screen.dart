import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/constants/app_assets.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/widgets/category_nav_bar.dart';
import 'package:super_ecommerce/core/widgets/request_widget.dart';
import 'package:super_ecommerce/data/models/category_model.dart';
import 'package:super_ecommerce/presentation/categories/getX/sub_category_controller.dart';
import 'package:super_ecommerce/presentation/categories/widgets/sub_category_app_bar.dart';
import '../widgets/sub_category_list.dart';
import '../widgets/category_card.dart';
import '../widgets/nested_tabbar_view.dart';
import '../../../core/widgets/offers_carousel.dart';

class SubcategoriesScreen extends StatefulWidget {
  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int categoryId = (Get.arguments as CategoryModel).id;
    SubCategoryController controller =
        Get.put(SubCategoryController(), tag: "subCategory_${categoryId}");
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SubCategoryAppBar(category: controller.category),
                // Main Content
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Offers Carousel
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: OffersCarousel()),
                      const SizedBox(height: 24),

                      // Categories List
                      SubCategoryList(
                        id: "subCategories",
                        tag: "subCategory_${categoryId}",
                      ),
                      const SizedBox(height: 24),
                      CategoryNavBar(tabController: tabController),
                    ],
                  ),
                ),
              ];
            },
            body: NestedTabbarView(
                controller: controller, tabController: tabController)));
  }
}
