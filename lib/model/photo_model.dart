class PhotoModel {
  final String? name;
  final String? image;
  final String? category;
  final bool? isLoved;
  final int? loveNum;

  PhotoModel(
      {this.image,
      this.isLoved = false,
      this.loveNum,
      this.name,
      this.category});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        image: json['image'],
        isLoved: json['isLoved'],
        loveNum: json['loveNum'],
        category: json['category'],
        name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "isLoved": isLoved,
        "loveNum": loveNum,
        "name": name,
        "category": category
      };
}
