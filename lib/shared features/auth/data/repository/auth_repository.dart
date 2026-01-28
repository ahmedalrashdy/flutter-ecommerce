import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/main.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/secure_storage_keys.dart';
import '../../../../core/constants/simple_cache_keys.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/simple_cache_service.dart';
import '../models/auth_model.dart';

abstract class AuthRepository extends GetxService with ExceptionHandler {
  CustomResultAsync<AuthModel> login(String email, String password);
  CustomResultAsync<Unit> logout(String refreshToken);

  CustomResultAsync<Unit> register(String email, String name, String password);
  CustomResultAsync<AuthModel> verifyEmail(String otp);
  CustomResultAsync<String> verifyResetPasswordOTP(String otp, String email);

  CustomResultAsync<AuthModel?> getCachedUser();
  CustomResultAsync<Unit> saveAuthCredentials(AuthModel authModel);

  CustomResultAsync<Unit> changePassword(
      String oldPassword, String newPassword);
  CustomResultAsync<Unit> resetPassword(String email);

  CustomResultAsync<Unit> confirmResetPassword(
      String newPassword, String resetToken);
  CustomResultAsync<Unit> resendOTP(String email);
}

class AuthRepositoryImp extends AuthRepository {
  final SimpleCacheService simpleCacheService;
  final SecureStorageService secStorage;
  final ApiService apiService;
  AuthRepositoryImp(
      {required this.apiService,
      required this.secStorage,
      required this.simpleCacheService});
  @override
  CustomResultAsync<AuthModel> login(String email, String password) async {
    return handleExceptionAsync<AuthModel>(() async {
      final response = await apiService.post(
        ApiEndpoint.login,
        body: {"email": email, "password": password},
      );
      return Right(AuthModel.fromMap(response));
    });
  }

  @override
  CustomResultAsync<Unit> register(
      String email, String name, String password) async {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(
        ApiEndpoint.register,
        body: {"email": email, "name": name, "password": password},
      );

      await simpleCacheService.set(
          SharedPreferencesConstants.registerEmail, email);
      return Right(unit);
    });
  }

  CustomResultAsync<Unit> logout(String refreshToken) async {
    return handleExceptionAsync<Unit>(() async {
      await apiService
          .post(ApiEndpoint.logout, body: {"refresh_token": refreshToken});
      await secStorage.delete(key: SecureStorageKeys.accessToken);
      await secStorage.delete(key: SecureStorageKeys.refreshToken);
      await simpleCacheService.remove(SharedPreferencesConstants.user);
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<AuthModel?> getCachedUser() async {
    return handleExceptionAsync<AuthModel?>(() async {
      String? accessToken =
          await secStorage.read(key: SecureStorageKeys.accessToken);
      String? refreshToken =
          await secStorage.read(key: SecureStorageKeys.refreshToken);
      String? user =
          simpleCacheService.get<String?>(SharedPreferencesConstants.user);

      if (accessToken != null && refreshToken != null && user != null) {
        return Right(AuthModel.fromMap({
          SecureStorageKeys.accessToken: accessToken,
          SecureStorageKeys.refreshToken: refreshToken,
          "user": jsonDecode(user)
        }));
      }
      return const Right(null);
    });
  }

  CustomResultAsync<Unit> saveAuthCredentials(AuthModel authModel) async {
    return await handleExceptionAsync<Unit>(() async {
      await secStorage.write(
          key: SecureStorageKeys.accessToken, value: authModel.accessToken);
      await secStorage.write(
          key: SecureStorageKeys.refreshToken, value: authModel.refreshToken);

      await simpleCacheService.set<String>(
          SharedPreferencesConstants.user, jsonEncode(authModel.user.toJson()));
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<AuthModel> verifyEmail(String otp) async {
    return handleExceptionAsync<AuthModel>(() async {
      final data = await apiService.post(ApiEndpoint.verifyEmail, body: {
        "email": simpleCacheService
            .get<String?>(SharedPreferencesConstants.registerEmail),
        "otp": otp
      });
      return Right(AuthModel.fromMap(data));
    });
  }

  @override
  CustomResultAsync<Unit> resendOTP(String email) {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.resendOTP, body: {"email": email});
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<Unit> changePassword(
      String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  CustomResultAsync<Unit> resetPassword(String email) {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.resetPassword, body: {"email": email});
      return const Right(unit);
    });
  }

  @override
  CustomResultAsync<String> verifyResetPasswordOTP(String otp, String email) {
    return handleExceptionAsync<String>(() async {
      final data = await apiService.post(ApiEndpoint.verifyResetPasswordOTP,
          body: {"email": email, "otp": otp});
      return Right(data['reset_token']);
    });
  }

  @override
  CustomResultAsync<Unit> confirmResetPassword(
      String newPassword, String resetToken) async {
    return handleExceptionAsync<Unit>(() async {
      await apiService.post(ApiEndpoint.confirmResetPassword,
          body: {"reset_token": resetToken, "new_password": newPassword});
      return const Right(unit);
    });
  }
}
