import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_screen_controller.dart';
import '../../../data/models/address_model.dart';

class AddressListTile extends StatelessWidget {
  final AddressModel address;

  const AddressListTile({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: context.colors.primary,
                      size: 32.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.address,
                            style: context.appTextTheme.bold18
                                .copyWith(color: context.colors.onSurface),
                          ),
                          const SizedBox(height: 8.0),
                          Text(address.city,
                              style: context.appTextTheme.regular16.copyWith(
                                  color: context.colors.onSurfaceVariant)),
                          const SizedBox(height: 4.0),
                          Text(
                            'الاحداثيات: ${address.lat.toStringAsFixed(4)}, ${address.lang.toStringAsFixed(4)}',
                            style: context.appTextTheme.regular12.copyWith(
                                color: context.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    if (address.isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.secondary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text('الافتراضي',
                            style: context.appTextTheme.bold14
                                .copyWith(color: context.colors.secondary)),
                      ),
                  ],
                ))),
        Positioned(
            bottom: 5,
            left: 10,
            child: IconButton(
                onPressed: () {
                  Get.dialog(CustomConfirmationDialog(
                      title: "حذف العنوان",
                      content: "التأكيد على حذف العنوان",
                      onConfirm: () {
                        Get.find<AddressScreenController>()
                            .deleteAddress(address.id!);
                      }));
                },
                icon: const Icon(Icons.delete)))
      ],
    );
  }
}
