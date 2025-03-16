import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/widgets/sliver_sticky_header.dart';
import 'package:super_ecommerce/core/widgets/tab_content.dart';
import 'package:super_ecommerce/presentation/product%20details/getX/product_detail_controller.dart';
import 'productDetailTab.dart';
import 'product_sliver_app_bar.dart';
import 'review_tab.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key});
  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    String productId = Get.parameters["productId"]!;
    ProductDetailsController controller = Get.find(tag: "product_$productId");
    return NestedScrollView(
      controller: controller.scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const ProductSliverAppBar(),
          SliverPersistentHeader(
            delegate: SliverStickyHeader(
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.pink,
                  indicatorWeight: 3,
                  dividerColor: Colors.grey.shade400,
                  tabs: const [
                    Tab(icon: Text("المنتج")),
                    Tab(icon: Text("المراجعة")),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TabContent(
              child: ProductDetailTab(
            tabController: tabController,
          )),
          const TabContent(child: ReviewTab()),
        ],
      ),
    );
  }
}
