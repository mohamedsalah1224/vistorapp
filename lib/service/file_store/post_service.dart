import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/service/local/hive/hive_posts_like.dart';

class PostService {
  static PostService? _instance;
  static PostService get instance => _instance ??= PostService._();
  PostService._();

  final CollectionReference ref =
      FirebaseFirestore.instance.collection("posts");

  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> postList = [];

    await ref.get().then((value) {
      for (var element in value.docs) {
        postList.add(
            PostModel.fromJson(json: element.data() as Map<String, dynamic>));
      }
    });

    return postList;
  }

  Future<List<PostModel>> getPostWithCategory(
      {required String category}) async {
    List<PostModel> postList = [];
    await ref.where("category", isEqualTo: category).get().then((value) {
      for (var element in value.docs) {
        postList.add(
            PostModel.fromJson(json: element.data() as Map<String, dynamic>));
      }
    });

    return postList;
  }

  Future<PostModel> addPost({required PostModel postModel}) async {
    String id = "";
    await ref.add(postModel.toJson()).then((value) async {
      id = value.id;
    });
    await ref.doc(id).update({"id": id});

    return PostModel(
        category: postModel.category,
        image: postModel.image,
        id_user: postModel.id_user,
        name: postModel.name,
        isLove: postModel.isLove,
        likes: postModel.likes,
        id: id);
  }

  Future<void> updatePost({required PostModel postModel}) async {
    await ref
        .doc(postModel.id)
        .update({"likes": postModel.likes, "isLove": postModel.isLove});
  }

  Future<void> removePost({required PostModel postModel}) async {
    Get.back();
    await ref.doc(postModel.id).delete();
    print("-" * 20);
    print(postModel.id);
    HivePostsLike.instance.dislikePost(idPost: postModel.id!);
    Get.snackbar("Post", "Remove Sucess");
  }

  Future<void> updatePostUserName(
      {required String oldName,
      required String newName,
      required String id_user}) async {
    await ref
        .where("name", isEqualTo: oldName)
        .where("id_user", isEqualTo: id_user)
        .get()
        .then((value) {
      print("The length is ${value.docs.length}");
      value.docs.forEach((element) async {
        await ref.doc(element.id).update({"name": newName});
      });
    });
  }

  Future<List<PostModel>> deleteAllPostsWithCategory(
      {required String category}) async {
    List<PostModel> listPostModel = [];
    await ref.where("category", isEqualTo: category).get().then((value) async {
      for (var element in value.docs) {
        listPostModel.add(
            PostModel.fromJson(json: element.data() as Map<String, dynamic>));
        await ref.doc(element.id).delete();
      }
    });

    return listPostModel;
  }

  void clear() {
    _instance = null;
  }
}
