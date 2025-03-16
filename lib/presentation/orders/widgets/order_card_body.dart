import 'package:flutter/material.dart';
import 'package:super_ecommerce/data/models/order_model.dart';

class OrderCardBody extends StatelessWidget {
  const OrderCardBody({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (order.items).length,
      itemBuilder: (context, index) {
        final item = order.items[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade100,
                width: 1,
              ),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.product['main_image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              item.product['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  '${item.quantity}x \$${(item.price - item.discount)}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: Text(
              '\$${(item.quantity * (item.price - item.discount)).toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
