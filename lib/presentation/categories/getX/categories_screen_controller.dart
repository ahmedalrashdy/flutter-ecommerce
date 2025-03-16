import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/data/models/category_model.dart';
import 'package:super_ecommerce/data/repositories/category_repository.dart';

import '../../../core/dialogs/app_message.dart';

class CategoriesScreenController extends GetxController {
  final CategoryRepository categoryRepository = Get.find();
  List<CategoryModel> categories = [];
  AsyncStatus status = AsyncStatus.idle;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    await handleCustomResultAsync(
      setStatus: (s) => status = s,
      task: () => categoryRepository.getMainCategories(),
      onSuccess: (cats) => categories = cats,
      onError: (failure) => AppMessage.showError(message: failure.message),
    );
    await Future.delayed(Duration(seconds: 2));
  }
}
