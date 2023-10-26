class CategoryModel {
  String idUser;
  String name;
  String id;
  CategoryModel({required this.idUser, required this.name, this.id = ""});

  factory CategoryModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryModel(
        idUser: json['idUser'], name: json['name'], id: json['id']);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"idUser": idUser, "name": name, "id": id};
}
