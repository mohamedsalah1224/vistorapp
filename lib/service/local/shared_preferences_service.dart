import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _sharedPrefs;
  SharedPreferencesService._();
  static SharedPreferencesService get instance =>
      _instance ??= SharedPreferencesService._();

  Future<void> initSharedPreferences() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  /// Reads the value for the key from common preferences storage
  T? getCommon<T>(String key) {
    try {
      switch (T) {
        case String:
          return _sharedPrefs!.getString(key) as T?;
        case int:
          return _sharedPrefs!.getInt(key) as T?;
        case bool:
          return _sharedPrefs!.getBool(key) as T?;
        case double:
          return _sharedPrefs!.getDouble(key) as T?;
        default:
          return _sharedPrefs!.get(key) as T?;
      }
    } on Exception {
      return null;
    }
  }

  /// Sets the value for the key to common preferences storage
  Future<bool> setCommon<T>(String key, T value) {
    switch (T) {
      case String:
        return _sharedPrefs!.setString(key, value as String);
      case int:
        return _sharedPrefs!.setInt(key, value as int);
      case bool:
        return _sharedPrefs!.setBool(key, value as bool);
      case double:
        return _sharedPrefs!.setDouble(key, value as double);
      default:
        return _sharedPrefs!.setString(key, value as String);
    }
  }

  Future<bool> removeTheKey(String key) async {
    try {
      return await _sharedPrefs!.remove(key);
    } on Exception {
      return false;
    }
  }

  /// Erases common preferences keys
  Future<bool> clearCommon() => _sharedPrefs!.clear();

  void clear() {
    _instance = null;
  }
}
