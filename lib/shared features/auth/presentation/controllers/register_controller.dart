import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/app_routes.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/enums/async_status.dart';
import 'package:super_ecommerce/core/errors/failures.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/shared%20features/auth/data/repository/auth_repository.dart';

class RegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  AsyncStatus status = AsyncStatus.idle;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  AuthRepository authRepository = Get.find();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    animationController.forward();
  }

  Map<String, String> validationErrors = {};

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      validationErrors.clear();
      await handleCustomResultAsync<Unit>(
          setStatus: (s) => status = s,
          task: () => authRepository.register(
                emailController.text,
                nameController.text,
                passwordController.text,
              ),
          onSuccess: (_) {
            Get.toNamed(AppRoute.verifyOtpScreen, arguments: {
              "email": emailController.text,
            });
          },
          onError: (failure) {
            if (failure is ValidationFailure) {
              for (var entry in failure.messages.entries) {
                validationErrors[entry.key] =
                    entry.value is List ? entry.value[0] : entry.value;
              }
            } else {
              AppMessage.showError(message: failure.message);
            }
          });
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
