import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/models/product_model.dart';

class ProductPageView extends StatefulWidget {
  ProductModel product;
  ProductPageView({super.key, required this.product});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pc,
      itemCount: widget.product.additionalImages.length + 1,
      itemBuilder: (context, index) {
        String url = index == 0
            ? widget.product.mainImage
            : widget.product.additionalImages[index - 1];
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.fill,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pc.dispose();
  }
}
