import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/post_service.dart';

import 'package:vistorapp/utils/routes.dart';
import 'package:vistorapp/view/categoty_view.dart';
import 'package:vistorapp/view/home_view.dart';
import 'package:get/get.dart';

import '../utils/type_of_user_login.dart';

class HomeViewModel extends GetxController {
  int currentIndex = 0;
  int currentBottomNavigationBarIndex = 0;
  List<PostModel> listAllPosts = <PostModel>[];
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  List<Widget> myScreen = const [HomeView(), CategoryView()];
  void ChangeCurrentIndex() {
    currentIndex = currentIndex == 0 ? 1 : 0;
    update();
  }

  void ChangeCurrentBottomNavigationBarIndex(int index) {
    currentBottomNavigationBarIndex = index;
    update();
  }

  Future<void> logOut() async {
    if (TypeOfUserLogin.instance.isGuset()) {
      Get.offAllNamed(Routes.initialRoute);
    } else {
      await FirebaseAuth.instance.signOut();
      // remove the jey of the Current User
      await TypeOfUserLogin.instance.removeCurrentUser();
    }
  }

  Future<void> getAllPosts() async {
    valueNotifier.value = false;
    await PostService.instance.getAllPosts().then((value) {
      listAllPosts = value;
      valueNotifier.value = true;
      update();
    });
  }

  void addPostModelManually({required PostModel model}) {
    listAllPosts.add(model);
    update();
  }

  void updataAllPosts(
      {required UserModel oldName, required UserModel newName}) {
    for (int i = 0; i < listAllPosts.length; i++) {
      if (listAllPosts[i].name == "${oldName.firstName} ${oldName.lastName}") {
        listAllPosts[i].name == "${newName.firstName} ${newName.lastName}";
      }
    }
    update();
  }

  void updatePostsLike({required PostModel postModel}) {
    for (int i = 0; i < listAllPosts.length; i++) {
      if (listAllPosts[i].id == postModel.id) {
        listAllPosts[i] = postModel;
        print("Ok updated");
        break;
      }
    }
    update();
  }

  void updateMohamed() {
    update();
  }

  void removePost(int index) {
    listAllPosts.removeAt(index);
    update();
  }

  void removePostModelManually({required PostModel postModel}) {
    for (int i = 0; i < listAllPosts.length; i++) {
      if (listAllPosts[i].id == postModel.id) {
        listAllPosts.removeAt(i);
        break;
      }
    }

    update();
  }

  void removeSomePosts(List<PostModel> somePost) {
    for (int i = 0; i < somePost.length; i++) {
      for (int j = 0; j < listAllPosts.length; j++) {
        if (somePost[i].id == listAllPosts[j].id) {
          listAllPosts.removeAt(j);
          break;
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPosts();
  }
}
