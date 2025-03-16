import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/widgets/offers_carousel.dart';
import 'package:super_ecommerce/presentation/products/getX/category_section_view_controller.dart';
import 'package:super_ecommerce/presentation/products/widgets/sub_category_list.dart';
import '../../../core/widgets/category_nav_bar.dart';
import '../../../core/widgets/sliver_sticky_header.dart';
import '../widgets/nested_tabbar_view.dart';
import '../widgets/offers_list_view.dart';

class CategorySectionView extends StatefulWidget {
  const CategorySectionView(
      {super.key, required this.tagIndex, this.categoryId});
  final int tagIndex;
  final int? categoryId;
  @override
  State<CategorySectionView> createState() => _CategorySectionViewState();
}

class _CategorySectionViewState extends State<CategorySectionView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CategorySectionViewController categorySectionController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    categorySectionController = Get.put(
        CategorySectionViewController(categoryId: widget.categoryId),
        tag: "tab_${widget.tagIndex}");
  }

  @override
  Widget build(BuildContext context) {
    log("جاري بناء الصفخه");
    return NestedScrollView(
        headerSliverBuilder: (contex, bool) {
          return [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: OffersCarousel(),
              ),
            ),
            SliverToBoxAdapter(
                child: SubCategoryList(
                    id: "subCategories", tag: "tab_${widget.tagIndex}")),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverStickyHeader(
                  child: SizedBox(
                height: 45,
                child: CategoryNavBar(tabController: tabController),
              )),
            )
          ];
        },
        body: NestedTabbarView(
            controller: categorySectionController,
            tabController: tabController,
            tagIndex: widget.tagIndex));
  }
}
