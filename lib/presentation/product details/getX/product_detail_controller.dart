import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/data/repositories/cart_repository.dart';
import 'package:super_ecommerce/data/repositories/product_repository.dart';
import '../../../core/functions/perform_async_operation.dart';
import '../../../data/models/product_detail_model.dart';

class ProductDetailsController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final ProductRepository productRepository = Get.find();
  final CartRepository cartRepository = Get.find();

  List<ProductModel> relatedProducts = [];
  ProductDetailModel? productDetail;
  AsyncStatus status = AsyncStatus.loading;
  String errorMessage = "";

  final isExpanded = false.obs;
  final expandedHeight = 400.0.obs;
  final toolbarHeight = 50.0.obs;

  void scrollListener() {
    if (scrollController.hasClients &&
        scrollController.offset > 200 &&
        !isExpanded.value) {
      isExpanded.value = true;
    } else if (scrollController.hasClients &&
        scrollController.offset < 200 &&
        isExpanded.value) {
      isExpanded.value = false;
    }
  }

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        ProductModel product = Get.arguments as ProductModel;
        retrieveProduct(product.id);
      } else {
        log("Get.arguments is null");
      }
    });
    super.onInit();
  }

  Future<void> retrieveProduct(int productId) async {
    await handleCustomResultAsync(
      setStatus: (s) => status = s,
      task: () => productRepository.productRetrieve(productId),
      onSuccess: (productDetail) => this.productDetail = productDetail,
    );
  }

  AsyncStatus relatedProductsStatus = AsyncStatus.idle;

  Future<void> getBestSeller(int categoryId) async {
    await handleCustomResultAsync<List<ProductModel>>(
      setStatus: (s) => relatedProductsStatus = s,
      task: () =>
          productRepository.getBestSellerProducts(categoryId: categoryId),
      onSuccess: (prods) => relatedProducts.addAll(prods),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  AsyncStatus addProductToCartStatus = AsyncStatus.idle;
  Future<void> addProductToCart(int productId, int qty) async {
    await handleCustomResultAsync<Unit>(
      task: () => cartRepository.addProductToCart(productId, qty),
      setStatus: (s) => addProductToCartStatus = s,
      onError: (_) {},
      onSuccess: (_) => productDetail!.product.isInCart = true,
      updateIds: ["addProductToCart"],
    );
  }

  @override
  void onClose() {
    log('هدم متحكم تفاصيل المنتج');
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}
