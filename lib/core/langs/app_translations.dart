import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  Map<String, Map<String, String>> translations = {};

  AppTranslations() {
    _loadTranslations();
  }

  Future<void> _loadTranslations() async {
    translations['en'] = await _loadJsonFile('assets/langs/en.json');
    translations['ar'] = await _loadJsonFile('assets/langs/ar.json');
  }

  Future<Map<String, String>> _loadJsonFile(String path) async {
    String jsonString = await rootBundle.loadString(path);
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
