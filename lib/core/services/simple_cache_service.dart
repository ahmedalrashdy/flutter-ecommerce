import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../errors/exceptions.dart';

// Abstract class defining the required methods
abstract class SimpleCacheService extends GetxService {
  T? get<T>(String key);
  Future<void> set<T>(String key, T value);
  Future<void> remove(String key);
  Future<void> clear();
}

class SharedPreferencesService extends SimpleCacheService {
  final SharedPreferences sharedPreferences;
  SharedPreferencesService({required this.sharedPreferences});

  @override
  void onInit() async {
    super.onInit();
    try {
      // يمكن إضافة أي عمليات تهيئة لاحقة هنا
    } catch (e) {
      throw CacheException(
        message: 'Failed to initialize storage',
      );
    }
  }

  @override
  T? get<T>(String key) {
    try {
      final dynamic value = sharedPreferences.get(key);

      if (value == null) return null;

      if (value is T) {
        return value as T;
      } else {
        throw CacheException(
          message:
              'Type mismatch for key: $key. Expected type: $T, found type: ${value.runtimeType}',
        );
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to read data for key: $key, error: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> set<T>(String key, T value) async {
    try {
      if (value is int) {
        await sharedPreferences.setInt(key, value);
      } else if (value is double) {
        await sharedPreferences.setDouble(key, value);
      } else if (value is bool) {
        await sharedPreferences.setBool(key, value);
      } else if (value is String) {
        await sharedPreferences.setString(key, value);
      } else if (value is List<String>) {
        await sharedPreferences.setStringList(key, value);
      } else {
        throw CacheException(
          message: 'Type mismatch error for key: $key',
        );
      }
    } catch (e) {
      throw CacheException(
        message: 'Failed to read data for key: $key, error:${e.toString()}',
      );
    }
  }

  @override
  Future<void> remove(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to read data for key: $key, error:${e.toString()}',
      );
    }
  }

  @override
  Future<void> clear() async {
    try {
      await sharedPreferences.clear();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear storage',
      );
    }
  }
}
