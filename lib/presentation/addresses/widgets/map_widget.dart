import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/enums/async_status.dart';
import '../../../core/widgets/custom_ message.dart';
import '../getX/address_adding_controller.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: GetBuilder<AddressAddingController>(builder: (controllerPage) {
        if (controllerPage.status == AsyncStatus.idle) {
          return SizedBox();
        }
        if (controllerPage.status == AsyncStatus.loading) {
          return Center(
            child: LottieBuilder.asset(AppAssets.lottieLoading),
          );
        }
        if (controllerPage.status == AsyncStatus.failure ||
            controllerPage.cameraPosition == null) {
          return const Center(
            child: CustomMessage(
                icon: Icons.location_city_outlined,
                title:
                    "حدث خطأ ما الرجاء التأكد من منح التطبيق صلاحيات الوصول الى الموقع"),
          );
        }
        return Stack(
          children: [
            GoogleMap(
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: controllerPage.cameraPosition!,
              onTap: controllerPage.addMarker,
              markers: controllerPage.markers,
              onMapCreated: (GoogleMapController controller) {
                controllerPage.mapController.complete(controller);
              },
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
            ),
          ],
        );
      }),
    );
  }
}
