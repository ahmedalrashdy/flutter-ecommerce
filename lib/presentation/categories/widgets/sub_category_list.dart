import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/widgets/category_list.dart';
import '../../../core/widgets/request_widget.dart';
import '../getX/sub_category_controller.dart';
import 'category_card.dart';

class SubCategoryList extends StatelessWidget {
  const SubCategoryList({
    super.key,
    required this.id,
    required this.tag,
  });
  final String id;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubCategoryController>(
        id: id,
        tag: tag,
        builder: (controller) {
          return RequestWidget(
              status: controller.subCategoriesStatus,
              loading: SizedBox(
                height: 150,
                child: Center(
                  child: LottieBuilder.asset(AppAssets.lottieLoading),
                ),
              ),
              success: controller.subCategories.isEmpty
                  ? SizedBox.shrink()
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "الفئات",
                            style: AppTextStyle.bold16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 150,
                          child: CategoryList(
                              categories: controller.subCategories),
                        )
                      ],
                    ));
        });
  }
}
