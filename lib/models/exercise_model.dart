class ExerciseModel {
  final String name;
  final String breathing;
  final String image;
  final String precaution;
  final String process;
  final int sequence;
  final String audio;
  final String benefits;

  ExerciseModel(
      {required this.name,
      required this.benefits,
      required this.breathing,
      required this.image,
      required this.precaution,
      required this.process,
      required this.sequence,
      required this.audio});

  ExerciseModel.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            breathing: json['breathing']! as String,
            image: json['image']! as String,
            precaution: json['precaution']! as String,
            process: json['process']! as String,
            sequence: json['sequence'] as int,
            audio: json['audio']! as String,
            benefits: json['benefits']! as String);

  bool isInfoEmpty() {
    return breathing == "-" && precaution == "-" && breathing == "-";
  }
}
