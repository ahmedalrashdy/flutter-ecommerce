import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_screen_controller.dart';
import '../../../data/models/address_model.dart';
import '../../../core/theme/app_theme.dart';

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
                      color: AppTheme.primaryColor,
                      size: 32.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address.address,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: AppTheme.textColor,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            address.city,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppTheme.greyTextColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'الاحداثيات: ${address.lat.toStringAsFixed(4)}, ${address.lang.toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppTheme.seconderTextColor,
                            ),
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
                          color: AppTheme.accentColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'الافتراضي',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
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
