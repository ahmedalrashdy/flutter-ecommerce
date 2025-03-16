import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/errors/exception_handler.dart';
import 'package:super_ecommerce/main.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/constants/secure_storage_keys.dart';
import '../../../../core/constants/shared_preferences_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../models/auth_model.dart';

abstract class AuthRepository extends GetxService with ExceptionHandler {
  CustomResultAsync<AuthModel> login(String email, String password);
  CustomResultAsync<String> register(
      String email, String name, String password, String password2);
  CustomResultAsync<Unit> logout();
  CustomResultAsync<AuthModel?> getCachedUser();
  CustomResultAsync<Unit> saveAuthCredentials(AuthModel authModel);
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
  CustomResultAsync<String> register(
      String email, String name, String password, String password2) async {
    return handleExceptionAsync<String>(() async {
      final response = await apiService.post(
        ApiEndpoint.register,
        body: {
          "email": email,
          "name": name,
          "password": password,
          "password2": password2
        },
      );
      simpleCacheService.set(
          SharedPreferencesConstants.registerToken, response['token']);
      return Right(response['token']);
    });
  }

  CustomResultAsync<Unit> logout() async {
    return handleExceptionAsync<Unit>(() async {
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
}
