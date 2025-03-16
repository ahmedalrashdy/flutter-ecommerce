import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/widgets/bottom_nav_bar.dart';
import 'package:super_ecommerce/core/widgets/custom_app_bar.dart';
import 'package:super_ecommerce/core/widgets/tab_content.dart';
import 'package:super_ecommerce/presentation/products/views/category_section_view.dart';

import '../../../data/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, vsync: this);
    ProductModel.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, tabController: tabController),
      body: TabBarView(
          controller: tabController,
          children: List.generate(7, (index) {
            return TabContent(
              child: CategorySectionView(
                tagIndex: index,
                categoryId: index,
              ),
            );
          })),
    );
  }
}
