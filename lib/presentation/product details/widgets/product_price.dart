import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  double price;
  double discount;
  double size;
  double size2;
  ProductPrice({
    super.key,
    required this.discount,
    required this.price,
    this.size = 14,
    this.size2 = 14,
  });

  @override
  Widget build(BuildContext context) {
    double newPrice = price - discount;
    return Row(
      children: [
        Text("$newPrice"),
        const SizedBox(
          width: 10,
        ),
        if (discount != 0) ...[
          Text("$price\$",
              style: TextStyle(
                color: Colors.grey,
                fontSize: size2,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 3,
              ))
        ]
      ],
    );
  }
}
