import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/widgets/request_widget.dart';
import 'package:super_ecommerce/data/models/order_model.dart';
import 'package:super_ecommerce/presentation/orders/getX/orders_controller.dart';
import 'package:super_ecommerce/presentation/orders/widgets/order_card.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key, required this.type});
  final String type;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  OrdersController controller = Get.find();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((context) {
      controller.fetchOrders(type: widget.type);
    });
  }

  List<OrderModel> orders = [];
  @override
  Widget build(BuildContext context) {
    orders = controller.getOrders(type: widget.type);
    return GetBuilder<OrdersController>(
        id: widget.type,
        builder: (_) {
          return RequestWidget(
              status: controller.getStatus(widget.type),
              centerLoading: true,
              centerFailure: true,
              success: orders.isEmpty
                  ? Center(
                      child: Text("Empty orders"),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: orders.length,
                      itemBuilder: (ctx, index) {
                        return OrderCard(order: orders[index]);
                      }));
        });
  }
}
