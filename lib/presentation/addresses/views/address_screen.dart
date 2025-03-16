import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:super_ecommerce/core/constants/app_assets.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/core/widgets/custom_%20message.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_screen_controller.dart';

import '../widgets/address_list.dart';
import '../widgets/address_tile.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressScreenController controller = Get.put(AddressScreenController());
    final appBar = AppBar(
      backgroundColor: AppTheme.primaryColor,
      title: Text(
        "عناوين الشحن",
        style: AppTextStyle.bold16,
      ),
    );
    double bodyHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    return Scaffold(
      appBar: appBar,
      body: AddressList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final fetchAddresses =
              await Get.toNamed(AppRoute.addressAddingScreen);
          if (fetchAddresses == true) {
            controller.getAllAddresses();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
