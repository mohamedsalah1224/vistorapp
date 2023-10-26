import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../model/user_model.dart';
import '../../file_store/user_service.dart';

class CacheUserHive {
  static CacheUserHive? _instance;
  static CacheUserHive get instance => _instance ??= CacheUserHive._();
  CacheUserHive._();

  late Box<UserModel> myBox;

  Future<void> init() async {
    myBox = await Hive.openBox<UserModel>("cacheUser");
    myBox = Hive.box<UserModel>("cacheUser");
  }

  Future<void> addUser() async {
    UserModel? result = await UserService.instance
        .getUser(id: FirebaseAuth.instance.currentUser!.uid);
    print("-------------------Add User----------------------");
    print(result);
    print("-------------------Add User----------------------");
    await myBox.put(0, result!);
  }

  UserModel? getUser() => myBox.get(0);

  Future<void> updateUser({required UserModel userModel}) async =>
      await myBox.put(0, userModel);

  Future<void> deleteUser() async {
    await myBox.delete(0);
    clear();
  }

  void clear() {
    _instance = null;
  }
}
