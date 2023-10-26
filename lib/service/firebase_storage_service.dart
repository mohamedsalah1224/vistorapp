import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageService {
  static FireBaseStorageService? _instance;
  static FireBaseStorageService get instance =>
      _instance ??= FireBaseStorageService._();
  FireBaseStorageService._();

  // root
  Future<String> uploadFile({required File file}) async {
    int timeStamp = DateTime.now().millisecondsSinceEpoch;
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child("$timeStamp${path.basename(file.path)}");

    await ref.putFile(File(file.path));

    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> deleteFile({required String url}) async {
    final Reference ref = FirebaseStorage.instance.refFromURL(url);
    try {
      await ref.delete();
    } catch (e) {
      print("-" * 20);
      print("Exception Occur");
      print("-" * 20);
    }
  }

  void clear() {
    _instance = null;
  }
}
