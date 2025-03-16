import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/hive_boxes.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/core/services/hive_service.dart';
import 'package:super_ecommerce/data/models/product_detail_model.dart';
import 'package:super_ecommerce/data/models/product_model.dart';
import 'package:super_ecommerce/main.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/services/api_service.dart';

abstract class ProductRepository extends GetxService with ExceptionHandler {
  CustomResultAsync<List<ProductModel>> getProducts({int? categoryId});
  CustomResultAsync<List<ProductModel>> getRecentProducts({int? categoryId});
  CustomResultAsync<List<ProductModel>> getTapRatedProducts({int? categoryId});
  CustomResultAsync<List<ProductModel>> getBestSellerProducts(
      {int? categoryId});
  CustomResultAsync<ProductDetailModel> productRetrieve(int productId);
  CustomResultAsync<Unit> addToFavorite(ProductModel product);
  CustomResult<List<ProductModel>> getFavorites();
  CustomResultAsync<Unit> deleteAllFavorite();
  CustomResultAsync<Unit> deleteProductFromFavorite(int productId);
}

class ProductRepositoryImpWithHttp extends ProductRepository {
  final ApiService apiService;
  final HiveService hiveService;
  ProductRepositoryImpWithHttp(
      {required this.apiService, required this.hiveService});

  @override
  CustomResultAsync<List<ProductModel>> getBestSellerProducts(
      {int? categoryId}) async {
    return handleExceptionAsync<List<ProductModel>>(() async {
      final data = await apiService.get(categoryId == null
          ? ApiEndpoint.productsBestSeller
          : ApiEndpoint.productsBestSellerOfCategory(categoryId));

      return Right(ProductModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<List<ProductModel>> getProducts({int? categoryId}) async {
    return handleExceptionAsync<List<ProductModel>>(() async {
      final data = await apiService.get(categoryId == null
          ? ApiEndpoint.productsOfCategory(categoryId ?? -1)
          : ApiEndpoint.productsOfCategory(categoryId));
      return Right(ProductModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<List<ProductModel>> getRecentProducts(
      {int? categoryId}) async {
    return handleExceptionAsync<List<ProductModel>>(() async {
      final data = await apiService.get(categoryId == null
          ? ApiEndpoint.productsRecent
          : ApiEndpoint.productsRecentOfCategory(categoryId));
      return Right(ProductModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<List<ProductModel>> getTapRatedProducts(
      {int? categoryId}) async {
    return handleExceptionAsync<List<ProductModel>>(() async {
      final data = await apiService.get(categoryId == null
          ? ApiEndpoint.productsTapRated
          : ApiEndpoint.productsTapRatedOfCategory(categoryId));
      return Right(ProductModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<ProductDetailModel> productRetrieve(int productId) {
    return handleExceptionAsync<ProductDetailModel>(() async {
      final data = await apiService.get(ApiEndpoint.productRetrieve(productId));
      return Right(ProductDetailModel.fromMap(data));
    });
  }

  @override
  CustomResultAsync<Unit> addToFavorite(ProductModel product) async {
    return handleExceptionAsync<Unit>(() async {
      await hiveService.boxes[HiveBoxes.favorites]!
          .put("favorites:${product.id}", product);
      ProductModel.appProducts[product.id]!.isFavorite = true;
      ProductModel.favoriteProducts[product.id] = product;

      return const Right(unit);
    });
  }

  @override
  CustomResult<List<ProductModel>> getFavorites() {
    return handleException<List<ProductModel>>(() {
      final result = hiveService.boxes[HiveBoxes.favorites]!.getAllAsList();
      return Right(result);
    });
  }

  @override
  CustomResultAsync<Unit> deleteAllFavorite() async {
    return handleExceptionAsync(() async {
      await hiveService.boxes[HiveBoxes.favorites]!.clearBox();
      ProductModel.favoriteProducts.clear();
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<Unit> deleteProductFromFavorite(int productId) async {
    return handleExceptionAsync(() async {
      await hiveService.boxes[HiveBoxes.favorites]!
          .delete("favorites:$productId");
      if (ProductModel.favoriteProducts.containsKey(productId)) {
        await hiveService.boxes[HiveBoxes.favorites]!
            .delete("favorites:${productId}");
        ProductModel.favoriteProducts.remove(productId);
        ProductModel.appProducts[productId]!.isFavorite = false;
      }
      return const Right(unit);
    });
  }
}
