import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/errors/failures.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/data/repositories/cart_repository.dart';
import 'package:super_ecommerce/presentation/cart/widgets/cart_item.dart';
import '../../../data/models/cart_item_model.dart';

class CartController extends GetxController {
  final CartRepository cartRepository = Get.find();
  List<CartItemModel> cartList = [];
  AsyncStatus status = AsyncStatus.idle;

  @override
  void onInit() {
    super.onInit();
    getCartList();
  }

  Future<void> getCartList() async {
    await handleCustomResultAsync(
        setStatus: (s) => status = s,
        task: () => cartRepository.getCartItems(),
        onSuccess: (cartItems) => cartList = cartItems,
        onError: (failure) => AppMessage.showError(message: failure.message));
  }

  Future<void> deleteCartItem(int productId,
      {required StatusWrapper status}) async {
    status.status = AsyncStatus.loading;
    update(['deleteCart_$productId']);

    await Future.delayed(Duration(seconds: 2));
    final result = await cartRepository.deleteCartItem(productId);
    result.fold((failure) {
      status.status = AsyncStatus.failure;
      if (failure is AuthFailure) {
      } else {
        AppMessage.showError(message: failure.message);
      }
    }, (_) {
      status.status = AsyncStatus.success;
      cartList.removeWhere((item) => item.productId == productId);
    });

    update(); //for update all items (total ,list,cartCount)
  }

  Set<int> selectedItem = {};

  void toggleSelect(int productId, {required StatusWrapper status}) {
    status.isSelected = !status.isSelected;
    if (status.isSelected) {
      selectedItem.add(productId);
    } else {
      selectedItem.remove(productId);
    }
    update(['cartItem_$productId']);
    update(["cartSummery"]);
  }
}
