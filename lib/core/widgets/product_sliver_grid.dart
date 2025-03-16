import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/widgets/custom_%20message.dart';
import '../../data/models/product_model.dart';
import 'product_card.dart';

class ProductGrid extends StatefulWidget {
  final List<ProductModel> products;
  final Function fetchData;
  const ProductGrid(
      {super.key, required this.products, required this.fetchData});
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    log("جاري بناء المخطط");
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          log("جاري بناء الكارد رقم $index");
          return ProductCard(
            product: widget.products[index],
          );
        },
        itemCount: widget.products.length,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    log("جاري هدم productGrid");
  }
}
