import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

import '../screens/forgot_password_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.to(
        () => const ForgotPasswordScreen(),
        transition: Transition.rightToLeft,
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(
        context.tr.auth_forgotPasswordTitle,
        style: TextStyle(
          color: context.darken(context.colors.secondary),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
