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
  bool _isForwardButtonEnabled = true;
  bool _isBackwardButtonEnabled = false;
  String _exerciseType = "";
  UnmodifiableListView<ExerciseModel> get exercises =>
      UnmodifiableListView(_exercises);

  int get currentExercise => _currentExercise;
  bool get isForwardButtonEnabled => _isForwardButtonEnabled;
  bool get isBackwardButtonEnabled => _isBackwardButtonEnabled;
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
    var nextExercise = currentExercise + 1;
    _isBackwardButtonEnabled = true;
    if (nextExercise == lastExercise) {
      _currentExercise++;
      _isForwardButtonEnabled = false;
    } else {
      _currentExercise++;
    }
    notifyListeners();
  }

  void goBackward() {
    _isForwardButtonEnabled = true;
    if (_currentExercise == 0) {
      _isBackwardButtonEnabled = false;
    } else {
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
    _isForwardButtonEnabled = true;
    _isBackwardButtonEnabled = false;
    notifyListeners();
  }

  bool isLastExercise() {
    return _currentExercise == lastExercise;
  }
}
