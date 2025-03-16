import 'package:dartz/dartz.dart';
import 'package:super_ecommerce/core/constants/api_endpoints.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import '../../main.dart';
import '../models/order_model.dart';

abstract class OrderRepository with ExceptionHandler {
  CustomResultAsync<List<OrderModel>> getAll({String type = 'active'});

  CustomResultAsync<Unit> cancelOrder(int orderId);
}

class OrderRepositoryImpWithHttp extends OrderRepository {
  ApiService apiService;
  OrderRepositoryImpWithHttp({required this.apiService});
  @override
  CustomResultAsync<List<OrderModel>> getAll({String type = "active"}) async {
    return handleExceptionAsync<List<OrderModel>>(() async {
      final data = await apiService
          .get(ApiEndpoint.getAllOrders, queryParameters: {"type": type});
      return Right(OrderModel.fromListMap(data));
    });
  }

  CustomResultAsync<Unit> cancelOrder(int orderId) async {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.cancelOrder(orderId));
      return const Right(unit);
    });
  }
}
