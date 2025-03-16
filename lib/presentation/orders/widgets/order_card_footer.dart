import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';
import 'package:super_ecommerce/data/models/order_model.dart';
import 'package:super_ecommerce/presentation/orders/getX/orders_controller.dart';

import '../views/track_order_screen.dart';

class OrderCardFooter extends StatelessWidget {
  const OrderCardFooter({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    OrdersController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              Text(
                '\$${order.totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (order.generalStatus == 'active') ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackOrderScreen(order: order),
                        ),
                      );
                    },
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text('Track Order'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (order.status == 'pending')
                  Expanded(
                    child: GetBuilder<OrdersController>(
                        id: "cancelOrder",
                        builder: (controller) {
                          print("building");
                          return CustomButton(
                            title: "Cancel",
                            onPressed: () {
                              controller.cancelOrder(order.id);
                            },
                            isLoading: controller.cancelOrderStatus[order.id] ==
                                    AsyncStatus.loading
                                ? true
                                : false,
                          );
                        }),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
