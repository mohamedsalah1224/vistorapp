import 'package:vistorapp/service/local/hive/hive_posts_like.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';

class PostModel {
  String category;
  String? id;
  int? likes;
  String name;
  String image;
  String? id_user;
  bool isLove;
  PostModel(
      {required this.category,
      this.id,
      required this.image,
      required this.name,
      this.id_user,
      this.isLove = false,
      this.likes = 0});

  factory PostModel.fromJson({required Map<String, dynamic> json}) {
    return PostModel(
      category: json['category'],
      id: json['id'],
      id_user: json['id_user'],
      name: json['name'],
      image: json['image'],
      likes: json['likes'],
      isLove: TypeOfUserLogin.instance.isGuset()
          ? false
          : HivePostsLike.instance.isPostLiked(idPost: json['id']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "likes": likes,
        "name": name,
        'isLove': isLove,
        "image": image,
        "id_user": id_user
      };
}
/*

{
        "id": id,
        "category": category,
        "likes": likes,
        "name": name,
        'userLove': {
         isLove: false
        },
        "image": image

}

*/