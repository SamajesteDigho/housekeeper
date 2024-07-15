import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  /// Methods caller or getter
  static StorageService get to => Get.find();
  late final SharedPreferences _prefs;

  /// Initialize the preferences
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Setting a string value in the Storage
  Future<bool> setString({required String key, required String value}) async {
    return await _prefs.setString(key, value);
  }

  /// Setting a boolean value in the storage
  Future<bool> setBool({required String key, required bool value}) async {
    return await _prefs.setBool(key, value);
  }

  /// Setting a list value in the storage
  Future<bool> setList({required String key, required List<String> value}) async {
    return await _prefs.setStringList(key, value);
  }

  /// Getting a string with a given key from storage
  String getString({required String key}) {
    return _prefs.getString(key) ?? '';
  }

  /// Getting a bool with a given key from storage
  bool getBool({required String key}) {
    return _prefs.getBool(key) ?? false;
  }

  /// Getting a list of Strings with a given key from storage
  List<String> getList({required String key}) {
    return _prefs.getStringList(key) ?? [];
  }

  Future<bool> remove({required String key}) async {
    return await _prefs.remove(key);
  }
}
