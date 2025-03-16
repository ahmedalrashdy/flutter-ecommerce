import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/data/models/order_model.dart';
import 'package:super_ecommerce/presentation/orders/getX/orders_controller.dart';
import '../../../core/functions/format_date.dart';
import '../views/track_order_screen.dart';
import 'order_card_body.dart';
import 'order_card_footer.dart';
import 'order_card_header.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardHeader(order: order),
          OrderCardBody(order: order),
          OrderCardFooter(order: order),
        ],
      ),
    );
  }
}
