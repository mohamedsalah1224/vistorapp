import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:vistorapp/model/user_model.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/firebase_storage_service.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import 'package:vistorapp/view_model/category_view_model.dart';
import 'package:vistorapp/view_model/home_view_model.dart';

import '../../model/post_model.dart';
import 'custom_card_photo.dart';

class CustomDialogUtils {
  CustomDialogUtils._();
  static CustomDialogUtils? _instance;
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  CategoryViewModel categoryViewModel = Get.find<CategoryViewModel>();
  static CustomDialogUtils get instance => _instance ??= CustomDialogUtils._();

  void claer() {
    _instance = null;
  }

  void showCustomDialog(BuildContext context,
      {required PostModel postModel,
      required index,
      required bool isRemovedFromCategory}) {
    UserModel? userModel;
    if (!TypeOfUserLogin.instance.isGuset())
      userModel = CacheUserHive.instance.getUser()!;
    else
      userModel = null;

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 438.h,
                width: 343.w,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 30,
                    right: MediaQuery.of(context).size.width / 30,
                    bottom: MediaQuery.of(context).size.height / 60,
                    top: MediaQuery.of(context).size.height / 60),
                child: CustomCardPhoto(
                  expandedImage: 10,
                  width: 313.w,
                  height: 314.h,
                  showLike: true,
                  postModel: postModel,
                  isCategoryView: true,
                ),
              ),
              !TypeOfUserLogin.instance.isGuset() &&
                      (TypeOfUserLogin.instance.isAdmin() ||
                          userModel?.id == postModel.id_user)
                  ? Positioned(
                      bottom: -5.h,
                      child: Container(
                        child: IconButton(
                          onPressed: () async {
                            if (isRemovedFromCategory) {
                              homeViewModel.removePostModelManually(
                                  postModel: postModel);
                              categoryViewModel.removePost(index: index);
                            } else {
                              homeViewModel.removePost(index);
                              categoryViewModel.removePostModelManually(
                                  postModel: postModel);
                            }

                            await PostService.instance
                                .removePost(postModel: postModel);
                            await FireBaseStorageService.instance
                                .deleteFile(url: postModel.image);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 25.r,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
