enum Level { newToYoga, regularPractitioner, advancedPractitioner }

extension Parser on Level {
  List<LevelModel> toList() {
    return [
      LevelModel(level: Level.newToYoga, description: "New to yoga"),
      LevelModel(
          level: Level.regularPractitioner,
          description: "Regular practitioner"),
      LevelModel(
          level: Level.advancedPractitioner,
          description: "Advanced Practitioner"),
    ];
  }
}

class LevelModel {
  final Level level;
  final String description;

  LevelModel({required this.level, required this.description});
}
