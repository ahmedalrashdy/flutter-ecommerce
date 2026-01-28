import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

import 'search_field.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.context, required this.tabController});
  final BuildContext context;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: context.gradients.primary),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _buildIcon(Icons.shopping_cart_outlined,
                    onPressed: () => Get.toNamed(AppRoute.cartScreen)),
                Transform.translate(
                  offset: const Offset(15, 0),
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
                const Expanded(
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
                indicatorColor: context.colors.onPrimary,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.only(bottom: 5),
                dividerHeight: 0,
                dividerColor: Colors.transparent,
                unselectedLabelStyle: context.appTextTheme.bold14
                    .copyWith(color: context.colors.onPrimary.withOpacity(.6)),
                labelStyle: context.appTextTheme.bold14
                    .copyWith(color: context.colors.onPrimary),
                controller: tabController,
                tabs: const [
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
        color: context.darken(context.colors.onPrimary, .2),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Size get preferredSize => Size(context.screenWidth, 115);
}
