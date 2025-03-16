import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import '../../../../core/constants/app_routes.dart';
import '../../data/auth_controller.dart';
import '../../../../core/dialogs/app_message.dart';
import '../../../../core/enums/async_status.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/auth_model.dart';
import '../../data/repository/auth_repository.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  AsyncStatus status = AsyncStatus.idle;
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      await handleCustomResultAsync(
          setStatus: (s) => status = s,
          task: () => authRepository.login(
              emailController.text, passwordController.text),
          onSuccess: (authModel) async {
            status = AsyncStatus.success;
            await Get.find<AuthController>().saveAuthCredentials(authModel);
            Get.offAllNamed(AppRoute.mainScreen);
          },
          onError: (failure) {
            if (failure is ValidationFailure) {
              if (failure.messages["error"] != null) {
                AppMessage.showError(message: failure.messages["error"]);
              }
            } else {
              AppMessage.showError(message: failure.message);
            }
          });
    }
  }
}
