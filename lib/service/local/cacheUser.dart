import 'package:firebase_auth/firebase_auth.dart';
import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/user_service.dart';

class CacheUser {
  static CacheUser? _instance;

  static CacheUser get instance => _instance ??= CacheUser._();

  CacheUser._();

  static UserModel? _userModel;

  Future<UserModel?> userModel() async {
    if (_userModel == null) {
      _userModel = await _initUser();
      return _userModel;
    } else {
      return _userModel;
    }
  }

  Future<UserModel?> _initUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    print(id);
    UserModel? result = await UserService.instance.getUser(id: id);

    print(result?.firstName);
    return result;
  }

  void updateCahce({UserModel? userModel}) {
    _userModel = userModel;
  }

  void deleteCahce() {
    _userModel = null;
  }
}
