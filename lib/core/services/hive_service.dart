import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:super_ecommerce/core/constants/hive_boxes.dart';
import 'package:super_ecommerce/data/adapters/product_adapter.dart';
import '../../data/models/product_model.dart';
import '../errors/exceptions.dart';

class HiveService extends GetxService {
  final Map<String, BoxService> boxes = {};

  /// Initialize Hive and register adapters
  Future<HiveService> init() async {
    try {
      await Hive.initFlutter();
      //adapters
      Hive.registerAdapter(ProductModelAdapter());

      //open boxes
      await openBox<ProductModel>(HiveBoxes.favorites);
    } on CacheException catch (e) {
      log(e.message);
    } catch (e) {
      throw CustomException(
        message: 'Failed to initialize Hive: ${e.toString()}',
      );
    }
    return this;
  }

  /// Open a box with the given name
  Future<BoxService> openBox<T>(String boxName) async {
    if (boxes.containsKey(boxName)) {
      return boxes[boxName]!;
    }
    try {
      final box = await Hive.openBox<T>(boxName);

      boxes[boxName] =
          BoxService<T>(box: box, boxName: boxName, hiveService: this);
      return boxes[boxName]!;
    } catch (e) {
      if (kDebugMode) {
        print('Error opening box $boxName: $e');
      }
      throw CacheException(
        message: 'Failed to open box $boxName: ${e.toString()}',
      );
    }
  }

  /// Get an already opened box
  BoxService? getBox(String boxName) {
    if (!boxes.containsKey(boxName)) {
      throw CacheException(
        message: 'Box $boxName is not opened. Call openBox() first.',
      );
    }
    return boxes[boxName];
  }
}

class BoxService<T> {
  final Box<T> box;
  final String boxName;
  final HiveService hiveService;
  const BoxService(
      {required this.box, required this.boxName, required this.hiveService});

  /// Close a specific box
  Future<void> closeBox() async {
    try {
      await box.close();
      hiveService.boxes.remove(boxName);
    } catch (e) {
      throw CacheException(
        message: 'Failed to close box $boxName: ${e.toString()}',
      );
    }
  }

  /// Delete a box from disk
  Future<void> deleteBox() async {
    try {
      await box.close();
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete box $boxName: ${e.toString()}',
      );
    }
  }

  /// Clear all data in a box
  Future<void> clearBox() async {
    try {
      await box.clear();
    } catch (e) {
      throw CacheException(
        message: 'Failed to clear box $boxName: ${e.toString()}',
      );
    }
  }

  /// Put data in a box
  Future<void> put(String key, T value) async {
    try {
      await box.put(key, value);
    } catch (e) {
      throw CacheException(
        message: 'Failed to put data in box $boxName: ${e.toString()}',
      );
    }
  }

  /// Get data from a box
  T? get(String key, {T? defaultValue}) {
    try {
      final value = box.get(key, defaultValue: defaultValue);
      if (value == null) {
        throw CacheException(
          message: 'Type mismatch: Expected $T but got ${value.runtimeType}',
        );
      }
      return value;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get data from box $boxName: ${e.toString()}',
      );
    }
  }

  /// Delete data from a box
  Future<void> delete(String key) async {
    try {
      await box.delete(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to delete data from box $boxName: ${e.toString()}',
      );
    }
  }

  /// Watch changes in a box
  Stream<BoxEvent> watch({String? key}) async* {
    try {
      yield* box.watch(key: key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to watch box $boxName: ${e.toString()}',
      );
    }
  }

  /// Check if a key exists in a box
  Future<bool> contains(String key) async {
    try {
      return box.containsKey(key);
    } catch (e) {
      throw CacheException(
        message: 'Failed to check key in box $boxName: ${e.toString()}',
      );
    }
  }

  /// Put multiple items in a box
  Future<void> putAll(Map<String, T> entries) async {
    try {
      await box.putAll(entries);
    } catch (e) {
      throw CacheException(
        message:
            'Failed to put multiple items in box $boxName: ${e.toString()}',
      );
    }
  }

  Map<String, T> getAll() {
    try {
      return Map<String, T>.from(box.toMap().map((key, value) {
        return MapEntry(key.toString(), value);
      }));
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get all items from box $boxName: ${e.toString()}',
      );
    }
  }

  dynamic getAllAsList() {
    try {
      return box.values.toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException(
        message: 'Failed to get all items from box $boxName: ${e.toString()}',
      );
    }
  }
}
