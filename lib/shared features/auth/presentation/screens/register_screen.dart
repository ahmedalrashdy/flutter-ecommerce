import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';

import '../../../../core/classes/app_validator.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/enums/async_status.dart';
import '../../../../core/widgets/custom_button.dart';
import '../controllers/register_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_form_text_field.dart';
import '../widgets/login_register_prompt.dart';
import '../widgets/login_social_section.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    RegisterController controller = Get.put(RegisterController());
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (controler) {
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
                        const SizedBox(height: 20),
                        AuthHeader(
                          title: context.tr.signup_title,
                          description: 'انضم إلينا واستمتع بتجربة تسوق مميزة',
                          assetPath: AppAssets
                              .imagesLogo, // Replace with your image path
                          heroTag: 'logo',
                        ),
                        const SizedBox(height: 30),
                        CustomFormTextField(
                          controller: controller.nameController,
                          icon: Icons.person_outline,
                          label: context.tr.common_fullNameLabel,
                          validator: AppValidator.isRequired,
                          errorMessage: controler.validationErrors["name"],
                        ),
                        const SizedBox(height: 16),
                        CustomFormTextField(
                          controller: controller.emailController,
                          icon: Icons.email_outlined,
                          label: context.tr.common_emailLabel,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator.isEmail,
                          errorMessage: controler.validationErrors["email"],
                        ),
                        const SizedBox(height: 16),
                        CustomFormTextField(
                            controller: controller.passwordController,
                            icon: Icons.lock_outline,
                            label: context.tr.common_passwordLabel,
                            obscureText: controller.obscurePassword,
                            errorMessage:
                                controller.validationErrors["password"],
                            hasPasswordToggle: true,
                            onTogglePassword: () {
                              setState(() {
                                controller.obscurePassword =
                                    !controller.obscurePassword;
                              });
                            },
                            validator: AppValidator.isValidPassword),
                        const SizedBox(height: 16),
                        CustomFormTextField(
                          controller: controller.passwordConfirmationController,
                          icon: Icons.lock_outline,
                          label: context.tr.common_confirmPasswordLabel,
                          obscureText: controller.obscureConfirmPassword,
                          errorMessage:
                              controller.validationErrors["password2"],
                          hasPasswordToggle: true,
                          onTogglePassword: () {
                            setState(() {
                              controller.obscureConfirmPassword =
                                  !controller.obscureConfirmPassword;
                            });
                          },
                          validator: (value) => AppValidator.isPasswordMatched(
                              value, controler.passwordController.text),
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          title: context.tr.login_loginButton,
                          isLoading: controler.status == AsyncStatus.loading,
                          onPressed: controler.register,
                        ),
                        const SizedBox(height: 24),
                        const LoginSocialSection(),
                        const SizedBox(height: 24),
                        LoginRegisterPrompt(
                          actionText: context.tr.signup_loginLink,
                          promptText: context.tr.signup_haveAccountPrompt,
                          onActionPressed: () => Get.off(
                            () => const LoginScreen(),
                            transition: Transition.rightToLeft,
                          ),
                        ),
                        const SizedBox(height: 20),
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
