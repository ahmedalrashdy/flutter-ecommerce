import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/data/repositories/product_repository.dart';
import '../errors/failures.dart';

class ProductCardController extends GetxController {
  final ProductRepository productRepository = Get.find();

  Future<void> handleAddToFavorite(ProductModel product) async {
    Either<Failure, Unit> result;
    if (ProductModel.favoriteProducts.containsKey(product.id)) {
      result = await productRepository.deleteProductFromFavorite(product.id);
    } else {
      result = await productRepository.addToFavorite(product);
    }
    result.fold((failure) {
      AppMessage.showError(message: failure.message);
    }, (_) {
      update([product.id]);
      if (product.isFavorite) {
        AppMessage.showInfo(message: "تم اضافة المنتج الى المفضله");
      } else {
        AppMessage.showInfo(message: "تمت إزاله المنتج من المفضلة");
      }
    });
  }
}
