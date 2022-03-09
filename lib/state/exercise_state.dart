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
  int get lastExercise => _exercises.length - 1;
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
    _currentExercise++;
    _isBackwardButtonEnabled = true;
    if (_currentExercise == lastExercise) {
      _isForwardButtonEnabled = false;
    }
    notifyListeners();
  }

  void goBackward() {
    _currentExercise--;
    _isForwardButtonEnabled = true;
    if (_currentExercise == 0) {
      _isBackwardButtonEnabled = false;
    }
    notifyListeners();
  }

  set exerciseType(String value) {
    _exerciseType = value;
    notifyListeners();
  }
}
