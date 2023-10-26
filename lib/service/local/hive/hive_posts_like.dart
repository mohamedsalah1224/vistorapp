import 'package:hive_flutter/hive_flutter.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';

class HivePostsLike {
  static HivePostsLike? _instance;
  static HivePostsLike get instance => _instance ??= HivePostsLike._();
  HivePostsLike._();
  String? idUser;
  late Box<List<String>> myBox;

  Future<void> init() async {
    await Hive.openBox<List<String>>("postsLove");
    myBox = Hive.box<List<String>>("postsLove");
  }

  Future<void> likePost({required String idPost}) async {
    idUser = idUser ?? CacheUserHive.instance.getUser()!.id;
    List<String>? list = getAllPosts();
    list = list ?? [];
    list.add(idPost);
    await myBox.put(idUser, list);
  }

  bool isPostLiked({required String idPost}) {
    List<String>? list = getAllPosts();
    list = list ?? [];
    return list.contains(idPost);
  }

  Future<void> dislikePost({required String idPost}) async {
    idUser = idUser ?? CacheUserHive.instance.getUser()!.id;
    List<String>? list = getAllPosts();
    list = list ?? [];

    list.removeWhere((value) => value == idPost);
    await myBox.put(idUser, list);
  }

  List<String>? getAllPosts() {
    idUser = idUser ?? CacheUserHive.instance.getUser()!.id;
    return myBox.get(idUser, defaultValue: []);
  }

  Future<void> clearAllData() async {
    await myBox.clear();
  }

  void clear() {
    _instance = null;
  }
}
