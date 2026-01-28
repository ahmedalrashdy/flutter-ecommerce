import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/screens/verify_otp_screen.dart';
import '../../../../core/classes/app_validator.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/enums/async_status.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/login_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_form_text_field.dart';
import '../widgets/forget_password.dart';
import '../widgets/login_register_prompt.dart';
import '../widgets/login_social_section.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: context.gradients.containerGradient,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        AuthHeader(
                          title: context.tr.login_title,
                          description: 'أهلاً بك مجدداً! سجل الدخول الآن',
                          assetPath: AppAssets.imagesLogo,
                          heroTag: 'logo',
                        ),
                        const SizedBox(height: 24),
                        CustomFormTextField(
                          controller: controller.emailController,
                          icon: Icons.email_outlined,
                          label: context.tr.common_emailLabel,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator.isEmail,
                        ),
                        const SizedBox(height: 16),
                        CustomFormTextField(
                          controller: controller.passwordController,
                          icon: Icons.lock_outline,
                          label: context.tr.common_passwordLabel,
                          obscureText: controller.obscurePassword,
                          hasPasswordToggle: true,
                          onTogglePassword: () {
                            setState(() {
                              controller.obscurePassword =
                                  !controller.obscurePassword;
                            });
                          },
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: ForgotPassword(),
                        ),
                        CustomButton(
                          title: context.tr.login_loginButton,
                          isLoading: controller.status == AsyncStatus.loading,
                          onPressed: controller.login,
                        ),
                        const SizedBox(height: 24),
                        const LoginSocialSection(),
                        const SizedBox(height: 24),
                        LoginRegisterPrompt(
                          promptText: context.tr.login_noAccountPrompt,
                          actionText: context.tr.login_signupLink,
                          onActionPressed: () => Get.off(
                            () => const RegisterScreen(),
                            transition: Transition.rightToLeft,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
