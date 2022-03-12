class CardInfoModel {
  final String name;
  final String image;
  final String description;
  final String suitable;

  CardInfoModel(
      {required this.name,
      required this.image,
      required this.description,
      required this.suitable});

  CardInfoModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            image: json['image']! as String,
            description: json['description']! as String,
            suitable: json['suitable']! as String);

  List<String> getSuitability() {
    return suitable.split(',');
  }
}
