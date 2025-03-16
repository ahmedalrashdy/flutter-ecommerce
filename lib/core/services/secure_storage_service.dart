import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/errors/exceptions.dart';

abstract class SecureStorageService extends GetxService {
  Future<void> write({
    required String key,
    required String value,
  });

  Future<String?> read({
    required String key,
  });

  Future<void> delete({
    required String key,
  });

  Future<void> deleteAll();

  Future<bool> containsKey({
    required String key,
  });

  Future<Map<String, String>> readAll();
}

class SecureStorageServiceImplWithSecureStorage extends SecureStorageService {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await storage.write(key: key, value: value);
    } catch (e) {
      throw CacheException(
          message: 'Failed to write data for key: $key, error:${e.toString()}');
    }
  }

  Future<String?> read({
    required String key,
  }) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      throw CacheException(
          message: 'Failed to read data for key: $key, error:${e.toString()}');
    }
  }

  Future<void> delete({
    required String key,
  }) async {
    try {
      await storage.delete(key: key);
    } catch (e) {
      throw CacheException(
          message:
              'Failed to delete data for key: $key, error:${e.toString()}');
    }
  }

  Future<void> deleteAll() async {
    try {
      await storage.deleteAll();
    } catch (e) {
      throw CacheException(
          message: 'Failed to delete all data , error:${e.toString()}');
    }
  }

  Future<bool> containsKey({
    required String key,
  }) async {
    try {
      return await storage.containsKey(key: key);
    } catch (e) {
      throw CacheException(
          message:
              'Failed to search if key:($key) exists or not, error:${e.toString()}');
    }
  }

  Future<Map<String, String>> readAll() async {
    try {
      return await storage.readAll();
    } catch (e) {
      throw CacheException(
          message: 'Failed to read all data , error:${e.toString()}');
    }
  }
}
