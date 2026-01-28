import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/enums/async_status.dart';
import '../../../core/widgets/custom_ message.dart';
import '../getX/address_screen_controller.dart';
import 'address_tile.dart';

class AddressList extends StatelessWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressScreenController>(builder: (controller) {
      if ((controller.status == AsyncStatus.loading)) {
        return Center(
          child: LottieBuilder.asset(AppAssets.lottieLoading),
        );
      }
      if (controller.addresses.isEmpty) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: const CustomMessage(
                icon: Icons.location_city_outlined,
                title: "لا توجد بيانات اضف عناوين شحن الان"),
          ),
        );
      }

      return ListView.builder(
          itemCount: controller.addresses.length,
          itemBuilder: (ctx, index) {
            return AddressListTile(address: controller.addresses[index]);
          });
    });
  }
}
