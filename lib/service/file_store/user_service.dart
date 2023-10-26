import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vistorapp/model/user_model.dart';

class UserService {
  static UserService? _instance;
  UserService._();
  static UserService get instance => _instance ??= UserService._();
//  _instance = _instance ??UserService._();
// x+=2  x=x+2
  final CollectionReference<Map<String, dynamic>> ref =
      FirebaseFirestore.instance.collection("users");

  // addUser , getUser

  Future<void> addUser({required UserModel userModel}) async {
    ref
        .doc(userModel.id)
        .set(userModel.toJson())
        .then((value) => print("Sucess for add the User"))
        .catchError((e) => print(e.toString()));
  }

  Future<void> updateUser({required UserModel userModel}) async {
    ref
        .doc(userModel.id)
        .update(userModel.toJson())
        .then((value) => print("Sucess for update the User"))
        .catchError((e) => print("Fail to update the User"));
  }

  Future<UserModel?> getUser({required String id}) async {
    UserModel? model;
    await ref.doc(id).get().then((value) {
      if (value.exists) {
        print(value.data());
        model = UserModel.fromJson(json: value.data()!);
      }
    });
    return model;
  }

  void clear() {
    _instance = null;
  }
}
