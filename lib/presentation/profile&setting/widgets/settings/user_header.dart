import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/auth_controller.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: context.colors.primary.withOpacity(0.2),
                width: 2,
              ),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://ui-avatars.com/api/?name=John+Doe&background=random'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.authModel!.user.name ?? "Unknown",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.authModel!.user.email,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              color: context.colors.primary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
