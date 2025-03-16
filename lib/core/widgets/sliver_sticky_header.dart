import 'package:flutter/material.dart';

class SliverStickyHeader extends SliverPersistentHeaderDelegate {
  SliverStickyHeader({required this.child});
  final Widget child;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
