import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/extensions/context_extensions.dart';
import 'package:super_ecommerce/core/theme/extensions/theme_extensions.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/verifiy_otp_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/widgets/resend_otp_timer.dart';
import '../widgets/otp_input.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});
  final VerifyOtpController controller = Get.put(VerifyOtpController(
      email: Get.arguments['email'],
      isResetPassword: Get.arguments['isResetPassword'] ?? false));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        decoration: BoxDecoration(
          gradient: context.gradients.containerGradient,
        ),
        child: GetBuilder<VerifyOtpController>(builder: (controller) {
          return ModalProgressHUD(
            inAsyncCall: controller.status == AsyncStatus.loading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.email_outlined,
                          size: 50,
                          color: context.darken(context.colors.primary),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        'التحقق من البريد الإلكتروني',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: context.darken(context.colors.primary)),
                      ),
                      const SizedBox(height: 16),
                      // Subtitle
                      Text(
                        context.tr.otp_instruction(controller.email),
                        style: context.appTextTheme.regular16
                            .copyWith(color: context.colors.onSurface),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),
                      // OTP Input
                      const OTPInput(),
                      const SizedBox(height: 40),
                      // Timer Container
                      ResendOtpTimer(
                          cooldownSeconds: controller.cooldownSeconds,
                          onResend: controller.resendOTP,
                          status: controller.resendStatus),
                      const SizedBox(height: 16),
                      // Back Button
                      TextButton.icon(
                        onPressed: controller.back,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        label: Text(
                          'تغيير البريد الإلكتروني',
                          style: context.appTextTheme.bold16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
