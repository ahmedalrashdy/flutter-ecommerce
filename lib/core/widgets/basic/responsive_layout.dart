import 'package:flutter/material.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout(
      {super.key,
      required this.mobileBuilder,
      this.tabletBuilder,
      this.desktopBuilder});
  final WidgetBuilder mobileBuilder;
  final WidgetBuilder? tabletBuilder;
  final WidgetBuilder? desktopBuilder;
  @override
  Widget build(BuildContext context) {
    if (context.isDesktop && desktopBuilder != null) {
      return desktopBuilder!(context);
    }

    if (context.isTabletDevice && tabletBuilder != null) {
      return tabletBuilder!(context);
    }
    return mobileBuilder(context);
  }
}
