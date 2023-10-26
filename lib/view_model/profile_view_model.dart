import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/file_store/user_service.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/view_model/home_view_model.dart';

import '../service/firebase_storage_service.dart';
import '../utils/constant.dart';

class ProfileViewModel extends GetxController {
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  UserModel userModel = CacheUserHive.instance.getUser()!;
  String firstNameController = CacheUserHive.instance.getUser()!.firstName;
  String lastNameController = CacheUserHive.instance.getUser()!.lastName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? imageFile;
  String? imageUrlDowloaded;
  bool isImageUploaded = false;

  Future<void> loadImage({required Source source}) async {
    ImageSource imageSource =
        Source.camera == source ? ImageSource.camera : ImageSource.gallery;
    XFile? result =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImageFromSource(source: imageSource);

    if (result != null) {
      File imageSource = File(result.path);
      print("-" * 20);
      imageFile = imageSource;
    }
    Get.back();
    update();

    if (imageFile != null) {
      imageUrlDowloaded = await uploadImage(imageFile!);
      isImageUploaded = true;
      update();
    }
  }

  Future<String> uploadImage(File file) async {
    String imageUrl =
        await FireBaseStorageService.instance.uploadFile(file: file);

    return imageUrl;
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (imageFile != null) {
        imageUrlDowloaded = imageUrlDowloaded ?? await uploadImage(imageFile!);
        isImageUploaded = true;
      }
      if (imageUrlDowloaded != null) {
        if (userModel.image != "")
          await FireBaseStorageService.instance
              .deleteFile(url: userModel.image!);
      }
      UserModel userUpdatedData = UserModel(
          email: userModel.email,
          id: userModel.id,
          firstName: firstNameController,
          lastName: lastNameController,
          image:
              imageUrlDowloaded != null ? imageUrlDowloaded : userModel.image);
// "${userModel?.firstName} ${userModel?.lastName}"

      await PostService.instance
          .updatePostUserName(
              id_user: userModel.id,
              oldName: "${userModel.firstName} ${userModel.lastName}",
              newName:
                  "${userUpdatedData.firstName} ${userUpdatedData.lastName}")
          .then((value) => print("Sucess for update All Posts for this User"));

      await CacheUserHive.instance.updateUser(userModel: userUpdatedData);

      await UserService.instance.updateUser(userModel: userUpdatedData);
      Get.back();

      homeViewModel.updataAllPosts(
          oldName: userModel, newName: userUpdatedData);
    }
  }
}
