import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import 'package:vistorapp/view_model/category_view_model.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import '../../service/file_store/post_service.dart';
import '../../service/local/hive/hive_posts_like.dart';
import '../../utils/app_images.dart';
import 'custom_text.dart';

class CustomCardPhoto extends StatefulWidget {
  final PostModel postModel;
  final double width;
  final double height;
  final bool showLike;
  final int expandedImage;
  final bool isCategoryView;
  CustomCardPhoto(
      {super.key,
      required this.postModel,
      this.isCategoryView = false,
      this.height = 191,
      this.expandedImage = 3,
      this.showLike = false,
      this.width = 209});
  @override
  State<CustomCardPhoto> createState() => _CustomCardPhotoState();
}

class _CustomCardPhotoState extends State<CustomCardPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width.w,
      height: widget.height.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w), color: Colors.white),
      child: Column(
        children: [
          Expanded(
              flex: widget.expandedImage,
              child: Container(
                  child: Image.network(
                widget.postModel.image,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ))),
          SizedBox(
            height: MediaQuery.of(context).size.height / 70.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 200.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: widget.postModel.name.toString(),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (TypeOfUserLogin.instance.isGuset()) return;
                          widget.postModel.isLove = !widget.postModel.isLove;

                          if (widget.postModel.isLove) {
                            widget.postModel.likes =
                                widget.postModel.likes! + 1; // increment likes
                            HivePostsLike.instance.likePost(
                                idPost: widget.postModel
                                    .id!); // Save user Love in a Cache
                            // update in like number in Firebase
                            await PostService.instance
                                .updatePost(postModel: widget.postModel);
                          } else {
                            widget.postModel.likes = widget.postModel.likes != 0
                                ? widget.postModel.likes! - 1
                                : 0; // decrement likes
                            print(widget.postModel.id!);
                            HivePostsLike.instance
                                .dislikePost(idPost: widget.postModel.id!);
                            await PostService.instance
                                .updatePost(postModel: widget.postModel);
                          }

                          if (widget.isCategoryView) {
                            HomeViewModel controller =
                                Get.find<HomeViewModel>();
                            controller.updatePostsLike(
                                postModel: widget.postModel);
                          } else {
                            // update CategoryView Model
                          }
                          CategoryViewModel().updateManually();
                          // CategoryViewModel
                          setState(() {});
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 17,
                              child: Image.asset(
                                widget.postModel.isLove
                                    ? Assets.likeRed
                                    : Assets.likeWhite,
                                cacheHeight: 17,
                                cacheWidth: 15,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            widget.showLike
                                ? CustomText(
                                    text: "${widget.postModel.likes}",
                                    fontSize: 13,
                                    color: Colors.black.withOpacity(0.6),
                                  )
                                : SizedBox()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 600,
                  ),
                  CustomText(
                    text: widget.postModel.category,
                    fontSize: 13,
                    color: Color(0x99000000),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
