import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_screen_controller.dart';
import 'package:super_ecommerce/presentation/addresses/widgets/address_list.dart';
import 'package:super_ecommerce/presentation/payment/getX/payment_controller.dart';

import '../../core/widgets/request_widget.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: Text(
            "حدد عنوان الاستلام",
            style: AppTextStyle.bold16.copyWith(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: controller.selectedAddressId == null
                ? null
                : controller.createPaymentIntent,
            backgroundColor: controller.selectedAddressId == null
                ? Colors.grey
                : AppTheme.primaryColor,
            label: Row(
              children: [
                Text("checkout"),
                if (controller.createPaymentStatus == AsyncStatus.loading)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: PageView(
            controller: pageController,
            children: [
              RequestWidget(
                status: controller.status,
                success: ListView.builder(
                    itemCount: controller.addresses.length,
                    itemBuilder: (_, index) {
                      return Card(
                        color: controller.selectedAddressId ==
                                controller.addresses[index].id
                            ? AppTheme.primaryColor
                            : null,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => controller
                              .selectAddress(controller.addresses[index]),
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: controller.selectedAddressId ==
                                      controller.addresses[index].id
                                  ? Colors.white
                                  : AppTheme.primaryColor,
                            ),
                            title: Text(
                              "${controller.addresses[index].address}",
                              style: AppTextStyle.bold16.copyWith(
                                  color: controller.selectedAddressId ==
                                          controller.addresses[index].id
                                      ? Colors.white
                                      : AppTheme.primaryColor),
                            ),
                            subtitle: Text(
                              "${controller.addresses[index].city}",
                              style: AppTextStyle.bold12.copyWith(
                                  color: controller.selectedAddressId ==
                                          controller.addresses[index].id
                                      ? Colors.white
                                      : AppTheme.primaryColor),
                            ),
                            trailing: Checkbox(
                                value: controller.selectedAddressId ==
                                    controller.addresses[index].id,
                                activeColor: Colors.white,
                                checkColor: AppTheme.primaryColor,
                                onChanged: (value) {
                                  controller.selectAddress(
                                      controller.addresses[index]);
                                }),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
