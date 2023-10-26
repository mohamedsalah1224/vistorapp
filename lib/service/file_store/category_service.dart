import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vistorapp/model/category_model.dart';

class CategoryService {
  static CategoryService? _instance;
  static CategoryService get instance => _instance ??= CategoryService._();
  CategoryService._();

  final CollectionReference ref =
      FirebaseFirestore.instance.collection("category");

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryList = [];
    await ref.get().then((value) {
      for (var element in value.docs) {
        categoryList.add(CategoryModel.fromJson(
            json: element.data() as Map<String, dynamic>));
      }
    });

    return categoryList;
  }

  Future<CategoryModel> addCategory(
      {required CategoryModel categoryModel}) async {
    String id = "";
    await ref
        .add(categoryModel.toJson())
        .then((value) => id = value.id)
        // ignore: invalid_return_type_for_catch_error
        .catchError((e) => print("Fail to Add the Category"));

    await ref.doc(id).update({"id": id});

    return CategoryModel(
        idUser: categoryModel.idUser, name: categoryModel.name, id: id);
  }

  Future<void> deleteCategory({required String id}) async {
    await ref.doc(id).delete();
  }

  void clear() {
    _instance = null;
  }
}
