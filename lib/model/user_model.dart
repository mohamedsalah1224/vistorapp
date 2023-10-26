import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String id;
  @HiveField(4)
  String? image;

  UserModel(
      {required this.email,
      required this.id,
      this.image = "",
      required this.firstName,
      required this.lastName});

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
        email: json['email'],
        id: json['id'],
        image: json['image'],
        firstName: json['firstName'],
        lastName: json['lastName']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "id": id
      };
}
