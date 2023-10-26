import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance ??= FirebaseAuthService._();

  FirebaseAuthService._();

  // signInEmail , password

  Future<String?> createUserWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      UserCredential? userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      print("-" * 50);
      print(userCredential);
      return "Sucess";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return "Erro";
    }
    return null;
  }

  Future<String> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return "Sucess";
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Sucess");
    } on FirebaseAuthException catch (e) {
      print("Erro occur like Email not found $e");
    }
  }

  void clear() {
    _instance = null;
  }
}
