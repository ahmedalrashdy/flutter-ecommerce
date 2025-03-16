import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/data/models/category_model.dart';
import '../../../core/dialogs/app_message.dart';
import '../../../core/enums/product_type.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/models/product_holder_model.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/product_repository.dart';

class SubCategoryController extends GetxController {
  final CategoryRepository categoryRepository = Get.find();
  final ProductRepository productRepository = Get.find();
  List<CategoryModel> subCategories = [];
  ProductHolderModel products = ProductHolderModel();
  AsyncStatus bestSellStatus = AsyncStatus.idle;
  AsyncStatus allStatus = AsyncStatus.idle;
  AsyncStatus recentStatus = AsyncStatus.idle;
  AsyncStatus tapRatedStatus = AsyncStatus.idle;
  AsyncStatus subCategoriesStatus = AsyncStatus.idle;
  final ScrollController scrollController = ScrollController();
  Rx<bool> showSearchBar = false.obs;
  late CategoryModel category;

  @override
  void onInit() {
    super.onInit();
    category = Get.arguments!;
    getChildrenOfCategory(category.id);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.offset > 100 && !showSearchBar.value) {
      showSearchBar.value = true;
    } else if (scrollController.offset <= 100 && showSearchBar.value) {
      showSearchBar.value = false;
    }
  }

  Future<void> getMainCategories() async {
    await handleCustomResultAsync(
        setStatus: (s) => subCategoriesStatus = s,
        task: () => categoryRepository.getMainCategories(),
        onSuccess: (cats) => subCategories = cats,
        onError: _handleFailure,
        updateIds: ['subCategories']);
  }

  Future<void> getChildrenOfCategory(int categoryId) async {
    await handleCustomResultAsync(
        setStatus: (s) => subCategoriesStatus = s,
        task: () => categoryRepository.getChildrenOfCategory(categoryId),
        onSuccess: (cats) => subCategories = cats,
        onError: _handleFailure,
        updateIds: ['subCategories']);
  }

  Future<void> getProducts() async {
    await handleCustomResultAsync(
        setStatus: (s) => allStatus = s,
        task: () => productRepository.getProducts(categoryId: category.id),
        onSuccess: (prods) => products.all.addAll(prods),
        onError: _handleFailure,
        updateIds: [ProductType.all]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getBestSeller() async {
    await handleCustomResultAsync(
        setStatus: (s) => bestSellStatus = s,
        task: () =>
            productRepository.getBestSellerProducts(categoryId: category.id),
        onSuccess: (prods) => products.bestSeller.addAll(prods),
        onError: _handleFailure,
        updateIds: [ProductType.bestSeller]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getRecentProducts() async {
    await handleCustomResultAsync(
        setStatus: (s) => recentStatus = s,
        task: () =>
            productRepository.getRecentProducts(categoryId: category.id),
        onSuccess: (prods) => products.recent.addAll(prods),
        onError: (failure) => AppMessage.showError(message: failure.message),
        updateIds: [ProductType.recent]);
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> getTapRated() async {
    await handleCustomResultAsync(
        setStatus: (s) => tapRatedStatus = s,
        task: () =>
            productRepository.getTapRatedProducts(categoryId: category.id),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
}
