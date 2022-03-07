class AboutModel {
  final String name;
  final String email;
  final String studentId;
  final String image;

  AboutModel(
      {required this.name,
      required this.email,
      required this.studentId,
      required this.image});

  AboutModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            email: json['email']! as String,
            studentId: json['student_id']! as String,
            image: json['image']! as String);
}
