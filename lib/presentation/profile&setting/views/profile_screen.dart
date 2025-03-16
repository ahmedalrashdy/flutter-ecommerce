import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/presentation/profile&setting/widgets/profile/ActionItem.dart';
import 'package:super_ecommerce/presentation/profile&setting/widgets/profile/profile_app_bar.dart';
import 'settings_screen.dart';
import '../../orders/views/orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          const ProfileAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              ActionItem(
                icon: Icons.settings,
                title: 'الإعدادات',
                subtitle: 'ضبط تفضيلات الحساب وإعدادات المتجر',
                color: Colors.purple,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
              _buildDivider(),
              ActionItem(
                  icon: Icons.shopping_bag_outlined,
                  title: 'طلباتي',
                  subtitle: 'عرض وتتبع طلباتك',
                  color: Colors.orange,
                  onTap: () => Get.toNamed(AppRoute.orderScreen)),
              _buildDivider(),
              ActionItem(
                icon: Icons.location_on_outlined,
                title: 'عناوين الشحن',
                subtitle: 'إدارة عناوين التوصيل',
                color: Colors.green,
                onTap: () {
                  Get.toNamed(AppRoute.addressScreen);
                },
              ),
              _buildDivider(),
              _buildDivider(),
              ActionItem(
                icon: Icons.help_outline,
                title: 'الدعم والمساعدة',
                subtitle: 'تواصل مع خدمة العملاء',
                color: Colors.red,
                onTap: () {
                  Get.dialog(CustomConfirmationDialog(
                      title: "قيد العمل",
                      content: "لم يتم  اكمال العمل على هذا الجزء بعد",
                      onConfirm: () {}));
                },
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }
}
