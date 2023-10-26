import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/category_service.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/file_store/user_service.dart';
import 'package:vistorapp/service/firebase_auth_servive.dart';
import 'package:vistorapp/service/firebase_storage_service.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/service/local/hive/hive_posts_like.dart';
import 'package:vistorapp/utils/form_validator.dart';
import 'package:vistorapp/utils/validation.dart';
import 'package:vistorapp/view/customWidget/custom_dialog.dart';
import '../utils/type_of_user_login.dart';

class AuthViewModel extends GetxController {
  String emailControlelr = "";
  String passwordController = "";
  String firstNameController = "";
  String lastNameController = "";
  String confirmPasswordController = "";

  GlobalKey<FormState> formKeyforgetPassword = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyLogIn = GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignUp = GlobalKey<FormState>();
  final Validation validation = Validation.instance;
  final FormValidator formValidator = FormValidator.instance;

/* ---------------Validation of the TextForm Fields--------------- */

  String? validateEmail({String? email}) {
    return formValidator.emailValidator(email);
  }

  String? validatePassword({String? password}) {
    return formValidator.passwordValidator(password);
  }

  String? validateConfirmPassword(
      {String? confirmPw, required String inputPw}) {
    return formValidator.confirmPasswordValidator(confirmPw, inputPw);
  }

  String? validateName({String? name}) {
    return formValidator.nameValidator(name);
  }

  String? validatAnyTextFormField({String? value, required nameOfTextField}) {
    return formValidator.anyTextFormValidator(value, nameOfTextField);
  }

/* ---------------Validation of the TextForm Fields--------------- */

/* ---------------The Functionality of the Auth View--------------- */
  Future<void> logIn(BuildContext context) async {
    bool isSucess = false;
    if (formKeyLogIn.currentState!.validate()) {
      formKeyLogIn.currentState!.save();
      // ignore: unused_local_variable
      String message;
      await FirebaseAuthService.instance
          .signInWithEmailAndPassword(
              emailAddress: emailControlelr, password: passwordController)
          .then((value) async {
        if (value == "Sucess") {
          String? data = FirebaseAuth.instance.currentUser?.uid;
          isSucess = data == null ? false : true;
          message = isSucess ? "Sucess" : "Erro";
        } else {
          isSucess = false;
        }

        Get.snackbar(
          "LogIn Process",
          isSucess ? value : "Erro",
        );
      });

      if (isSucess) {
        if (emailControlelr.trim() == "admin@admin.com") {
          await TypeOfUserLogin.instance.setAdmin();
        } else {
          // set the user not a guset
          await TypeOfUserLogin.instance.setUser();
        }
        // cache User instance
        await CacheUserHive.instance.addUser();
      } else {
        print("Erro when the User LogIn");
      }
    }
  }

  void cutomDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.redAccent),
          );
        });
  }

  Future<void> signUp() async {
    formKeySignUp.currentState!.save();
    if (formKeySignUp.currentState!.validate()) {
      formKeySignUp.currentState!.save();
      bool flag = true;
      // Create the user with email and passsword
      await FirebaseAuthService.instance
          .createUserWithEmailAndPassword(
              emailAddress: emailControlelr, password: passwordController)
          .then((value) async {
        if (value == "Sucess") {
          flag = true;
        } else {
          // if any erro occur when user signup
          print("Eroor for sign up the user $value");
          flag = false;
        }
        Get.snackbar(
          "SignUp",
          value ?? "Erro",
        );
      });

      if (flag) {
        /// add the user information to the file Store
        // await FirebaseAuthService.instance.signInWithEmailAndPassword(
        //     emailAddress: emailControlelr, password: passwordController);

        await UserService.instance.addUser(
            userModel: UserModel(
          email: emailControlelr,
          id: FirebaseAuth.instance.currentUser!.uid,
          firstName: firstNameController,
          lastName: lastNameController,
        ));

        if (emailControlelr.trim() == "admin@admin.com") {
          await TypeOfUserLogin.instance.setAdmin();
        } else {
          // set the user not a guset
          await TypeOfUserLogin.instance.setUser();
        }

        // cache User instance
        await CacheUserHive.instance.addUser();
      }
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    // remove the jey of the Current User
    await TypeOfUserLogin.instance.removeCurrentUser();
    // cache User instance
    await CacheUserHive.instance.deleteUser();
    //  await HivePostsLike.instance.clearAllData(); if more accont exit in the Device
    CustomDialogUtils.instance
        .claer(); // to remove the inormation from the Memory
    CacheUserHive.instance.clear();
    clearAllSinglton();

    Get.delete();
    Get.deleteAll();
  }

  void clearAllSinglton() {
    CustomDialogUtils.instance.claer();
    CacheUserHive.instance.clear();
    FireBaseStorageService.instance.clear();
    HivePostsLike.instance.clear();
    CategoryService.instance.clear();
    PostService.instance.clear();
    UserService.instance.clear();
  }

// when forget Password
  Future<void> resetPassword() async {
    if (formKeyforgetPassword.currentState!.validate()) {
      formKeyforgetPassword.currentState!.save();
      await FirebaseAuthService.instance.resetPassword(email: emailControlelr);
    }
  }

  Future<void> skipLoginProcess() async {
    await TypeOfUserLogin.instance.setGuest();
  }

/* ---------------The Functionality of the Auth View--------------- */
  @override
  void onClose() {
    // Dispose all Controller from Memory
    super.onClose();

    // // ignore: invalid_use_of_protected_member
    // formKey.currentState?.dispose();
  }
}
