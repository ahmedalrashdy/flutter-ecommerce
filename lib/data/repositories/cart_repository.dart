import 'package:dartz/dartz.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/data/models/cart_item_model.dart';
import 'package:super_ecommerce/main.dart';
import '../../core/constants/api_endpoints.dart';

abstract class CartRepository with ExceptionHandler {
  CustomResultAsync<List<CartItemModel>> getCartItems();
  CustomResultAsync<Unit> addProductToCart(int productId, int qty);
  CustomResultAsync<Unit> deleteCartItem(int productId);
}

class CartRepositoryImpWithHttp extends CartRepository {
  final ApiService apiService;

  CartRepositoryImpWithHttp({required this.apiService});
  @override
  CustomResultAsync<List<CartItemModel>> getCartItems() async {
    return handleExceptionAsync<List<CartItemModel>>(() async {
      final data = await apiService.get(ApiEndpoint.cartList);
      return Right(CartItemModel.fromMapList(data));
    });
  }

  @override
  CustomResultAsync<Unit> addProductToCart(int productId, int qty) {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.addProductToCart,
          body: {"product_id": productId, "qty": qty});
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<Unit> deleteCartItem(int productId) {
    return handleExceptionAsync<Unit>(() async {
      await apiService
          .delete(ApiEndpoint.deleteCartItem, body: {"product_id": productId});
      return const Right(unit);
    });
  }
}
