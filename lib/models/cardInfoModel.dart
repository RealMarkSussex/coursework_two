class CardInfoModel {
  final String name;
  final String image;
  final String description;

  CardInfoModel(
      {required this.name, required this.image, required this.description});

  CardInfoModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            image: json['image']! as String,
            description: json['description']! as String);
}
