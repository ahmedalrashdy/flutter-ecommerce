import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        'نسيت كلمة المرور؟',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
