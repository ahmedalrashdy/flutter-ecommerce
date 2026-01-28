import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/classes/app_validator.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/reset_password_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/custom_form_text_field.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/reset_password_header.dart';

import '../widgets/otp_input.dart';
import '../widgets/resend_otp_timer.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ResetPasswordController>(
        id: "confirmResetPassword",
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              gradient: context.gradients.containerGradient,
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const ResetPasswordHeader(
                            title: 'تعيين كلمة المرور الجديدة',
                            subTitle: 'الرجاء إدخال كلمة المرور الجديدة'),
                        const SizedBox(height: 32),
                        CustomFormTextField(
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          label: 'كلمة المرور الجديدة',
                          obscureText: _obscurePassword,
                          hasPasswordToggle: true,
                          validator: AppValidator.isValidPassword,
                        ),
                        const SizedBox(height: 16),
                        CustomFormTextField(
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outline,
                          label: 'تأكيد كلمة المرور',
                          obscureText: _obscureConfirmPassword,
                          hasPasswordToggle: true,
                          validator: (value) {
                            return AppValidator.isPasswordMatched(
                                value, _confirmPasswordController.text);
                          },
                        ),
                        const SizedBox(height: 32),
                        CustomButton(
                          title: "إعاده تعيين كلمة المرور",
                          isLoading: controller.confirmResetStatus ==
                              AsyncStatus.loading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.confirmResetPassword(
                                  _passwordController.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
