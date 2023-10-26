import 'package:vistorapp/service/local/shared_preferences_service.dart';

class TypeOfUserLogin {
  static TypeOfUserLogin? _instance;
  TypeOfUserLogin._();
  SharedPreferencesService _sharedPrefs = SharedPreferencesService.instance;

  static TypeOfUserLogin get instance => _instance ??= TypeOfUserLogin._();

  Future<bool> setGuest() async {
    return await _sharedPrefs.setCommon<String>("typeOfUser", "guest");
  }

  Future<bool> setUser() async {
    return await _sharedPrefs.setCommon<String>("typeOfUser", "user");
  }

  Future<bool> setAdmin() async {
    return await _sharedPrefs.setCommon<String>("typeOfUser", "admin");
  }

  bool isAdmin() {
    return _sharedPrefs.getCommon<String>("typeOfUser") == "admin"
        ? true
        : false;
  }

  String? getCurrentUser() {
    return _sharedPrefs.getCommon<String>("typeOfUser");
  }

  Future<bool> setOpenTheApp() async {
    return await _sharedPrefs.setCommon<bool>("isFirst", false);
  }

  Future<bool> removeCurrentUser() async {
    return await _sharedPrefs.removeTheKey("typeOfUser");
  }

  bool isGuset() {
    return getCurrentUser() == "guest" ? true : false;
  }

  bool isFirstOpenTheApp() {
    return _sharedPrefs.getCommon<bool>("isFirst") == null ||
            _sharedPrefs.getCommon<bool>("isFirst") == true
        ? true
        : false;
  }
}
