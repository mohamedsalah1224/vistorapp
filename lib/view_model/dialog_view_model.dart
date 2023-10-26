import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/firebase_storage_service.dart';

import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/view_model/category_view_model.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import '../service/file_store/category_service.dart';

class DialogViewModel extends GetxController {
  ValueNotifier<bool> valueNotifier = ValueNotifier(false);
  String? valueDropDown;
  List<String> categoryList = [];
  File? imageFile;
  bool isSelectedImage = false;
  String? imageUrlDowloaded;
  bool showAddCategores = false;
  UploadTask? uploadTask;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isImageUploaded = false;
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  CategoryViewModel categoryViewModel = Get.find<CategoryViewModel>();

  // String categoryControlelr = "";
  // GlobalKey<FormState> formKeycategory = GlobalKey<FormState>();

  Future<void> refreshController() async {
    imageFile = null;
    imageUrlDowloaded = null;
    showAddCategores = false;
    valueDropDown = null;
    isImageUploaded = false;

    await getCategories();
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();

    getCategories();
  }

  void changeValueOfDropDown(String? newValue) {
    valueDropDown = newValue;
    update();
  }

  Future<void> getCategories() async {
    await CategoryService.instance.getCategories().then((value) {
      categoryList = value.map((e) => e.name).toList();
      valueNotifier.value = true;
      update();
    });
  }

  Future<void> loadImage({required Source source}) async {
    ImageSource imageSource =
        Source.camera == source ? ImageSource.camera : ImageSource.gallery;
    XFile? result =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImageFromSource(source: imageSource);

    if (result != null) {
      File imageSource = File(result.path);
      imageFile = imageSource;
      isSelectedImage = false;
      update();
    }
    // imageUrlDowloaded = await uploadImage(imageFile);
  }

  Future<String?> uploadImage(File? file) async {
    if (file == null) return null; // if the User not selected any thing
    String imageUrl =
        await FireBaseStorageService.instance.uploadFile(file: file);

    return imageUrl;
  }

  void changeUploadTask({required UploadTask value}) {
    uploadTask = value;
    update();
  }

  Future<void> uploadPost() async {
    if (imageFile == null) {
      isSelectedImage = true;
      update();
      return;
    }
    if (formKey.currentState!.validate()) {
      String? imageUrl = imageUrlDowloaded ?? await uploadImage(imageFile!);
      if (imageFile == null) return; // if the User not selected any thing

      UserModel userModel = CacheUserHive.instance.getUser()!;

      PostModel postModel = await PostService.instance.addPost(
          postModel: PostModel(
              id_user: userModel.id,
              category: valueDropDown!,
              image: imageUrl!,
              name: "${userModel.firstName} ${userModel.lastName}"));
      isImageUploaded = true;
      update(["image"]);
      homeViewModel.addPostModelManually(model: postModel);
      categoryViewModel.addPostModelManually(postModel: postModel);

      Get.back();
      Get.snackbar("Post", "The post has been added successfully");
    }
  }

  void endUploadTask() {
    uploadTask = null;
    update();
  }

  Future<void> closeBottomSheet() async {
    if (!isSelectedImage) {
      if (imageUrlDowloaded != null) {
        await FireBaseStorageService.instance
            .deleteFile(url: imageUrlDowloaded!);
        print("Deleted");
        Get.back();
      } else {
        await Future.delayed(Duration(seconds: 4));
        if (imageUrlDowloaded != null) {
          await FireBaseStorageService.instance
              .deleteFile(url: imageUrlDowloaded!);
        }
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  // Future<void> addCategory() async {
  //   if (formKeycategory.currentState!.validate()) {
  //     formKeycategory.currentState!.save();

  //     if (categoryViewModel.isCategoryExist(name: categoryControlelr)) {
  //       Get.back();
  //       return;
  //     }
  //     CategoryModel categoryModel = await CategoryService.instance.addCategory(
  //         categoryModel: CategoryModel(
  //             idUser: CacheUserHive.instance.getUser()!.id,
  //             name: categoryControlelr));
  //     Get.back();
  //     categoryViewModel.addCategory(categoryModel: categoryModel);
  //     categoryList.add(categoryControlelr);
  //     Get.snackbar("Category", "Sucess for add this Category");
  //     update();
  //   }
  // }
}
