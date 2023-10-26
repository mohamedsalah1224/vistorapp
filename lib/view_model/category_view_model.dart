import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistorapp/model/category_model.dart';
import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/service/file_store/category_service.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/view_model/home_view_model.dart';

class CategoryViewModel extends GetxController {
  int currentIndex = 0;

  ValueNotifier<bool> valueNotifierCategory = ValueNotifier<bool>(false);
  ValueNotifier<bool> valueNotifierPosts = ValueNotifier<bool>(false);
  List<PostModel> postList = [];
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  List<CategoryModel> categoryList = [];

  String categoryControlelr = "";
  GlobalKey<FormState> formKeycategory = GlobalKey<FormState>();

  @override
  void onInit() async {
    valueNotifierCategory.value = false;

    await CategoryService.instance.getCategories().then((value) {
      categoryList = value;
      valueNotifierCategory.value = true;
      update();
    });

    if (categoryList.isEmpty) {
      valueNotifierPosts.value = true;
      update();
    } else {
      getPosts(category: categoryList[currentIndex].name);
    }

    super.onInit();
  }

  void addPostModelManually({required PostModel postModel}) {
    if (categoryList[currentIndex].name == postModel.category)
      postList.add(postModel);
    update();
  }

  void removePost({required int index}) {
    postList.removeAt(index);
    update();
  }

  void removePostModelManually({required PostModel postModel}) {
    if (categoryList[currentIndex].name == postModel.category) {
      for (int i = 0; i < postList.length; i++) {
        if (postList[i].id == postModel.id) {
          postList.removeAt(i);
          break;
        }
      }
    }

    update();
  }

  Future<void> getPosts({required String category}) async {
    valueNotifierPosts.value = false;
    await PostService.instance
        .getPostWithCategory(category: category)
        .then((value) {
      postList = value;
      valueNotifierPosts.value = true;

      update();
    });
  }

  Future<void> changeCurrentIndex(int index) async {
    currentIndex = index;
    getPosts(category: categoryList[currentIndex].name);
    update();
  }

  void updateMohamed() {
    update();
  }

  void updateManually() async {
    valueNotifierCategory.value = false;

    await CategoryService.instance.getCategories().then((value) {
      categoryList = value;
      valueNotifierCategory.value = true;
      update();
    });

    if (categoryList.isEmpty) {
      valueNotifierPosts.value = true;
      update();
    } else {
      getPosts(category: categoryList[currentIndex].name);
    }
    update();
  }

  void addCategory({required CategoryModel categoryModel}) {
    categoryList.add(categoryModel);
    update();
  }

  Future<void> deleteCategory() async {
    if (categoryList.length <= 0) return;
    CategoryModel categoryModel = categoryList[currentIndex];
    await CategoryService.instance
        .deleteCategory(id: categoryList[currentIndex].id);
    categoryList.removeAt(currentIndex);
    if (categoryList.length > 2) {
      if (currentIndex == 0) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    } else {
      currentIndex = 0;
    }

    if (categoryList.isEmpty) {
      postList = [];
    } else {
      await getPosts(category: categoryList[currentIndex].name);
    }

    update();

    List<PostModel> listPostModel = await PostService.instance
        .deleteAllPostsWithCategory(category: categoryModel.name);
    homeViewModel.removeSomePosts(listPostModel);
  }

  bool isCategoryExist({required String name}) {
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].name == name) {
        return true;
      }
    }
    return false;
  }

  Future<void> addNewCategory() async {
    if (formKeycategory.currentState!.validate()) {
      formKeycategory.currentState!.save();

      if (isCategoryExist(name: categoryControlelr)) {
        Get.back();
        return;
      }
      CategoryModel categoryModel = await CategoryService.instance.addCategory(
          categoryModel: CategoryModel(
              idUser: CacheUserHive.instance.getUser()!.id,
              name: categoryControlelr));
      Get.back();
      categoryList.add(categoryModel);
      // categoryList.add(categoryControlelr);
      Get.snackbar("Category", "Sucess for add this Category");
      update();
    }
  }
}
