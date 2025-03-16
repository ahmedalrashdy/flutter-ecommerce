import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/enums/product_type.dart';
import 'package:super_ecommerce/core/errors/exceptions.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/data/models/category_model.dart';
import 'package:super_ecommerce/data/models/product_holder_model.dart';
import 'package:super_ecommerce/data/repositories/category_repository.dart';
import 'package:super_ecommerce/data/repositories/product_repository.dart';
import '../../../core/enums/async_status.dart';

class CategorySectionViewController extends GetxController {
  final CategoryRepository categoryRepository = Get.find();
  final ProductRepository productRepository = Get.find();
  List<CategoryModel> mainCategories = [];
  ProductHolderModel products = ProductHolderModel();

  AsyncStatus subCategoriesStatus = AsyncStatus.idle;
  AsyncStatus bestSellerStatus = AsyncStatus.idle;
  AsyncStatus allStatus = AsyncStatus.idle;
  AsyncStatus recentStatus = AsyncStatus.idle;
  AsyncStatus tapRatedStatus = AsyncStatus.idle;

  int? categoryId;
  CategorySectionViewController({this.categoryId});

  @override
  void onInit() {
    super.onInit();
    if (categoryId != null) {
      getChildrenOfCategory(categoryId!);
    } else {
      getMainCategories();
    }
  }

  Future<void> getMainCategories() async {
    await handleCustomResultAsync(
        setStatus: (s) => subCategoriesStatus = s,
        task: () => categoryRepository.getMainCategories(),
        onSuccess: (cats) => mainCategories = cats,
        onError: _handleFailure,
        updateIds: ['subCategories']);
  }

  Future<void> getChildrenOfCategory(int categoryId) async {
    await handleCustomResultAsync(
        setStatus: (s) => subCategoriesStatus = s,
        task: () => categoryRepository.getChildrenOfCategory(categoryId),
        onSuccess: (cats) => mainCategories = cats,
        onError: _handleFailure,
        updateIds: ['subCategories']);
  }

  Future<void> getProducts() async {
    await handleCustomResultAsync(
        setStatus: (s) => allStatus = s,
        task: () => productRepository.getProducts(categoryId: categoryId),
        onSuccess: (prods) => products.all.addAll(prods),
        onError: _handleFailure,
        updateIds: [ProductType.all]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getBestSeller() async {
    await handleCustomResultAsync(
        setStatus: (s) => bestSellerStatus = s,
        task: () =>
            productRepository.getBestSellerProducts(categoryId: categoryId),
        onSuccess: (prods) => products.bestSeller.addAll(prods),
        onError: _handleFailure,
        updateIds: [ProductType.bestSeller]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getRecentProducts() async {
    await handleCustomResultAsync(
        setStatus: (s) => recentStatus = s,
        task: () => productRepository.getRecentProducts(categoryId: categoryId),
        onSuccess: (prods) => products.recent.addAll(prods),
        onError: (failure) => AppMessage.showError(message: failure.message),
        updateIds: [ProductType.recent]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getTapRated() async {
    await handleCustomResultAsync(
        setStatus: (s) => tapRatedStatus = s,
        task: () =>
            productRepository.getTapRatedProducts(categoryId: categoryId),
        onSuccess: (prods) => products.tapRated.addAll(prods),
        onError: _handleFailure,
        updateIds: [ProductType.recent]);
    await Future.delayed(Duration(seconds: 2));
  }

  void _handleFailure(failure) {
    if (failure is ValidationException) {
    } else {
      AppMessage.showError(message: failure.message);
    }
  }
}
