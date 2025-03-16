import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/presentation/products/getX/category_section_view_controller.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/category_list.dart';
import '../../../core/widgets/request_widget.dart';

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
    return GetBuilder<CategorySectionViewController>(
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
              success: controller.mainCategories.isEmpty
                  ? SizedBox.shrink()
                  : Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child:
                          CategoryList(categories: controller.mainCategories),
                    ));
        });
  }
}
