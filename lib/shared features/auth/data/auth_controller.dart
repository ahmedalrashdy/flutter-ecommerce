import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/constants/shared_preferences_constants.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/shared%20features/auth/data/models/auth_model.dart';
import 'package:super_ecommerce/shared%20features/auth/data/repository/auth_repository.dart';
import '../../../core/constants/secure_storage_keys.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/services/shared_preferences_service.dart';

class AuthController extends GetxController {
  bool get isAuth => authModel != null;
  AuthModel? authModel;
  SimpleCacheService simpleCacheService = Get.find<SimpleCacheService>();
  final secStorage = Get.find<SecureStorageService>();
  final AuthRepository authRepository = Get.find();

  Future<AuthController> init() async {
    await getCachedUser();
    if (authModel != null) {
      Get.find<ApiService>().setAuthToken(authModel!.accessToken);
    }
    return this;
  }

  Future<void> getCachedUser() async {
    await handleCustomResultAsync<AuthModel?>(
        task: () => authRepository.getCachedUser(),
        onSuccess: (authModel) => this.authModel = authModel);
  }

  Future<void> saveAuthCredentials(AuthModel auth) async {
    authModel = auth;
    await handleCustomResultAsync<Unit>(
        task: () => authRepository.saveAuthCredentials(auth),
        onSuccess: (_) {});
  }

  Future<void> logout() async {
    final result = await authRepository.logout();
    result.fold((failure) {
      AppMessage.showError(message: failure.message);
    }, (_) {
      authModel = null;
    });
  }
}
