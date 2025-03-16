import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/functions/format_price.dart';
import 'package:super_ecommerce/presentation/cart/getX/cart_controller.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/theme/app_theme.dart';

class BottomSummery extends StatelessWidget {
  const BottomSummery({super.key});

  @override
  Widget build(BuildContext context) {
    String total = formatPrice(getTotal());

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
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
            titleStyle: AppTextStyle.regular16,
            valueStyle: AppTextStyle.bold16,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            title: 'الشحن:',
            value: 'مجاني',
            titleStyle: AppTextStyle.regular16,
            valueStyle: AppTextStyle.bold16.copyWith(
              color: Colors.green,
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
            titleStyle: AppTextStyle.bold23,
            valueStyle: AppTextStyle.bold23.copyWith(
              color: AppTheme.deepPrimaryColor,
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
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'متابعة الدفع',
                style: AppTextStyle.bold18.copyWith(
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
