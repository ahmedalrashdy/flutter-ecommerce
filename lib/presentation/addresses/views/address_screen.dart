import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/widgets/simple_app_bar.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_screen_controller.dart';

import '../widgets/address_list.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressScreenController controller = Get.put(AddressScreenController());
    final appBar = SimpleAppBar(title: "عناوين الشحن");

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
