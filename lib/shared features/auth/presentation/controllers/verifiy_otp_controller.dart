import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/constants/simple_cache_keys.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/dialogs/custom_confirm_dialog.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/errors/failures.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/core/services/simple_cache_service.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/auth_controller.dart';
import 'package:super_ecommerce/shared%20features/auth/data/models/auth_model.dart';
import 'package:super_ecommerce/shared%20features/auth/data/repository/auth_repository.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/reset_password_controller.dart';

class VerifyOtpController extends GetxController {
  AuthRepository authRepository = Get.find();

  int cooldownSeconds = 0;

  SimpleCacheService simpleCacheService = Get.find();

  VerifyOtpController({required this.email, this.isResetPassword = false});

  AsyncStatus status = AsyncStatus.idle;
  String email;

  bool isResetPassword;

  Future<void> verifyResetPasswordOTP(String otp) async {
    await handleCustomResultAsync<String>(
        setStatus: (s) => status = s,
        task: () => authRepository.verifyResetPasswordOTP(otp, email),
        onSuccess: (token) async {
          Get.find<ResetPasswordController>().resetToken = token;
          Get.toNamed(AppRoute.resetPassword);
        },
        onError: (Failure failure) {
          String message = failure.message;

          Get.dialog(CustomConfirmationDialog(
            title: "خطأ",
            isDestructive: true,
            content: message,
            onConfirm: () {},
            cancelText: "",
            confirmText: "حسناً",
          ));
        });
  }

  Future<void> verifyOTP(String otp) async {
    if (isResetPassword) {
      await verifyResetPasswordOTP(otp);
      return;
    }

    await handleCustomResultAsync<AuthModel>(
        setStatus: (s) => status = s,
        task: () => authRepository.verifyEmail(otp),
        onSuccess: (auth) async {
          await Get.find<AuthController>().saveAuthCredentials(auth);
          await Get.find<SimpleCacheService>()
              .remove(SharedPreferencesConstants.registerEmail);
          Get.offAllNamed(AppRoute.mainScreen);
        },
        onError: (Failure failure) {
          String message = failure.message;
          print(failure);
          Get.dialog(CustomConfirmationDialog(
            title: "خطأ",
            isDestructive: true,
            content: message,
            onConfirm: () {},
            cancelText: "",
            confirmText: "حسناً",
          ));
        });
  }

  AsyncStatus resendStatus = AsyncStatus.idle;

  Future<void> resendOTP() async {
    await handleCustomResultAsync(
        setStatus: (s) => resendStatus = s,
        task: () => authRepository.resendOTP(email),
        onSuccess: (token) {
          AppMessage.showInfo(
              message: "تم إعاده ارسال رمز التحقق الى بريدك الإلكتروني ");
        },
        onError: (failure) {
          if (failure is TooManyRequestFailure) {
            if (failure.messages.containsKey("error")) {
              AppMessage.showError(message: failure.messages['error']);
            }
            if (failure.messages.containsKey("waiting_seconds")) {
              cooldownSeconds = failure.messages['waiting_seconds'];
            }
          }
        });
  }

  Future<void> back() async {
    if (isResetPassword) {
      Get.back();
      return;
    }
    Get.until((route) => route.settings.name == AppRoute.registerScreen);
    Get.find<SimpleCacheService>()
        .remove(SharedPreferencesConstants.registerEmail);
  }
}
