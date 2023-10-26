import 'package:flutter/material.dart';
import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/service/file_store/post_service.dart';
import 'package:vistorapp/service/local/hive/hive_posts_like.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/view_model/category_view_model.dart';
import 'package:get/get.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class CustomLove extends StatelessWidget {
  bool showLike;
  final CategoryViewModel categoryController = Get.find<CategoryViewModel>();
  final HomeViewModel homeController = Get.find<HomeViewModel>();
  bool isLoved = false;
  PostModel postModel;
  CustomLove(
      {super.key,
      this.isLoved = false,
      required this.postModel,
      required this.showLike});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return GestureDetector(
          onTap: () {
            setState(() async {
              isLoved = !isLoved;
              if (isLoved) {
                postModel.likes = postModel.likes! + 1; // increment likes
                HivePostsLike.instance.likePost(
                    idPost: postModel.id!); // Save user Love in a Cache
                // update in like number in Firebase
                await PostService.instance.updatePost(postModel: postModel);
              } else {
                postModel.likes = postModel.likes != 0
                    ? postModel.likes! - 1
                    : 0; // decrement likes
                HivePostsLike.instance.dislikePost(idPost: postModel.id!);
                await PostService.instance.updatePost(postModel: postModel);
              }
            });
          },
          child: Row(
            children: [
              Container(
                width: 15,
                height: 17,
                child: Image.asset(
                  isLoved ? Assets.likeRed : Assets.likeWhite,
                  cacheHeight: 17,
                  cacheWidth: 15,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              showLike
                  ? CustomText(
                      text: "${postModel.likes}",
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.6),
                    )
                  : SizedBox()
            ],
          ),
        );
      },
    );
  }
}
