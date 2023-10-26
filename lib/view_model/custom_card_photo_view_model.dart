import 'package:get/get.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';

import '../model/post_model.dart';
import '../service/file_store/post_service.dart';
import '../service/local/hive/hive_posts_like.dart';

class CustomCardPhotoViewModel extends GetxController {
  final PostModel postModel;

  CustomCardPhotoViewModel({required this.postModel});

  void likePost() async {
    if (TypeOfUserLogin.instance.isGuset()) return;
    postModel.isLove = postModel.isLove;

    if (postModel.isLove) {
      postModel.likes = postModel.likes! + 1; // increment likes
      HivePostsLike.instance
          .likePost(idPost: postModel.id!); // Save user Love in a Cache
      // update in like number in Firebase
      await PostService.instance.updatePost(postModel: postModel);
    } else {
      postModel.likes =
          postModel.likes != 0 ? postModel.likes! - 1 : 0; // decrement likes
      HivePostsLike.instance.dislikePost(idPost: postModel.id!);
      await PostService.instance.updatePost(postModel: postModel);
    }
  }
}
