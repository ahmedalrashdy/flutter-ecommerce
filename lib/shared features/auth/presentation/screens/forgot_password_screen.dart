import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/classes/app_validator.dart';
import 'package:super_ecommerce/core/constants/app_text_style.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/core/widgets/custom_button.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/reset_password_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/login_screen.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/custom_form_text_field.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/reset_password_header.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  late ResetPasswordController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ResetPasswordController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ResetPasswordController>(
        id: 'sendEmail',
        builder: (controllder) {
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ResetPasswordHeader(
                            title: context.tr.auth_forgotPasswordTitle,
                            subTitle:
                                context.tr.resetPassword_requestInstruction),
                        const SizedBox(height: 32),
                        CustomFormTextField(
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          label: context.tr.common_emailLabel,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator.isEmail,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          title: context.tr.common_next,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller
                                  .resetPasswordRequest(_emailController.text);
                            }
                          },
                          isLoading: controllder.sendEmailStatus ==
                              AsyncStatus.loading,
                        ),
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () => Get.back(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: context.colors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                context.tr.resetPassword_backToLoginLink,
                                style: context.appTextTheme.regular16
                                    .copyWith(color: context.colors.primary),
                              ),
                            ],
                          ),
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
