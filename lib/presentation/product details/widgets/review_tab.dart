import 'dart:developer';

import 'package:flutter/material.dart';
import 'product_rating_card.dart';
import 'user_rating_card.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});
  @override
  Widget build(BuildContext context) {
    log("جاري بناء الtab of details");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            const ProductRatingCard(),
            const SizedBox(
              height: 20,
            )
          ])),
          SliverList.builder(
              itemCount: 500,
              itemBuilder: (content, index) {
                print("building item number:$index");
                return const UserRatingCard();
              })
        ],
      ),
    );
  }
}
