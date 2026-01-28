import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ecommerce/core/services/simple_cache_service.dart';

class LocaleController extends GetxController {
  final SimpleCacheService simpleCacheService = Get.find();
  final _key = 'locale';

  Locale? _appLocale;

  Locale get appLocale =>
      _appLocale ?? _getDeviceLocale() ?? const Locale('en');

  @override
  void onInit() {
    super.onInit();
    _loadLocaleFromStorage();
  }

  void _loadLocaleFromStorage() {
    String? storedLanguageCode = simpleCacheService.get<String?>(_key);
    if (storedLanguageCode != null) {
      _appLocale = Locale(storedLanguageCode);
    } else {
      _appLocale = _getDeviceLocale() ?? const Locale('en');
    }
  }

  Locale? _getDeviceLocale() {
    try {
      return Get.deviceLocale;
    } catch (e) {
      return null;
    }
  }

  Future<void> changeLocale(String languageCode) async {
    if (_appLocale?.languageCode == languageCode) return;

    _appLocale = Locale(languageCode);

    await simpleCacheService.set<String?>(_key, languageCode);

    Get.updateLocale(_appLocale!);
  }
}
