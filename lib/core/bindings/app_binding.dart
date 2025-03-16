import 'package:get/get.dart';
import 'package:super_ecommerce/core/controllers/product_card_controller.dart';
import 'package:super_ecommerce/data/repositories/address_repository.dart';
import 'package:super_ecommerce/data/repositories/cart_repository.dart';
import 'package:super_ecommerce/data/repositories/category_repository.dart';
import '../../data/repositories/order_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductCardController(), permanent: true);
    Get.lazyPut<CategoryRepository>(
        () => CategoryRepositoryImpWithHttp(apiService: Get.find()),
        fenix: true);
    Get.lazyPut<CartRepository>(
        () => CartRepositoryImpWithHttp(apiService: Get.find()),
        fenix: true);
    Get.lazyPut<AddressRepository>(
        () => AddressRepositoryImpWithHttp(apiService: Get.find()),
        fenix: true);
    Get.lazyPut<OrderRepository>(
        () => OrderRepositoryImpWithHttp(apiService: Get.find()),
        fenix: true);
  }
}
