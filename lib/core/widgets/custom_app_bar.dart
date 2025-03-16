import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';

import 'search_field.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.context, required this.tabController});
  final BuildContext context;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.pink.shade600, Colors.pink.shade900])),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _buildIcon(Icons.shopping_cart_outlined,
                    onPressed: () => Get.toNamed(AppRoute.cartScreen)),
                Transform.translate(
                  offset: Offset(15, 0),
                  child: IconButton(
                    icon: Transform.scale(
                      scaleY: 1.2,
                      child: _buildIcon(
                        Icons.mail_outline,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: SizedBox(height: 40, child: SearchField()),
                ),
                _buildIcon(Icons.favorite_border,
                    onPressed: () => Get.toNamed(AppRoute.favoriteScreen)),
              ],
            ),
            TabBar(
                textScaler: TextScaler.noScaling,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.white70,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.only(bottom: 8),
                dividerHeight: 0,
                dividerColor: Colors.transparent,
                unselectedLabelStyle:
                    AppTextStyle.bold14.copyWith(color: Colors.white),
                labelStyle: AppTextStyle.bold14.copyWith(color: Colors.white),
                controller: tabController,
                tabs: [
                  Tab(
                    text: "الكل",
                  ),
                  Tab(
                    text: "الملابس",
                  ),
                  Tab(
                    text: "المنزل",
                  ),
                  Tab(
                    text: "الالكترونيات",
                  ),
                  Tab(
                    text: "الإكسسورات",
                  ),
                  Tab(
                    text: "التجميل",
                  ),
                  Tab(
                    text: "التنظيف",
                  ),
                ])
          ],
        ),
      ),
    );
  }

  IconButton _buildIcon(IconData icon, {void Function()? onPressed}) {
    return IconButton(
      icon: Icon(
        icon,
        size: 22,
        color: Colors.white70,
      ),
      onPressed: onPressed,
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(context).size.width, 115);
}
