import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/dialogs/app_message.dart';
import 'package:super_ecommerce/core/functions/perform_async_operation.dart';
import 'package:super_ecommerce/core/services/api_service.dart';
import 'package:super_ecommerce/shared%20features/auth/data/models/auth_model.dart';
import 'package:super_ecommerce/shared%20features/auth/data/repository/auth_repository.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/simple_cache_service.dart';

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
    Get.find<ApiService>().setAuthToken(auth.accessToken);
    await handleCustomResultAsync<Unit>(
        task: () => authRepository.saveAuthCredentials(auth),
        onSuccess: (_) {});
  }

  Future<bool> logout() async {
    bool result = false;
    await handleCustomResultAsync<Unit>(
        task: () => authRepository.logout(authModel!.refreshToken),
        onError: (failure) {
          AppMessage.showError(message: failure.message);
        },
        onSuccess: (_) {
          result = true;
          Get.find<ApiService>().removeAuthToken();
          authModel = null;
        });
    return result;
  }
}
