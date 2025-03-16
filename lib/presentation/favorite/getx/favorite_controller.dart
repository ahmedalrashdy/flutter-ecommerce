import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/data/repositories/product_repository.dart';

import '../../../core/dialogs/custom_confirm_dialog.dart';

class FavoriteController extends GetxController {
  List<ProductModel> products = [];
  ProductRepository productRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  void getFavorites() {
    final result = productRepository.getFavorites();
    result.fold((failure) {
      AppMessage.showInfo(message: failure.message);
    }, (products) {
      this.products = products;
      update();
    });
  }

  void deleteAllFavorite() {
    Get.dialog(CustomConfirmationDialog(
      title: 'حذف عناصر المفضلة',
      content: 'هل أنت متأكد من تنفيذ هذا الإجراء؟',
      isDestructive: true,
      icon: Icons.delete_outline, // Custom icon
      confirmText: 'نعم، متأكد', // Custom button text
      onConfirm: () async {
        final result = await productRepository.deleteAllFavorite();
        result.fold((failure) {
          AppMessage.showError(message: failure.message);
        }, (_) {
          products.clear();
          update();
        });
      },
    ));
  }

  Future<void> deleteFromFavorite(int productId) async {
    Get.dialog(CustomConfirmationDialog(
      title: 'حذف عناصر المفضلة',
      content: 'هل أنت متأكد من تنفيذ هذا الإجراء؟',
      isDestructive: true,
      icon: Icons.delete_outline, // Custom icon
      confirmText: 'نعم، متأكد', // Custom button text
      onConfirm: () async {
        final result =
            await productRepository.deleteProductFromFavorite(productId);
        result.fold((failure) {
          AppMessage.showError(message: failure.message);
        }, (_) {
          products.removeWhere((element) {
            return element.id == productId;
          });
          update();
        });
      },
    ));
  }
}
