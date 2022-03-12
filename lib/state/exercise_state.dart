import 'dart:collection';

import 'package:coursework_two/models/exercise_model.dart';
import 'package:flutter/material.dart';

class ExerciseState extends ChangeNotifier {
  ExerciseState(List<ExerciseModel> exercises) {
    _exercises = exercises;
    notifyListeners();
  }

  List<ExerciseModel> _exercises = [];
  int _currentExercise = 0;
  String _exerciseType = "";
  UnmodifiableListView<ExerciseModel> get exercises =>
      UnmodifiableListView(_exercises);

  int get currentExercise => _currentExercise;
  bool get isLastExercise => _currentExercise == lastExercise;
  bool get isFirstExercise => _currentExercise == 0;
  int get lastExercise =>
      _exercises
          .where((element) => element.exerciseType == _exerciseType)
          .length -
      1;
  String get exerciseType => _exerciseType;
  ExerciseModel get currentExerciseModel => _exerciseType.isNotEmpty
      ? _exercises.firstWhere((element) =>
          element.exerciseType == _exerciseType &&
          element.sequence == currentExercise)
      : ExerciseModel(
          name: "",
          benefits: "",
          breathing: "",
          image: "",
          precaution: "",
          process: "",
          sequence: 0,
          audio: "",
          exerciseType: "");

  void goForward() {
    if (!isLastExercise) {
      _currentExercise++;
    }
    notifyListeners();
  }

  void goBackward() {
    if (!isFirstExercise) {
      _currentExercise--;
    }

    notifyListeners();
  }

  set exerciseType(String value) {
    _exerciseType = value;
    notifyListeners();
  }

  void restart() {
    _currentExercise = 0;
    notifyListeners();
  }
}
