import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/functions/format_price.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';

class BottomSummery extends StatelessWidget {
  const BottomSummery({super.key});

  @override
  Widget build(BuildContext context) {
    String total = formatPrice(getTotal());

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.lighten(context.colors.surface),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow(
            title: 'المجموع الفرعي:',
            value: '\$$total',
            titleStyle: context.appTextTheme.regular16
                .copyWith(color: context.colors.onSurface),
            valueStyle: context.appTextTheme.bold16
                .copyWith(color: context.darken(context.colors.primary)),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            title: 'الشحن:',
            value: 'مجاني',
            titleStyle: context.appTextTheme.regular16,
            valueStyle: context.appTextTheme.bold16.copyWith(
              color: context.colors.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(
              color: Colors.grey.shade200,
              thickness: 1,
            ),
          ),
          _buildSummaryRow(
            title: 'المجموع الكلي:',
            value: '\$$total',
            titleStyle: context.appTextTheme.bold23,
            valueStyle: context.appTextTheme.bold23.copyWith(
              color: context.darken(context.colors.primary),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoute.paymentScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: context.colors.primary.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'متابعة الدفع',
                style: context.appTextTheme.bold18.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String value,
    required TextStyle titleStyle,
    required TextStyle valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  double getTotal() {
    CartController controller = Get.find();
    double total = 0;
    controller.cartList.forEach((item) {
      if (controller.selectedItem.isEmpty ||
          controller.selectedItem.contains(item.productId))
        total += (item.price - item.discountPrice);
    });
    return total;
  }
}
