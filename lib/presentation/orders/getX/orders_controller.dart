import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/errors/failures.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/data/models/order_model.dart';
import 'package:super_ecommerce/data/repositories/order_repository.dart';

class OrdersController extends GetxController {
  OrderRepository orderRepository = Get.find();
  List<OrderModel> activeList = [];
  List<OrderModel> cancelledList = [];
  List<OrderModel> completedList = [];
  AsyncStatus status = AsyncStatus.idle;
  AsyncStatus activeStatus = AsyncStatus.idle;
  AsyncStatus cancelledStatus = AsyncStatus.idle;
  AsyncStatus completedStatus = AsyncStatus.idle;

  List<OrderModel> getOrders({String type = "active"}) {
    switch (type) {
      case "completed":
        return completedList;
      case "cancelled":
        return cancelledList;
      default:
        return activeList;
    }
  }

  void updateStatus(String type, AsyncStatus status) {
    switch (type) {
      case "completed":
        completedStatus = status;
      case "cancelled":
        cancelledStatus = status;
      default:
        activeStatus = status;
    }
    update([type]);
  }

  AsyncStatus getStatus(String type) {
    switch (type) {
      case "completed":
        return completedStatus;
      case "cancelled":
        return cancelledStatus;
      default:
        return activeStatus;
    }
  }

  void updateOrderList(String type, List<OrderModel> orders) {
    switch (type) {
      case "completed":
        completedList.addAll(orders);
      case "cancelled":
        cancelledList.addAll(orders);
      default:
        activeList.addAll(orders);
    }
  }

  void fetchOrders({String type = "active"}) async {
    await handleCustomResultAsync(
        setStatus: (s) => updateStatus(type, s),
        task: () => orderRepository.getAll(type: type),
        onSuccess: (orders) => updateOrderList(type, orders),
        onError: (failure) {
          AppMessage.showError(message: failure.message);
        });
  }

  Map<int, AsyncStatus> cancelOrderStatus = {};

  Future<void> cancelOrder(int orderId) async {
    await handleCustomResultAsync(
      setStatus: (s) => cancelOrderStatus[orderId] = s,
      task: () => orderRepository.cancelOrder(orderId),
      onSuccess: (_) {
        cancelOrderStatus.remove(orderId);
        Get.offNamed(AppRoute.orderScreen, preventDuplicates: false);
        AppMessage.showInfo(message: "تم إلغاء الطلب بنحاح");
      },
      onError: (failure) {
        if (failure is ValidationFailure) {
          AppMessage.showError(message: failure.messages['message']);
        } else {
          AppMessage.showError(message: failure.message);
        }
      },
      updateIds: ['cancelOrder'],
    );
  }
}
