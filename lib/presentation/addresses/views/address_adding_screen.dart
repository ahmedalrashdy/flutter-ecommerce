import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/app_theme.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';
import 'package:super_ecommerce/presentation/addresses/getX/address_adding_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/custom_form_text_field.dart';

import '../widgets/map_widget.dart';

class AddressAddingScreen extends StatefulWidget {
  const AddressAddingScreen({super.key});

  @override
  State<AddressAddingScreen> createState() => _AddressAddingScreenState();
}

class _AddressAddingScreenState extends State<AddressAddingScreen> {
  bool _isMapTouched = false; // تعطيل التمرير أثناء لمس الخريطة
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final AddressAddingController controllerPage =
        Get.put(AddressAddingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "إضافة عنوان جديد",
          style: AppTextStyle.bold18.copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          _line(title: "حدد موقعك على الخريطة", icon: Icons.location_on),
          Container(
            height: 400,
            child: AbsorbPointer(
              absorbing: false,
              child: MapWidget(),
            ),
          ),
          _line(title: "تفاصيل الموقع"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Form(
              child: Column(
                children: [
                  CustomFormTextField(
                    controller: controllerPage.addressController,
                    label: "العنوان",
                    icon: Icons.location_on,
                    onChanged: (_) {
                      controllerPage.checkEnable();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomFormTextField(
                    controller: controllerPage.cityController,
                    label: "المدينة",
                    icon: Icons.location_city,
                    onChanged: (value) {
                      controllerPage.checkEnable();
                    },
                  ),
                  GetBuilder<AddressAddingController>(builder: (_) {
                    return SwitchListTile(
                      value: controllerPage.isDefault,
                      onChanged: controllerPage.switchDefault,
                      title: Text(
                        "العنوان الافتراضي",
                        style: AppTextStyle.regular16,
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  GetBuilder<AddressAddingController>(
                      id: "addingAddress",
                      builder: (controller) {
                        return CustomButton(
                          isLoading:
                              controller.addingStatus == AsyncStatus.loading,
                          title: "إضافة",
                          onPressed: controllerPage.isEnable
                              ? controllerPage.addAddress
                              : null,
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _line({required String title, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              if (icon != null) Icon(icon, color: AppTheme.primaryColor),
              const SizedBox(width: 5),
              Text(title, style: AppTextStyle.bold16),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
