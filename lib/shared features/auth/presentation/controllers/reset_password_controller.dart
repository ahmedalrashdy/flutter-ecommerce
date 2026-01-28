import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/shared%20features/auth/data/repository/auth_repository.dart';
import 'package:super_ecommerce/shared%20features/auth/presentation/controllers/login_controller.dart';

import '../../../../core/constants/app_routes.dart';

class ResetPasswordController extends GetxController {
  AsyncStatus sendEmailStatus = AsyncStatus.idle;

  AsyncStatus resetStatus = AsyncStatus.idle;

  AuthRepository authRepository = Get.find();
  String email = "";
  String resetToken = "";

  int cooldownSeconds = 0;

  Future<void> resetPasswordRequest(String email) async {
    this.email = email;
    sendEmailStatus = AsyncStatus.loading;
    update(['sendEmail']);
    await Future.delayed(Duration(seconds: 2));

    await handleCustomResultAsync<Unit>(
        setStatus: (s) => sendEmailStatus = s,
        task: () => authRepository.resetPassword(email),
        onSuccess: (p0) {
          Get.toNamed(AppRoute.verifyOtpScreen,
              arguments: {"email": email, "isResetPassword": true});
        },
        onError: (failure) {
          AppMessage.showError(message: failure.message);
        },
        updateIds: ['sendEmail']);
  }

  AsyncStatus confirmResetStatus = AsyncStatus.idle;
  Future<void> confirmResetPassword(String newPassword) async {
    confirmResetStatus = AsyncStatus.loading;
    update(['confirmResetPassword']);
    await Future.delayed(Duration(seconds: 2));

    await handleCustomResultAsync<Unit>(
        setStatus: (s) => confirmResetStatus = s,
        task: () =>
            authRepository.confirmResetPassword(newPassword, resetToken),
        onSuccess: (_) {
          Get.until((route) => route.settings.name == AppRoute.loginScreen);
        },
        onError: (failure) {
          AppMessage.showError(message: failure.message);
        },
        updateIds: ['confirmResetPassword']);
  }
}
