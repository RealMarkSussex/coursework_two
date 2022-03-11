class CreditModel {
  final String description;
  final String url;

  CreditModel({required this.description, required this.url});

  CreditModel.fromJson(Map<String, Object?> json)
      : this(
            description: json['description']! as String,
            url: json['url']! as String);
}
